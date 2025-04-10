import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:pine_admin_panel/data/repositories/order_repository.dart';
import 'package:pine_admin_panel/features/shop/models/order_model.dart';
import 'package:pine_admin_panel/utils/constants/enums.dart';
import 'package:pine_admin_panel/utils/popups/loaders.dart';

import '../../models/review_model.dart';

class ReviewController extends PBaseController<ReviewModel> {
  static ReviewController get instance => Get.find();

  @override
  bool containsSearchQuery(ReviewModel item, String query) {
    // TODO: implement containsSearchQuery
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItem(ReviewModel item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<List<ReviewModel>> fetchItems() {
    // TODO: implement fetchItems
    throw UnimplementedError();
  }



}
