import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/category/category_controller.dart';
import '../../../../controllers/coupon/coupon_controller.dart';
import '../table/coupon_table.dart';

class CouponsMobileScreen extends StatelessWidget {
  const CouponsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CouponController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const PBreadcrumbsWithHeading(heading: 'Mã giảm giá', breadcrumbItems: ['Mã giảm giá']),
              const SizedBox(height: PSizes.spaceBtwSections),

              // Table Body
              // Show Loader
              Obx(() {
                 return PRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      PTableHeader(buttonText: 'Tạo danh mục',
                          onPressed: () => Get.toNamed(PRoutes.createCoupon),
                          searchController: controller.searchTextController,
                          searchOnChanged: (query) => controller.searchQuery(query)
                      ),
                      const SizedBox(height: PSizes.spaceBtwItems),

                      // Table
                      const CouponTable(),
                    ],
                  ),
                );
              }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
