import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diacritic/diacritic.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:pine_admin_panel/data/repositories/coupon_repository.dart';

import '../../models/coupon_model.dart';

class CouponController extends PBaseController<CouponModel> {
  static CouponController get instance => Get.find();

  final _couponRepository = Get.put(CouponRepository());

  @override
  bool containsSearchQuery(CouponModel item, String query) {
    return item.couponCode.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(CouponModel item) async {
    await _couponRepository.deleteCoupon(item.id);
  }

  @override
  Future<List<CouponModel>> fetchItems() async {
    await fetchCouponsWithUsedCount(); // ✅ có usedCount
    return filteredItems;
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (CouponModel coupon) {
      return removeDiacritics(coupon.couponCode.toLowerCase());
    });
  }

  Future<void> fetchCouponsWithUsedCount() async {
    final now = DateTime.now();
    final snapshot = await FirebaseFirestore.instance.collection('Coupons').get();

    final coupons = await Future.wait(snapshot.docs.map((doc) async {
      CouponModel coupon = CouponModel.fromSnapshot(doc);
      final usedCount = await _couponRepository.getUsedCount(coupon.id);

      // Nếu đã hết hạn và vẫn đang bật thì tắt đi và cập nhật Firestore
      if (coupon.endDate != null && coupon.endDate!.isBefore(now) && coupon.status) {
        coupon = coupon.copyWith(status: false);
        await _couponRepository.updateCoupon(coupon); // cập nhật Firestore
      }

      return coupon.copyWith(usedCount: usedCount); // thêm usedCount để hiển thị
    }).toList());

    filteredItems.value = coupons;
  }

}