import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/data/repositories/user_repository.dart';
import 'package:pine_admin_panel/features/personalization/models/user_model.dart';
import 'package:pine_admin_panel/features/shop/models/order_model.dart';
import 'package:pine_admin_panel/utils/popups/loaders.dart';

import '../../../../data/repositories/address_repository.dart';

class CustomerDetailController extends GetxController {
  static CustomerDetailController get instance => Get.find();

  RxBool ordersLoading = true.obs;
  RxBool addressesLoading = true.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

  Future<void> getCustomerOrders() async {
    try {
      ordersLoading.value = true;
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders = await UserRepository.instance.fetchUserOrders(customer.value.id!);
      }
      allCustomerOrders.assignAll(customer.value.orders ?? []);
      filteredCustomerOrders.assignAll(customer.value.orders ?? []);
    } catch (e) {
      PLoaders.errorSnackBar(title: 'Ôi không!', message: e.toString());
    } finally {
      ordersLoading.value = false;
    }
  }

  Future<void> getCustomerAddresses() async {
    try {
      addressesLoading.value = true;
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.addresses = await addressRepository.fetchUserAddresses(customer.value.id!);
        }

    } catch (e) {
      PLoaders.errorSnackBar(title: 'Ôi không!', message: e.toString());
    } finally {
      addressesLoading.value = false;
    }
  }


  void searchQuery(String query) {
    filteredCustomerOrders.assignAll(
      allCustomerOrders.where((customer) =>
      customer.id.toLowerCase().contains(query.toLowerCase()) || customer.orderDate.toString().contains(query.toLowerCase())),
    );
    update();
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortAscending.value = ascending;
    filteredCustomerOrders.sort((a, b) {
      if (ascending) {
        return a.id.toLowerCase().compareTo(b.id.toLowerCase());
      } else {
        return b.id.toLowerCase().compareTo(a.id.toLowerCase());
      }
    });
    this.sortColumnIndex.value = sortColumnIndex;

    update();
  }
}