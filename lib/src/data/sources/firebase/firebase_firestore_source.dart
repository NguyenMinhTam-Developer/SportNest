import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/booking_model.dart';
import '../../models/customer_model.dart';
import '../../models/schedule.dart';
import '../../models/unit_model.dart';
import '../../models/unit_type_model.dart';
import '../../models/user_model.dart';
import '../../models/venue_model.dart';
import '../../params/create_booking_param.dart';
import '../../params/create_customer_param.dart';
import '../../params/update_booking_param.dart';
import '../../params/update_booking_status_param.dart';
import '../../params/update_customer_param.dart';

class FirebaseFirestoreSource {
  final _usersRef = FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  final _venuesRef = FirebaseFirestore.instance.collection('venues');

  final _unitsRef = FirebaseFirestore.instance.collection('units');

  final _bookingsRef = FirebaseFirestore.instance.collection('bookings');

  final _schedulesRef = FirebaseFirestore.instance.collection('schedules');

  final _unitTypesRef = FirebaseFirestore.instance.collection('unitTypes');

  final _customersRef = FirebaseFirestore.instance.collection('customers');

  Future<void> createUser(UserModel user) async {
    await _usersRef.doc(user.id).set(user);
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
    return _venuesRef.doc(id).get().then((value) {
      return VenueModel.fromJson(value.data()!);
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
      return value.docs.map((e) => UnitModel.fromJson(e.data())).toList();
    });
  }

  Future<UnitModel> fetchUnit(String id) async {
    return _unitsRef.doc(id).get().then((value) {
      return UnitModel.fromJson(value.data()!);
    });
  }

  Future<void> createUnit(UnitModel unit) async {
    return _unitsRef.add({}).then((value) {
      unit = unit.copyWith(id: value.id);
      return value.set(unit.toJson());
    });
  }

  Future<void> updateUnit(UnitModel unit) async {
    return _unitsRef.doc(unit.id).update(unit.toJson());
  }

  Future<void> deleteUnit(String id) async {
    return _unitsRef.doc(id).delete();
  }

  // ==================== Bookings ====================

  Future<List<BookingModel>> fetchBookingList(String venueId, {Timestamp? from, Timestamp? to}) async {
    var bookings = await _bookingsRef.where('venueId', isEqualTo: venueId).where('startTime', isGreaterThanOrEqualTo: from).where('endTime', isLessThanOrEqualTo: to).get().then((value) async {
      var bookings = value.docs.map((e) => BookingModel.fromDocumentSnapshot(e)).toList();

      var venueIds = bookings.map((e) => e.venueId).toSet();
      var unitIds = bookings.map((e) => e.unitId).toSet();
      var customerIds = bookings.map((e) => e.customerId).toSet();

      List<VenueModel> venues = await Future.wait(venueIds.map((e) => fetchVenue(e!)));
      List<UnitModel> units = await Future.wait(unitIds.map((e) => fetchUnit(e!)));
      List<CustomerModel> customers = await Future.wait(customerIds.map((e) => fetchCustomer(e!)));

      for (var i = 0; i < bookings.length; i++) {
        bookings[i].venue = venues[i];
        bookings[i].unit = units[i];
        bookings[i].customer = customers[i];
      }

      return bookings;
    });

    return bookings.toList();
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
    return _bookingsRef.doc(param.id).update(param.toJson()).then((value) {
      return fetchBooking(param.id);
    });
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
}
