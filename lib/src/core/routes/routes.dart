part of 'pages.dart';

abstract class Routes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';

  static const signIn = '/sign-in';
  static const signUp = '/sign-up';

  static const home = '/';

  static const profileEdit = '/profile/edit';

  static const _venues = '/venues';
  static const venues = _venues;
  static const createVenue = '$_venues/create';
  static const venueDetail = '$_venues/:venueId';
  static const venueEdit = '$_venues/:venueId/edit';

  static const _bookings = '$venueDetail/bookings';
  static const bookings = _bookings;
  static const bookingCreate = '$_bookings/create';
  static const bookingDetail = '$_bookings/:bookingId';
  static const bookingEdit = '$_bookings/:bookingId/edit';

  static const _schedules = '/schedules';
  static const schedules = _schedules;
  static const scheduleCreate = '$_schedules/create';
  static const scheduleDetail = '$_schedules/detail';
  static const scheduleEdit = '$_schedules/edit';

  static const _units = '$venueDetail/units';
  static const units = _units;
  static const unitCreate = '$_units/create';
  static const unitDetail = '$_units/:unitId';
  static const unitEdit = '$_units/:unitId/edit';
}
