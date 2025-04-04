import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/features/shop/models/order_model.dart';
import '../../features/shop/controllers/dashboard/notification_controller.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final NotificationController _notificationController = Get.put(NotificationController());

  // Lấy tất cả đơn hàng của người dùng hiện tại
  Future<List<OrderModel>> getAllOrders() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return [];

    try {
      final result = await _db
          .collection("Users")
          .doc(userId)
          .collection("Orders")
          .orderBy('orderDate', descending: true)
          .get();
      return result.docs.map((querySnapshot) => OrderModel.fromSnapshot(querySnapshot)).toList();
    } catch (e) {
      print("🚨 Lỗi khi lấy đơn hàng: $e");
      return [];
    }
  }

  // Lấy tất cả đơn hàng của tất cả người dùng
  Future<List<OrderModel>> getAllOrdersForAllUsers() async {
    List<OrderModel> allOrders = [];

    try {
      // Lấy tất cả user
      final users = await _db.collection("Users").get();

      for (var user in users.docs) {
        final userId = user.id;

        // Lấy tất cả orders của user đó
        final orders = await _db
            .collection("Users")
            .doc(userId)
            .collection("Orders")
            .orderBy('orderDate', descending: true)
            .get();

        final orderList = orders.docs.map((querySnapshot) => OrderModel.fromSnapshot(querySnapshot)).toList();

        allOrders.addAll(orderList);
      }

      return allOrders;
    } catch (e) {
      print("🚨 Lỗi khi lấy tất cả đơn hàng: $e");
      return [];
    }
  }

  // Hàm thêm đơn hàng và gửi thông báo khi có đơn hàng mới
  Future<void> addOrder(OrderModel order) async {
    try {
      // Lưu đơn hàng vào Firestore
      await _db.collection("Users").doc(order.userId).collection("Orders").add(order.toJson());

      // Lưu thông báo vào Firestore (Collection "Notifications")
      await _db.collection("Notifications").add({
        'title': 'Đơn hàng mới',
        'message': 'Khách hàng ${order.userId} đã đặt một đơn hàng mới!',
        'isRead': false,
        'timestamp': FieldValue.serverTimestamp(), // Thời gian server
      });

      // Cập nhật thông báo mới trong ứng dụng
      _notificationController.addNotification(
        'Đơn hàng mới',
        'Khách hàng ${order.userId} đã đặt một đơn hàng mới!',
      );
    } on FirebaseException catch (e) {
      throw PFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const PFormatException();
    } on PlatformException catch (e) {
      throw PPlatformException(e.code).message;
    } catch (e) {
      throw 'Có lỗi xảy ra. Vui lòng thử lại';
    }
  }

  // Cập nhật giá trị cụ thể cho đơn hàng
  Future<void> updateOrderSpecificValue(String userId, String orderId, Map<String, dynamic> data) async {
    try {
      if (userId.isEmpty || orderId.isEmpty) {
        throw '⚠️ User ID hoặc Order ID không hợp lệ!';
      }

      print("🔥 Firestore Update: User ID: $userId, Order ID: $orderId, Data: $data");

      // Cập nhật thông tin vào Firestore
      await _db.collection("Users").doc(userId).collection("Orders").doc(orderId).update(data);
    } on FirebaseException catch (e) {
      throw 'Firebase Error: ${e.code}';
    } catch (e) {
      throw 'Lỗi không xác định khi cập nhật đơn hàng! Lỗi: $e';
    }
  }

  Future<void> deleteOrder(String userId, String orderId) async {
    try {
      // Đảm bảo bạn xóa đúng đơn hàng trong collection Orders của user
      await _db
          .collection("Users") // Collection chính của user
          .doc(userId) // ID của người dùng
          .collection("Orders") // Collection con chứa các đơn hàng
          .doc(orderId) // ID đơn hàng cần xóa
          .delete(); // Xóa document của đơn hàng

      print("🚀 Đơn hàng đã được xóa khỏi Firestore!");
    } on FirebaseException catch (e) {
      throw PFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const PFormatException();
    } on PlatformException catch (e) {
      throw PPlatformException(e.code).message;
    } catch (e) {
      throw 'Có lỗi khi xóa đơn hàng';
    }
  }

}
