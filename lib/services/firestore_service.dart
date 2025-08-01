import 'package:barbearia_rei_du_corte/models/booking_model.dart';
import 'package:barbearia_rei_du_corte/models/service_model.dart';
import 'package:barbearia_rei_du_corte/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(String uid, String name, String email) {
    return _db.collection('users').doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  Stream<List<ServiceModel>> getServices() {
    return _db.collection('services').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => ServiceModel.fromFirestore(doc))
        .toList());
  }

  Future<void> createBooking(BookingModel booking) {
    return _db.collection('bookings').add(booking.toMap());
  }

  Stream<List<BookingModel>> getBookings() {
    final user = AuthService().getCurrentUser();
    if (user == null) {
      return Stream.value([]);
    }
    return _db
        .collection('bookings')
        .where('userId', isEqualTo: user.uid)
        .orderBy('bookingDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => BookingModel.fromFirestore(doc))
        .toList());
  }

  Future<void> deleteBooking(String bookingId) {
    return _db.collection('bookings').doc(bookingId).delete();
  }
}
