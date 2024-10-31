import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/booking_model.dart';
import '../../models/customer_model.dart';
import '../../models/schedule.dart';
import '../../models/unit_model.dart';
import '../../models/unit_type_model.dart';
import '../../models/user_model.dart';
import '../../models/venue_model.dart';
import '../../models/feedback_model.dart';
import '../../params/create_booking_param.dart';
import '../../params/create_customer_param.dart';
import '../../params/update_booking_param.dart';
import '../../params/update_booking_payment_status_param.dart';
import '../../params/update_booking_status_param.dart';
import '../../params/update_customer_param.dart';
import '../../params/create_feedback_param.dart';

class FirebaseFirestoreSource {
  final _usersRef = FirebaseFirestore.instance.collection('users');

  final _venuesRef = FirebaseFirestore.instance.collection('venues');

  final _unitsRef = FirebaseFirestore.instance.collection('units');

  final _bookingsRef = FirebaseFirestore.instance.collection('bookings');

  final _schedulesRef = FirebaseFirestore.instance.collection('schedules');

  final _unitTypesRef = FirebaseFirestore.instance.collection('unitTypes');

  final _customersRef = FirebaseFirestore.instance.collection('customers');

  final _feedbacksRef = FirebaseFirestore.instance.collection('feedbacks');

  // ==================== Users ====================

  Future<void> createUser(UserModel user) async {
    await _usersRef.doc(user.id).set(user.toJson());
  }

