// lib/data/models/payment_model.dart
class PaymentModel {
  final String id; // Unique ID for this payment record
  final String userId; // Connection: ID of the user who made the payment
  final String courseId; // Connection: ID of the course this payment is for
  final double amount;
  final String currency; // e.g., 'USD', 'EGP', 'EUR'
  final String paymentMethod; // e.g., 'Credit Card', 'PayPal', 'Vodafone Cash'
  final String transactionId; // ID from the payment gateway (e.g., Stripe, PayPal)
  final String status; // e.g., 'pending', 'completed', 'failed', 'refunded'
  final DateTime paymentDate; // Timestamp of when the payment occurred

  PaymentModel({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.amount,
    required this.currency,
    required this.paymentMethod,
    required this.transactionId,
    required this.status,
    required this.paymentDate,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      courseId: json['courseId'] as String,
      amount: (json['amount'] as num).toDouble(), // Ensure it's a double
      currency: json['currency'] as String,
      paymentMethod: json['paymentMethod'] as String,
      transactionId: json['transactionId'] as String,
      status: json['status'] as String,
      paymentDate: DateTime.parse(json['paymentDate'] as String), // Assuming ISO 8601 string
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'amount': amount,
      'currency': currency,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'status': status,
      'paymentDate': paymentDate.toIso8601String(), // Convert to ISO 8601 string
    };
  }

  PaymentModel copyWith({
    String? id,
    String? userId,
    String? courseId,
    double? amount,
    String? currency,
    String? paymentMethod,
    String? transactionId,
    String? status,
    DateTime? paymentDate,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
      status: status ?? this.status,
      paymentDate: paymentDate ?? this.paymentDate,
    );
  }

  @override
  String toString() {
    return 'PaymentModel(id: $id, userId: $userId, courseId: $courseId, amount: $amount, status: $status)';
  }
}