// lib/modules/auth_module/controllers/auth_controller.dart
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore (for user profiles)
import 'package:shabakahub2025/data/models/user_model.dart';
import 'package:shabakahub2025/data/models/auth_request_model.dart';
import 'package:shabakahub2025/routes/app_routes.dart';
import 'package:shabakahub2025/utils/app_environment.dart'; // <--- CORRECTED: Import AppEnvironment instead of main.dart

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Rx<UserModel?> _currentUser = Rx<UserModel?>(null);
  UserModel? get currentUser => _currentUser.value;
  bool get isAuthenticated => _currentUser.value != null;

  final RxBool isLoading = false.obs;

  // Method to set the user from Firebase AuthStateChanges listener
  void setUser(UserModel? user) {
    _currentUser.value = user;
    if (user != null) {
      print('AuthController: User set - UID: ${user.id}, Email: ${user.email}');
    } else {
      print('AuthController: User set to null (signed out).');
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('AuthController initialized.');
  }

  // --- Login Logic with Firebase ---
  Future<void> login(LoginRequestModel request) async {
    isLoading.value = true;
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Update the AuthController's user state
        setUser(UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          name: firebaseUser.displayName,
          profileImageUrl: firebaseUser.photoURL,
          token: await firebaseUser.getIdToken(), // Get Firebase ID token
        ));
        Get.snackbar(
          'Success',
          'Logged in as ${request.email}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.onPrimary,
        );
        Get.offAllNamed(Routes.HOME); // Navigate to home after login
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else {
        message = e.message ?? 'An unknown authentication error occurred.';
      }
      Get.snackbar(
        'Login Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        'An unexpected error occurred: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --- Registration Logic with Firebase ---
  Future<void> register(RegisterRequestModel request) async {
    isLoading.value = true;
    try {
      // Client-side validation: passwords match
      if (request.password != request.confirmPassword) {
        throw Exception('Passwords do not match.');
      }

      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Optional: Store additional user data in Firestore
        final appId = AppEnvironment.appId ?? 'default-app-id'; // <--- CORRECTED: Use AppEnvironment.appId
        await _firestore.collection('artifacts').doc(appId).collection('users').doc(firebaseUser.uid).set({
          'email': request.email,
          'name': request.name,
          'createdAt': FieldValue.serverTimestamp(),
          // Add other profile fields as needed
        });

        // Update Firebase user profile (display name)
        await firebaseUser.updateDisplayName(request.name);

        // Update the AuthController's user state
        setUser(UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          name: request.name, // Use the name from registration
          profileImageUrl: firebaseUser.photoURL,
          token: await firebaseUser.getIdToken(),
        ));

        Get.snackbar(
          'Success',
          'Account created for ${request.email}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.onPrimary,
        );
        Get.offAllNamed(Routes.HOME); // Navigate to home after registration
      }
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        print(e.toString()+'Mozzzzzzzzzzza1');

        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print(e.toString()+'Mozzzzzzzzzzza2');

        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        print(e.toString()+'Mozzzzzzzzzzza3');

        message = 'The email address is not valid.';
      } else {
        message = e.message ?? 'An unknown registration error occurred.';
        print(e.toString()+message);

      }
      Get.snackbar(

        'Registration Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        'An unexpected error occurred: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --- Logout Logic with Firebase ---
  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _auth.signOut();
      setUser(null); // Clear the current user
      Get.snackbar(
        'Logged Out',
        'You have been logged out.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
      Get.offAllNamed(Routes.AUTH); // Navigate back to authentication screen
    } catch (e) {
      Get.snackbar(
        'Logout Failed',
        'An error occurred during logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // --- Password Reset (Optional, but good to include) ---
  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Password Reset',
        'Password reset email sent to $email. Check your inbox.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.primaryColor,
        colorText: Get.theme.colorScheme.onPrimary,
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else {
        message = e.message ?? 'An unknown error occurred.';
      }
      Get.snackbar(
        'Password Reset Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
