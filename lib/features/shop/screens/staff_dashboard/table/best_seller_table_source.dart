import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pine_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:pine_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:pine_admin_panel/routes/routes.dart';
import 'package:pine_admin_panel/utils/constants/colors.dart';
import 'package:pine_admin_panel/utils/helpers/helper_functions.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../common/widgets/images/p_rounded_image.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../controllers/product/product_controller.dart';

class BestSellerRows extends DataTableSource {
  final controller = DashboardController.instance;
  final currencyFormatter = NumberFormat.simpleCurrency(locale: 'vi_VN', decimalDigits: 0);

  @override
  DataRow? getRow(int index) {
    final product = controller.bestSellers[index];

    return DataRow2(
      onTap: () => Get.toNamed(PRoutes.editProduct, arguments: product),
      cells: [
        // 1. Hình + Tên sản phẩm
        DataCell(Row(
          children: [
            PRoundedImage(
              width: 50,
              height: 50,
              padding: PSizes.xs,
              image: product.thumbnail,
              imageType: ImageType.network,
              borderRadius: PSizes.borderRadiusMd,
              backgroundColor: PColors.primaryBackground,
            ),
            const SizedBox(width: PSizes.spaceBtwItems),
            Flexible(
              child: Text(
                product.title,
                style: Theme.of(Get.context!).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )),

        // 2. Thương hiệu
        DataCell(
          Text(
            product.brand?.name ?? 'Không rõ',  // Thay `name` bằng thuộc tính tên trong BrandModel nếu cần
            style: Theme.of(Get.context!).textTheme.bodyMedium,
          ),
        ),


        // 3. Giá
        DataCell(Text(
          currencyFormatter.format(product.price),
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        )),

        // 4. Tồn kho
        DataCell(Text(
          '${product.stock ?? 0}',
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        )),

        // 5. Đã bán
        DataCell(Text(
          '${product.soldQuantity ?? 0}',
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.bestSellers.length;

  @override
  int get selectedRowCount => 0;
}

