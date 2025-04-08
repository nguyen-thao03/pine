import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pine_admin_panel/routes/routes.dart';
import 'package:pine_admin_panel/utils/device/device_utility.dart';

class SidebarController extends GetxController {
  final box = GetStorage();
  final activeItem = "".obs;
  final hoverItem = ''.obs;

  late String userRole;
  final allowedStaffRoutes = [
    PRoutes.staffDashboard,
    PRoutes.media,
    PRoutes.categories, PRoutes.createCategory, PRoutes.editCategory,
    PRoutes.brands, PRoutes.createBrand, PRoutes.editBrand,
    PRoutes.products, PRoutes.createProduct, PRoutes.editProduct,
    PRoutes.orders, PRoutes.orderDetails,
    PRoutes.profile, PRoutes.login
  ];

  @override
  void onInit() {
    super.onInit();
    userRole = box.read("Role") ?? 'staff';
    final savedRoute = box.read("activeItem");
    if (userRole == 'staff' && !allowedStaffRoutes.contains(savedRoute)) {
      activeItem.value = PRoutes.staffDashboard;
    } else {
      activeItem.value = savedRoute ?? _defaultRouteForRole();
    }
  }

  String _defaultRouteForRole() {
    return userRole == 'admin' ? PRoutes.dashboard : PRoutes.staffDashboard;
  }

  void changeActiveItem(String route) {
    activeItem.value = route;
    box.write("activeItem", route);
  }

  void changeHoverItem(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  bool isActive(String route) => activeItem.value == route;
  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (userRole == 'staff' && !allowedStaffRoutes.contains(route)) {
      Get.snackbar('Không được phép', 'Bạn không có quyền truy cập đường dẫn này');
      return;
    }

    if (!isActive(route)) {
      changeActiveItem(route);

      if (PDeviceUtils.isMobileScreen(Get.context!)) Get.back();

      Get.toNamed(route);
    }
  }
}
