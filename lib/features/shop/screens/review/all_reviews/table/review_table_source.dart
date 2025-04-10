import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:pine_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:pine_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:pine_admin_panel/routes/routes.dart';
import 'package:pine_admin_panel/utils/constants/colors.dart';
import 'package:pine_admin_panel/utils/constants/sizes.dart';
import 'package:pine_admin_panel/utils/helpers/helper_functions.dart';

import '../../../../../../utils/constants/enums.dart';
import '../../../../controllers/order/order_controller.dart';
import '../../../../controllers/review/review_controller.dart';



class ReviewRows extends DataTableSource {
  final controller = ReviewController.instance;

  @override
  DataRow? getRow(int index) {
    final order = controller.filteredItems[index];
    return DataRow2(
      onTap: () { Get.toNamed(PRoutes.reviewDetails);},
      cells: [
        DataCell(
          Text(
            "18273",
            style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: PColors.primary),
          ),
        ),
        DataCell(Text("Khách hàng")),
        DataCell(Text('[#1913]')),
        DataCell(Text("2 sản phẩm")),

        DataCell(Text("5")),
        DataCell(
          PTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () => Get.toNamed(PRoutes.reviewDetails),
            onDeletePressed: () {
              controller.confirmAndDeleteItem(order);
              controller.filteredItems.refresh();
            },
          )
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => 0;
}