  Future<UserModel?> fetchUser(String id) async {
    return _usersRef.doc(id).get().then((value) {
      return value.data() != null ? UserModel.fromFirestore(value) : null;
    });
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _usersRef.doc(user.id).update(user.toJson());
    } catch (e) {
      throw Exception('Failed to update user in Firestore: $e');
    }
  }

  // ==================== Venues ====================

  Future<List<VenueModel>> fetchVenueList(String createdBy) async {
    return _venuesRef.where('createdBy', isEqualTo: createdBy).get().then((value) async {
      var venues = value.docs.map((e) => VenueModel.fromJson(e.data())).toList();

      for (var venue in venues) {
        venue.unitList = await fetchUnitList(venue.id);
      }

      return venues;
    });
  }

  Future<VenueModel> fetchVenue(String id) async {
    return _venuesRef.doc(id).get().then((value) async {
      var venue = VenueModel.fromJson(value.data()!);

      venue.unitList = await fetchUnitList(venue.id);

      return venue;
    });
  }

  Future<void> createVenue(VenueModel venue) async {
    return _venuesRef.add({}).then((value) {
      venue = venue.copyWith(id: value.id);
      return value.set(venue.toJson());
    });
  }

  Future<void> updateVenue(VenueModel venue) async {
    return _venuesRef.doc(venue.id).update(venue.toJson());
  }

  Future<void> deleteVenue(String id) async {
    return _venuesRef.doc(id).delete();
  }

  // ==================== Units ====================

  Future<List<UnitModel>> fetchUnitList(String venueId) async {
    return _unitsRef.where('venueId', isEqualTo: venueId).get().then((value) {
      var unitList = value.docs.map((e) => UnitModel.fromFirestore(e)).toList();

      return unitList;
    });
  }

  Future<UnitModel> fetchUnit(String id) async {
    return _unitsRef.doc(id).get().then((value) {
      return UnitModel.fromFirestore(value);
    });
  }

  Future<UnitModel> createUnit(UnitModel unit) async {
    return _unitsRef.add(unit.toJson()).then((value) {
      unit = unit.copyWith(id: value.id);
      return unit;
    });
  }

  Future<UnitModel> updateUnit(UnitModel unit) async {
    await _unitsRef.doc(unit.id).update(unit.toJson());

    return fetchUnit(unit.id);
  }

  Future<void> deleteUnit(String id) async {
    return _unitsRef.doc(id).delete();
  }

  // ==================== Bookings ====================

  Future<List<BookingModel>> fetchBookingList(String venueId, {Timestamp? from, Timestamp? to}) async {
    Timestamp newTo = to == null ? Timestamp.now() : Timestamp.fromDate(to.toDate().add(const Duration(days: 1)));

    var bookings = await _bookingsRef.where('venueId', isEqualTo: venueId).where('startTime', isGreaterThanOrEqualTo: from).where('startTime', isLessThanOrEqualTo: newTo).get().then((value) async {
      var bookings = value.docs.map((e) => BookingModel.fromDocumentSnapshot(e)).toList();

      var customerIds = bookings.map((e) => e.customerId).toSet();

      VenueModel venue = await fetchVenue(venueId);

      List<CustomerModel> customers = await Future.wait(customerIds.map((e) => fetchCustomer(e!)));

      for (var i = 0; i < bookings.length; i++) {
        bookings[i].venue = venue;
        bookings[i].unit = venue.unitList.firstWhere((e) => e.id == bookings[i].unitId);
        bookings[i].customer = customers.firstWhere((e) => e.id == bookings[i].customerId);
      }

      return bookings;
    });

    return bookings.toList();
  }

  Future<List<BookingModel>> fetchUpcomingBookingList(String userId) async {
    try {
      // First get all venues created by user
      var venues = await _venuesRef.where('createdBy', isEqualTo: userId).get();
      var venueIds = venues.docs.map((e) => e.id).toList();

      // Get current timestamp
      var now = Timestamp.now();

      // Get bookings for all these venues
      var bookings = await _bookingsRef.where('venueId', whereIn: venueIds).where('startTime', isGreaterThanOrEqualTo: now).where('status', isEqualTo: 'confirmed').orderBy('startTime').limit(10).get();

      // Convert to booking models and populate related data
      var bookingList = await Future.wait(bookings.docs.map((doc) async {
        var booking = BookingModel.fromDocumentSnapshot(doc);

        booking.venue = await fetchVenue(booking.venueId!);
        booking.unit = await fetchUnit(booking.unitId!);
        booking.customer = await fetchCustomer(booking.customerId!);

        return booking;
      }));

      return bookingList;
    } catch (e) {
      return [];
    }
  }

  Future<BookingModel> fetchBooking(String id) async {
    return _bookingsRef.doc(id).get().then((value) async {
      var booking = BookingModel.fromDocumentSnapshot(value);

      booking.venue = await fetchVenue(booking.venueId!);
      booking.unit = await fetchUnit(booking.unitId!);
      booking.customer = await fetchCustomer(booking.customerId!);

      return booking;
    });
  }

  Future<BookingModel> createBooking(CreateBookingParam param) async {
    return _bookingsRef.add(param.toJson()).then((value) {
      return fetchBooking(value.id);
    });
  }

  Future<BookingModel> updateBooking(UpdateBookingParam param) async {
    return _bookingsRef.doc(param.id).update(param.toJson()).then((value) {
      return fetchBooking(param.id);
    });
  }

  Future<BookingModel> updateBookingStatus(UpdateBookingStatusParam param) async {
    try {
      await _bookingsRef.doc(param.id).update({'status': param.status.name});

      return await fetchBooking(param.id);
    } catch (e) {
      throw Exception('Failed to update booking status: $e');
    }
  }

  Future<BookingModel> updateBookingPaymentStatus(UpdateBookingPaymentStatusParam param) async {
    try {
      await _bookingsRef.doc(param.id).update(param.toJson());

      return await fetchBooking(param.id);
    } catch (e) {
      throw Exception('Failed to update booking payment status: $e');
    }
  }

  Future<void> deleteBooking(String id) async {
    return _bookingsRef.doc(id).delete();
  }

  // ==================== Schedules ====================

  Future<List<ScheduleModel>> fetchScheduleList(String venueId) async {
    return _schedulesRef.where('venueId', isEqualTo: venueId).get().then((value) {
      return value.docs.map((e) => ScheduleModel.fromJson(e.data())).toList();
    });
  }

  Future<ScheduleModel> fetchSchedule(String id) async {
    return _schedulesRef.doc(id).get().then((value) {
      return ScheduleModel.fromJson(value.data()!);
    });
  }

  Future<void> createSchedule(ScheduleModel schedule) async {
    return _schedulesRef.add({}).then((value) {
      schedule = schedule.copyWith(id: value.id);
      return value.set(schedule.toJson());
    });
  }

  Future<void> updateSchedule(ScheduleModel schedule) async {
    return _schedulesRef.doc(schedule.id).update(schedule.toJson());
  }

  Future<void> deleteSchedule(String id) async {
    return _schedulesRef.doc(id).delete();
  }

  Future<List<UnitTypeModel>> fetchUnitTypeList() async {
    return _unitTypesRef.get().then((value) {
      return value.docs.map((e) => UnitTypeModel.fromJson(e.data())).toList();
    });
  }

  // ==================== Customers ====================

  Future<List<CustomerModel>> fetchCustomerList(String createdBy) async {
    return _customersRef.where('createdBy', isEqualTo: createdBy).get().then((value) {
      return value.docs.map((e) => CustomerModel.fromDocumentSnapshot(e)).toList();
    });
  }

  Future<CustomerModel> fetchCustomer(String id) async {
    return _customersRef.doc(id).get().then((snapshot) {
      return CustomerModel.fromDocumentSnapshot(snapshot);
    });
  }

  Future<CustomerModel> createCustomer(CreateCustomerParam param) async {
    return _customersRef.add(param.toJson()).then((value) {
      return fetchCustomer(value.id);
    });
  }

  Future<CustomerModel> updateCustomer(UpdateCustomerParam param) async {
    return _customersRef.doc(param.id).update(param.toJson()).then((value) {
      return fetchCustomer(param.id);
    });
  }

  Future<void> deleteCustomer(String id) async {
    return _customersRef.doc(id).delete();
  }

  // Add this method inside FirebaseFirestoreSource class
  Future<List<BookingModel>> fetchBookingsByTimeFrame(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    // First get all venues created by user
    var venues = await _venuesRef.where('createdBy', isEqualTo: userId).get();
    var venueIds = venues.docs.map((e) => e.id).toList();

    if (venueIds.isEmpty) return [];

    // Convert DateTime to Timestamp
    var startTimestamp = Timestamp.fromDate(startDate);
    var endTimestamp = Timestamp.fromDate(endDate);

    // Get bookings for all these venues within the time frame
    var bookings = await _bookingsRef.where('venueId', whereIn: venueIds).where('startTime', isGreaterThanOrEqualTo: startTimestamp).where('startTime', isLessThanOrEqualTo: endTimestamp).get();

    // Convert to booking models and populate related data
    var bookingList = await Future.wait(bookings.docs.map((doc) async {
      var booking = BookingModel.fromDocumentSnapshot(doc);
      booking.venue = await fetchVenue(booking.venueId!);
      booking.unit = await fetchUnit(booking.unitId!);
      booking.customer = await fetchCustomer(booking.customerId!);
      return booking;
    }));

    return bookingList;
  }

  Future<FeedbackModel> createFeedback(
    CreateFeedbackParam param,
    List<String> imageUrls,
    String? videoUrl,
  ) async {
    var data = param.toJson();
    data['imageUrls'] = imageUrls;
    data['videoUrl'] = videoUrl;

    var docRef = await _feedbacksRef.add(data);
    var doc = await docRef.get();

    return FeedbackModel.fromFirestore(doc);
  }

  Future<List<FeedbackModel>> fetchUserFeedbacks(String userId) async {
    var snapshots = await _feedbacksRef.where('userId', isEqualTo: userId).orderBy('createdAt', descending: true).get();

    return snapshots.docs.map((doc) => FeedbackModel.fromFirestore(doc)).toList();
  }
}
