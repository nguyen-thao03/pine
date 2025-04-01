import 'package:flutter/material.dart';
import 'package:pine_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:pine_admin_panel/common/widgets/images/p_rounded_image.dart';
import 'package:pine_admin_panel/features/personalization/models/user_model.dart';
import 'package:pine_admin_panel/utils/constants/enums.dart';
import 'package:pine_admin_panel/utils/constants/image_strings.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return PRoundedContainer(
      padding: const EdgeInsets.all(PSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Thông tin người dùng', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: PSizes.spaceBtwSections),

          // Personal Info Card
          Row(
            children: [
              PRoundedImage(
                padding: 0,
                  backgroundColor: PColors.primaryBackground,
                  image: customer.profilePicture.isNotEmpty ? customer.profilePicture : PImages.user,
                  imageType: customer.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
              ),
              const SizedBox(width: PSizes.spaceBtwItems),
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customer.fullName, style: Theme.of(context).textTheme.titleLarge, overflow: TextOverflow.ellipsis, maxLines: 1),
                      Text(customer.email, overflow: TextOverflow.ellipsis, maxLines: 1),
                    ],
                  )
              )
            ],
          ),
          const SizedBox(height: PSizes.spaceBtwSections),

          // Meta Data
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Tên người dùng')),
              const Text(':'),
              const SizedBox(width: PSizes.spaceBtwItems / 2),
              Expanded(child: Text(customer.userName, style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: PSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Địa chỉ')),
              const Text(':'),
              const SizedBox(width: PSizes.spaceBtwItems / 2),
              Expanded(child: Text('Việt Nam', style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: PSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Số điện thoại')),
              const Text(':'),
              const SizedBox(width: PSizes.spaceBtwItems / 2),
              Expanded(child: Text(customer.phoneNumber, style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: PSizes.spaceBtwItems),

          // Divider
          const Divider(),
          const SizedBox(height: PSizes.spaceBtwItems),

          // Additional Details
          Row(
            children: [
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Đơn hàng gần đây nhất', style: Theme.of(context).textTheme.titleLarge),
                      const Text('7 ngày trước, #[36d54]'),
                    ],
                  )
              ),
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Trung bình giá trị đơn hàng', style: Theme.of(context).textTheme.titleLarge),
                      const Text('300,000đ'),
                    ],
                  )
              ),
            ],
          ),
          const SizedBox(height: PSizes.spaceBtwItems),

          // Additional Details Cont.
          Row(
            children: [
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Đăng ký', style: Theme.of(context).textTheme.titleLarge),
                      Text(customer.formattedDate),
                    ],
                  )
              ),
              Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hỗ trợ qua Email', style: Theme.of(context).textTheme.titleLarge),
                      const Text('Đã đăng ký'),
                    ],
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
