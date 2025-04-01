import 'package:get/get.dart';
import 'package:pine_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:pine_admin_panel/data/repositories/order_repository.dart';
import 'package:pine_admin_panel/features/shop/models/order_model.dart';
import 'package:pine_admin_panel/utils/constants/enums.dart';
import 'package:pine_admin_panel/utils/popups/loaders.dart';

class OrderController extends PBaseController<OrderModel> {
  static OrderController get instance => Get.find();

  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final _orderRepository = Get.put(OrderRepository());

  @override
  Future<List<OrderModel>> fetchItems() async {
    sortAscending.value = false;
    final orders = await _orderRepository.getAllOrdersForAllUsers();

    allItems.assignAll(orders);

    return orders;
  }



  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (OrderModel o) => o.totalAmount.toString().toLowerCase());
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (OrderModel o) => o.orderDate.toString().toLowerCase());
  }

  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValue(order.userId, order.docId, {'status': newStatus.name});

      updateItemFromLists(order);
      orderStatus.value = newStatus;
      PLoaders.successSnackBar(title: 'Đã cập nhật', message: 'Đã cập nhật trạng thái đơn hàng');
    } catch (e) {
      PLoaders.warningSnackBar(title: 'Ôi không!', message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }
}