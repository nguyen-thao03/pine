import 'package:flutter/material.dart';
import 'package:pine_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:pine_admin_panel/features/shop/screens/coupon/create_coupon/responsive_screens/create_coupon_desktop.dart';
import 'package:pine_admin_panel/features/shop/screens/coupon/create_coupon/responsive_screens/create_coupon_mobile.dart';
import 'package:pine_admin_panel/features/shop/screens/coupon/create_coupon/responsive_screens/create_coupon_tablet.dart';
class CreateCouponScreen extends StatelessWidget {
  const CreateCouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PSiteTemplate(desktop: CreateCouponDesktopScreen(), tablet: CreateCouponTabletScreen(), mobile: CreateCouponMobileScreen());
  }
}
