import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shabakahub2025/presentation/modules/auth_module/controllers/auth_controller.dart';
import 'package:shabakahub2025/routes/app_pages.dart';
import 'package:shabakahub2025/routes/app_routes.dart';
import 'dart:convert';
import 'package:shabakahub2025/utils/app_colors.dart';
import 'package:shabakahub2025/utils/app_environment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// NEW: Import the AppBinding
import 'package:shabakahub2025/routes/app_binding.dart';

// NEW: Import the locally generated firebase_options.dart file
import 'package:shabakahub2025/firebase_options.dart';

import 'data/models/user_model.dart';

// Global variables provided by the environment (DO NOT MODIFY THESE DECLARATIONS)
var __firebase_config;
var __initial_auth_token;
var __app_id;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('main.dart: WidgetsFlutterBinding initialized.');

  await GetStorage.init();
  print('main.dart: GetStorage initialized.');

  // Initialize AppEnvironment with the global variables
  AppEnvironment.initialize(
    configJson: __firebase_config,
    authToken: __initial_auth_token,
    applicationId: __app_id ?? 'default-app-id', // CRUCIAL FIX: Use 'default-app-id' if __app_id is null
  );
  print('main.dart: AppEnvironment initialized: App ID = ${AppEnvironment.appId}');

  // Initialize Firebase using the locally generated firebase_options.dart
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Using local options
    );
    print('main.dart: Firebase initialized successfully using DefaultFirebaseOptions!');

    // --- AuthController initialization and Firebase Auth logic ---
    // AuthController is now put permanently in AppBinding, so this line is removed.
    // Get.put<AuthController>(AuthController(), permanent: true);
    // print('main.dart: AuthController put into GetX.');

    final auth = FirebaseAuth.instance;
    print('main.dart: Attempting initial Firebase sign-in...');
    try {
      // Use signInWithCustomToken if available, otherwise signInAnonymously
      if (AppEnvironment.initialAuthToken != null && AppEnvironment.initialAuthToken!.isNotEmpty) {
        await auth.signInWithCustomToken(AppEnvironment.initialAuthToken!);
        print('main.dart: Signed in with custom token!');
      } else {
        await auth.signInAnonymously();
        print('main.dart: Signed in anonymously!');
      }
    } catch (e) {
      print('main.dart: ERROR during initial sign-in: $e');
    }

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // Use Get.find() to get the AuthController instance that was put by AppBinding
      final authController = Get.find<AuthController>();
      if (user == null) {
        print('main.dart: Firebase Auth State: User is currently signed out!');
        authController.setUser(null);
      } else {
        print('main.dart: Firebase Auth State: User is signed in! UID: ${user.uid}');
        authController.setUser(UserModel(
          id: user.uid,
          email: user.email ?? 'N/A',
          name: user.displayName,
          profileImageUrl: user.photoURL,
          token: user.refreshToken,
        ));
      }
    });
    print('main.dart: Firebase authStateChanges listener set up.');
    // --- END AuthController initialization and Firebase Auth logic ---

  } catch (e) {
    print('main.dart: Firebase initialization error: $e');
  }

  runApp(const MyApp());
  print('main.dart: runApp called.');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('MyApp: build called. Initial Route: ${AppPages.INITIAL}');
    return GetMaterialApp(
      title: 'Shabaka Hub',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: AppBinding(), // <--- This is where you call AppBinding
      theme: ThemeData(
        // Use a color scheme based on the logo's orange and black.
        // The primary swatch is less important with colorScheme,
        // so we'll leave it as blue for now and let the colorScheme
        // define the main palette.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          // Use the primary orange from the logo as the seed color
          seedColor: AppColors.primaryOrange,
          primary: AppColors.primaryOrange, // The main brand color
          onPrimary: AppColors.hubWhite, // Text color on top of the primary color
          secondary: AppColors.hubBlack, // A dark color for secondary elements
          onSecondary: AppColors.hubWhite, // Text color on top of the secondary color
          surface: AppColors.hubWhite, // Use white for card/surface backgrounds
          onSurface: AppColors.textColor, // Text color on top of surfaces
          background: AppColors.lightBackground, // A light, off-white for the background
          onBackground: AppColors.textColor, // Text color on top of the background
          error: AppColors.errorColor,
          onError: AppColors.hubWhite,
          brightness: Brightness.light,
        ),
        // Use a consistent background color that is not stark white
        scaffoldBackgroundColor: AppColors.lightBackground,
        appBarTheme: const AppBarTheme(
          // Use the brand orange for the app bar
          backgroundColor: AppColors.primaryOrange,
          foregroundColor: AppColors.hubWhite, // White text/icons on the orange app bar
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          // Use the brand black for the text
          bodyLarge: TextStyle(color: AppColors.textColor),
          bodyMedium: TextStyle(color: AppColors.textColor),
          bodySmall: TextStyle(color: AppColors.textColor),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            // Style buttons to match the brand orange and white
            foregroundColor: AppColors.hubWhite,
            backgroundColor: AppColors.primaryOrange,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
