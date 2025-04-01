import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pine_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:pine_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:pine_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';
import '../table/dashboard_table.dart';
import '../widgets/dashboard_card.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(PSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                Text('Bảng điều khiển', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: PSizes.spaceBtwSections),

                // Cards
                 Row(
                  children: [
                    Expanded(child: Obx(
                          () => PDashboardCard(
                          headingIcon: Iconsax.note,
                          headingIconColor: Colors.blue,
                          headingIconBgColor: Colors.blue.withValues(alpha: 0.1),
                          context: context,
                          title: 'Tổng doanh số',
                          subTitle: '${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount)}',
                          stats: 25),
                    ),),
                    SizedBox(width: PSizes.spaceBtwItems),
                    Expanded(child: Obx(
                          () => PDashboardCard(
                        headingIcon: Iconsax.external_drive,
                        headingIconColor: Colors.green,
                        headingIconBgColor: Colors.green.withValues(alpha: 0.1),
                        context: context,
                        title: 'Giá trị đơn hàng trung bình',
                        subTitle: '${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length)}',
                        stats: 15,
                        icon: Iconsax.arrow_down,
                        color: PColors.error,
                      ),
                    ),),
                  ],
                ),
                const SizedBox(height: PSizes.spaceBtwItems),
                Row(
                  children: [
                    Expanded(child: Obx(
                          () => PDashboardCard(
                          headingIcon: Iconsax.box,
                          headingIconColor: Colors.deepPurple,
                          headingIconBgColor: Colors.deepPurple.withValues(alpha: 0.1),
                          context: context,
                          title: 'Tổng đơn hàng',
                          subTitle: '${controller.orderController.allItems.length}',
                          stats: 44),
                    ),),
                    SizedBox(width: PSizes.spaceBtwItems),
                    Expanded(child: PDashboardCard(
                        headingIcon: Iconsax.user,
                        headingIconColor: Colors.deepOrange,
                        headingIconBgColor: Colors.deepOrange.withValues(alpha: 0.1),
                        context: context,
                        title: 'Người dùng',
                        subTitle: controller.customerController.allItems.length.toString(),
                        stats: 2),),
                  ],
                ),
                const SizedBox(height: PSizes.spaceBtwSections),

                /// Bar Graph
                const PWeeklySalesGraph(),
                const SizedBox(height: PSizes.spaceBtwSections),

                /// Orders
                PRoundedContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Đơn hàng gần đây', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: PSizes.spaceBtwSections),
                      const DashboardOrderTable(),
                    ],
                  ),
                ),
                const SizedBox(height: PSizes.spaceBtwSections),

                /// Pie Chart
                const OrderStatusPieChart(),
              ],
            ),
        ),
      ),
    );
  }
}
