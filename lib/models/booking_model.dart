import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String serviceName;
  final double servicePrice;
  final DateTime bookingDate;
  final String userId;

  BookingModel({
    required this.id,
    required this.serviceName,
    required this.servicePrice,
    required this.bookingDate,
    required this.userId,
  });

  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      serviceName: data['serviceName'] ?? '',
      servicePrice: (data['servicePrice'] ?? 0.0).toDouble(),
      bookingDate: (data['bookingDate'] as Timestamp).toDate(),
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceName': serviceName,
      'servicePrice': servicePrice,
      'bookingDate': Timestamp.fromDate(bookingDate),
      'userId': userId,
    };
  }
}
