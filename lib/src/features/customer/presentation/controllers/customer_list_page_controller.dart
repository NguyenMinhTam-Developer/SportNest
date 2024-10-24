import 'package:get/get.dart';

import '../../../../core/routes/pages.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import '../../../../services/authentication_service.dart';

class CustomerListPageController extends GetxController {
  Future<List<CustomerModel>>? fetchCustomerListFuture;
  RxList<CustomerModel> filteredCustomers = <CustomerModel>[].obs;
  List<CustomerModel> allCustomers = [];

  bool isSelectMode = Get.arguments ?? false;

  Future<void> fetchCustomers() async {
    fetchCustomerListFuture = FirebaseFirestoreSource().fetchCustomerList(AuthService.instance.currentUser!.uid);
    allCustomers = await fetchCustomerListFuture ?? [];
    filteredCustomers.value = allCustomers;
    update();
  }

  void searchCustomers(String query) {
    if (query.isEmpty) {
      filteredCustomers.value = allCustomers;
    } else {
      filteredCustomers.value = allCustomers.where((customer) => customer.name.toLowerCase().contains(query.toLowerCase()) || customer.phoneNumber.contains(query)).toList();
    }
  }

  @override
  void onInit() {
    fetchCustomers();
    super.onInit();
  }

  static CustomerListPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(CustomerListPageController());
    }
  }

  Future<void> onAddCustomerPressed() async {
    var result = await Get.toNamed(Routes.customerCreate);

    if (result == true) {
      fetchCustomers();
    }
  }
}

class CustomerListPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerListPageController>(() => CustomerListPageController());
  }
}
