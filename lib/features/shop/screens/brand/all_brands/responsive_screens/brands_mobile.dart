import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../table/data_table.dart';

class BrandsMobileScreen extends StatelessWidget {
  const BrandsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const PBreadcrumbsWithHeading(heading: 'Thương hiệu', breadcrumbItems: ['Thương hiệu']),
              const SizedBox(height: PSizes.spaceBtwSections),

              // Table Body
              // Show Loader
              Obx(() {
                return PRoundedContainer(
                  child: Column(
                    children: [
                      // Table Header
                      PTableHeader(buttonText: 'Thêm thương hiệu', onPressed: () => Get.toNamed(PRoutes.createBrand)),
                      const SizedBox(height: PSizes.spaceBtwItems),

                      // Table
                      const BrandTable(),
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
