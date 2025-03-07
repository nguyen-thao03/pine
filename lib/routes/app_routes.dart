import 'package:get/get.dart';
import 'package:pine_admin_panel/routes/routes.dart';
import 'package:pine_admin_panel/routes/routes_middleware.dart';

import '../features/media/screens/media/media.dart';
import '../features/shop/screens/brand/all_brands/brands.dart';
import '../features/shop/screens/brand/create_brand/create_brand.dart';
import '../features/shop/screens/brand/edit_brand/edit_brand.dart';
import '../features/shop/screens/category/all_categories/categories.dart';
import '../features/shop/screens/category/create_category/create_category.dart';
import '../features/shop/screens/category/edit_category/edit_category.dart';
import '../features/shop/screens/dashboard/dashboard.dart';
import '../features/authentication/screens/forgot_password/forgot_password.dart';
import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/reset_password/reset_password.dart';

class PAppRoute {
  static final List<GetPage> pages = [

     GetPage(name: PRoutes.login, page: () => const LoginScreen()),
     GetPage(name: PRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
     GetPage(name: PRoutes.resetPassword, page: () => const ResetPasswordScreen()),
     GetPage(name: PRoutes.dashboard, page: () => const DashboardScreen(), middlewares: [PRouteMiddleware()]),
     GetPage(name: PRoutes.media, page: () => const MediaScreen(), middlewares: [PRouteMiddleware()]),

      //Banners
     // GetPage(name: PRoutes.banners, page: () => const BannersScreen(), middlewares: [PRouteMiddleware()]),
     // GetPage(name: PRoutes.createBanner, page: () => const CreateBannerScreen(), middlewares: [PRouteMiddleware()]),
     // GetPage(name: PRoutes.editBanner, page: () => const EditBannerScreen(), middlewares: [PRouteMiddleware()]),

      //Products
     // GetPage(name: PRoutes.products, page: () => const ProductsScreen(), middlewares: [PRouteMiddleware()]),
     // GetPage(name: PRoutes.createProduct, page: () => const CreateProductScreen(), middlewares: [PRouteMiddleware()]),
     // GetPage(name: PRoutes.editProduct, page: () => const EditProductScreen(), middlewares: [PRouteMiddleware()]),

    //Categories
     GetPage(name: PRoutes.categories, page: () => const CategoriesScreen(), middlewares: [PRouteMiddleware()]),
     GetPage(name: PRoutes.createCategory, page: () => const CreateCategoryScreen(), middlewares: [PRouteMiddleware()]),
     GetPage(name: PRoutes.editCategory, page: () => const EditCategoryScreen(), middlewares: [PRouteMiddleware()]),

      //Brands
      GetPage(name: PRoutes.brands, page: () => const BrandsScreen(), middlewares: [PRouteMiddleware()]),
      GetPage(name: PRoutes.createBrand, page: () => const CreateBrandScreen(), middlewares: [PRouteMiddleware()]),
      GetPage(name: PRoutes.editBrand, page: () => const EditBrandScreen(), middlewares: [PRouteMiddleware()]),
     //
     // //Customers
     // GetPage(name: PRoutes.customers, page: () => const CustomersScreen(), middlewares: [PRouteMiddleware()]),
     // GetPage(name: PRoutes.createCustomer, page: () => const CreateCustomerScreen(), middlewares: [PRouteMiddleware()]),
     // GetPage(name: PRoutes.customerDetails, page: () => const CustomerDetailsScreen(), middlewares: [PRouteMiddleware()]),
     //
     // //Orders
     // GetPage(name: PRoutes.orders, page: () => const OrdersScreen(), middlewares: [PRouteMiddleware()]),
     // GetPage(name: PRoutes.createOrder, page: () => const CreateOrderScreen(), middlewares: [PRouteMiddleware()]),
     // GetPage(name: PRoutes.orderDetails, page: () => const OrderDetailsScreen(), middlewares: [PRouteMiddleware()]),
  ];
}