import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../authentication/models/user_model.dart';
import '../../../../models/order_model.dart';
import '../widgets/customer_info.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transaction.dart';

class OrderDetailTabletScreen extends StatelessWidget {
  const OrderDetailTabletScreen({super.key, required this.order});

  final OrderModel order;

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
              PBreadcrumbsWithHeading(
                  returnToPreviousScreen: true,
                  heading: order.id,
                  breadcrumbItems: [PRoutes.orders, 'Chi tiết']
              ),
              const SizedBox(height: PSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side Order Information
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Order Info
                          OrderInfo(order: order),
                          const SizedBox(height: PSizes.spaceBtwSections),

                          // Items
                          OrderItems(order: order),
                          const SizedBox(height: PSizes.spaceBtwSections),

                          // Transactions
                          OrderTransaction(order: order)
                        ],
                      )
                  ),
                  const SizedBox(width: PSizes.spaceBtwSections),

                  // Right Side Order Orders
                  Expanded(
                      child: Column(
                        children: [
                          // Customer Info
                          OrderCustomer(order: order),
                          const SizedBox(width: PSizes.spaceBtwSections),
                        ],
                      )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
