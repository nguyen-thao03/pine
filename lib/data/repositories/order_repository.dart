import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/features/shop/models/order_model.dart';

import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

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


  Future<void> addOrder(OrderModel order) async {
    try{
      await _db.collection("Orders").add(order.toJson());
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

  Future<void> updateOrderSpecificValue(String userId, String orderId, Map<String, dynamic> data) async {
    try {
      await _db.collection("Users").doc(userId).collection("Orders").doc(orderId).update(data);
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


  Future<void> deleteOrder(String orderId) async {
    try{
      await _db.collection("Orders").doc(orderId).delete();
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
}