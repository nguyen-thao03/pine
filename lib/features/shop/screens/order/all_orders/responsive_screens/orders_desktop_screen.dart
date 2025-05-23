import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/common/widgets/loaders/loader_animation.dart';

import '../../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../../common/widgets/data_table/table_header.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/order/order_controller.dart';
import '../table/orders_table.dart';

class OrdersDesktopScreen extends StatelessWidget {
  const OrdersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const PBreadcrumbsWithHeading(
                heading: 'Đơn hàng',
                breadcrumbItems: ['Đơn hàng'],
              ),
              const SizedBox(height: PSizes.spaceBtwSections),

              // Table Body
              PRoundedContainer(
                child: Column(
                  children: [
                    // Table Header with Dropdown filter
                    Row(
                      children: [
                        // Dropdown lọc trạng thái đơn hàng
                        Obx(() => DropdownButton<String>(
                          value: controller.selectedStatus.value,
                          items: controller.orderStatuses.map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectedStatus.value = value;
                              controller.filterByStatus(value);
                            }
                          },
                        )),
                        const SizedBox(width: PSizes.spaceBtwItems),

                        // Search
                        Expanded(
                          child: PTableHeader(
                            showLeftWidget: false,
                            searchController: controller.searchTextController,
                            searchOnChanged: (query) => controller.searchQuery(query),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: PSizes.spaceBtwItems),

                    // Table
                    Obx(() {
                      if (controller.isLoading.value) return const PLoaderAnimation();
                      return const OrderTable();
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
