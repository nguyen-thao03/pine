import 'package:flutter/material.dart';
import 'package:pine_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:pine_admin_panel/features/personalization/models/user_model.dart';
import 'package:pine_admin_panel/features/shop/models/order_model.dart';
import 'package:pine_admin_panel/utils/constants/sizes.dart';

import '../../../../../../../routes/routes.dart';
import '../../../../models/review_model.dart';
import '../widgets/customer_info.dart';
import '../widgets/order_info.dart';
import '../widgets/order_items.dart';
import '../widgets/order_transaction.dart';

class ReviewDetailDesktopScreen extends StatelessWidget {
  const ReviewDetailDesktopScreen({super.key, required this.order});

  final ReviewModel order;

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
                  heading: 'order.id',
                  breadcrumbItems: [{ 'label': 'Danh sách đơn hàng', 'path': PRoutes.orders }, 'Chi tiết']
              ),
              const SizedBox(height: PSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side Review Information
                  Expanded(
                    flex: 2,
                      child: Column(
                        children: [
                          // Review Info
                         // ReviewInfo(order: order),
                          const SizedBox(height: PSizes.spaceBtwSections),

                          // Items
                          //ReviewItems(order: order),
                          const SizedBox(height: PSizes.spaceBtwSections),

                          // Transactions
                         // ReviewTransaction(order: order)
                        ],
                      )
                  ),
                  const SizedBox(width: PSizes.spaceBtwSections),

                  // Right Side Review Reviews
                  Expanded(
                      child: Column(
                        children: [
                          // Customer Info
                          //ReviewCustomer(order: order),
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
