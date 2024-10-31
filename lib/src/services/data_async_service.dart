import 'package:get/get.dart';

import '../data/models/venue_model.dart';
import '../data/sources/firebase/firebase_firestore_source.dart';
import 'authentication_service.dart';

class DataAsyncService extends GetxController implements GetxService {
  Future<List<VenueModel>> fetchVenueListFuture = Future.value([]);
  List<VenueModel> venueList = [];

  Future<List<VenueModel>> fetchVenueList() async {
    fetchVenueListFuture = FirebaseFirestoreSource().fetchVenueList(AuthService.instance.currentUserModel!.id);

    return fetchVenueListFuture.then((value) {
      venueList = value;
      update();
      return value;
    });
  }

  Future<DataAsyncService> init() async {
    return this;
  }

  static DataAsyncService get instance => Get.find<DataAsyncService>();
}
