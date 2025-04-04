import 'package:get/get.dart';
import 'package:pine_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:pine_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:pine_admin_panel/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/enums.dart';
import '../../models/order_model.dart';
import '../order/order_controller.dart';

class DashboardController extends PBaseController<OrderModel> {
  static DashboardController get instance => Get.find();

  final orderController = Get.put(OrderController());
  final customerController = Get.put(CustomerController());

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }


  @override
  Future<List<OrderModel>> fetchItems() async {

    if (orderController.allItems.isEmpty) {
      await orderController.fetchItems();
    }

    print('Orders Loaded: ${orderController.allItems.length} đơn hàng');

    if (customerController.allItems.isEmpty) {
      await customerController.fetchItems();
    }

    print('Orders Loaded: ${customerController.allItems.length} nguoi dung');

    _calculateWeeklySales();
    _calculateOrderStatusData();

    return orderController.allItems;
  }


  void _calculateWeeklySales() {
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orderController.allItems) {
      final DateTime orderWeekStart = PHelperFunctions.getStartOfWeek(order.orderDate);

      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;
      }
    }
  }

  void _calculateOrderStatusData() {
    orderStatusData.clear();
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orderController.allItems) {
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;
      totalAmounts[status] = (totalAmounts[status] ?? 0) + order.totalAmount;
    }
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Đang chuẩn bị';
      case OrderStatus.processing:
        return 'Đang xử lý';
      case OrderStatus.shipped:
        return 'Đang giao hàng';
      case OrderStatus.delivered:
        return 'Giao hàng thành công';
      case OrderStatus.cancelled:
        return 'Đã hủy đơn hàng';
      default:
        return 'Không xác định';
    }
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) => false;

  @override
  Future<void> deleteItem(OrderModel item) async {}
}
