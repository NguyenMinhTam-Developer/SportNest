import 'package:get/get.dart';

import '../../../../core/routes/pages.dart';
import '../../../../data/models/customer_model.dart';
import '../../../../data/sources/firebase/firebase_firestore_source.dart';
import 'customer_list_page_controller.dart';

class CustomerDetailPageController extends GetxController {
  Future<CustomerModel>? fetchCustomerFuture;
  CustomerModel? customer;

  Future<void> fetchCustomer(String id) async {
    fetchCustomerFuture = FirebaseFirestoreSource().fetchCustomer(id);
    customer = await fetchCustomerFuture;
    update();
  }

  Future<void> onEditPressed(CustomerModel customer) async {
    customer = await Get.toNamed(
      Routes.customerEdit.replaceFirst(':customerId', customer.id),
      arguments: customer,
    );

    CustomerListPageController.instance.fetchCustomers();

    update();
  }

  Future<void> deleteCustomer() async {
    await FirebaseFirestoreSource().deleteCustomer(customer!.id);

    await CustomerListPageController.instance.fetchCustomers();

    Get.back();
  }

  @override
  void onInit() {
    fetchCustomer(Get.parameters['customerId']!);
    super.onInit();
  }

  static CustomerDetailPageController get instance {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(CustomerDetailPageController());
    }
  }
}

class CustomerDetailPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerDetailPageController>(() => CustomerDetailPageController());
  }
}
