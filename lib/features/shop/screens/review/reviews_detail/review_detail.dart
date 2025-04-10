import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:pine_admin_panel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_desktop.dart';
import 'package:pine_admin_panel/features/shop/screens/review/reviews_detail/responsive_screens/review_detail_desktop.dart';

class ReviewDetailScreen extends StatelessWidget {
  const ReviewDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Get.arguments;
    final orderId = Get.parameters['orderId'];
    return PSiteTemplate(desktop: ReviewDetailDesktopScreen(order: order));
  }
}
