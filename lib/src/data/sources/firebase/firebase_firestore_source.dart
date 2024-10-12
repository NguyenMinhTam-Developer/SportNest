import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/booking_model.dart';

import '../../models/schedule.dart';
import '../../models/unit_model.dart';
import '../../models/unit_type_model.dart';
import '../../models/user_model.dart';
import '../../models/venue_model.dart';

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

  Future<void> createUser(UserModel user) async {
    await _usersRef.doc(user.id).set(user);
  }

  // Venues
  Future<List<VenueModel>> fetchVenueList(String createdBy) async {
    return _venuesRef.where('createdBy', isEqualTo: createdBy).get().then((value) {
      return value.docs.map((e) => VenueModel.fromJson(e.data())).toList();
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

  // Units
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

  // Bookings
  Future<List<BookingModel>> fetchBookingList(String venueId) async {
    // Fetch bookings
    var bookings = await _bookingsRef.where('venueId', isEqualTo: venueId).get().then((value) {
      return value.docs.map((e) => BookingModel.fromJson(e.data())).toList();
    });

    // Get venue
    var venue = await fetchVenue(venueId);
    var units = await fetchUnitList(venueId);

    // Add venue to each booking
    return bookings
        .map(
          (booking) => booking.copyWith(
            venue: venue,
            unit: units.firstWhere(
              (element) => element.id == booking.unitId,
            ),
          ),
        )
        .toList();
  }

  Future<BookingModel> fetchBooking(String id) async {
    return _bookingsRef.doc(id).get().then((value) async {
      var booking = BookingModel.fromJson(value.data()!);

      var venue = await fetchVenue(booking.venueId);
      var unit = await fetchUnit(booking.unitId);

      booking = booking.copyWith(venue: venue, unit: unit);

      return booking;
    });
  }

  Future<void> createBooking(BookingModel booking) async {
    return _bookingsRef.add({}).then((value) {
      booking = booking.copyWith(id: value.id);
      return value.set(booking.toJson());
    });
  }

  Future<void> updateBooking(BookingModel booking) async {
    return _bookingsRef.doc(booking.id).update(booking.toJson());
  }

  Future<void> deleteBooking(String id) async {
    return _bookingsRef.doc(id).delete();
  }

  // Schedules
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
}
