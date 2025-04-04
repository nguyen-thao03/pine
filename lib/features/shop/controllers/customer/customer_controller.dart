import 'package:get/get.dart';
import 'package:pine_admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:pine_admin_panel/data/repositories/user_repository.dart';
import 'package:pine_admin_panel/features/personalization/models/user_model.dart';

class CustomerController extends PBaseController<UserModel> {
  static CustomerController get instance => Get.find();

  final _customerRepository = Get.put(UserRepository());

  var currentCategory = 'Khách hàng'.obs;

  /// ✅ Cập nhật filteredItems ngay sau khi tải dữ liệu
  @override
  Future<List<UserModel>> fetchItems() async {
    List<UserModel> users;
    if (currentCategory.value == 'Khách hàng') {
      users = await _customerRepository.getAllUsers();
    } else {
      users = await _customerRepository.getAllStaff();
    }

    filteredItems.assignAll(users); // ✅ Cập nhật danh sách ngay
    return users;
  }

  void changeCategory(String category) {
    currentCategory.value = category;
    fetchData();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (UserModel o) => o.fullName.toLowerCase());
  }

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  /// ✅ Xóa nhân viên và cập nhật danh sách ngay lập tức
  @override
  Future<void> deleteItem(UserModel item) async {
    await _customerRepository.deleteUser(item.id ?? '');
    fetchData(); // ✅ Gọi fetchData() để cập nhật danh sách
  }

  /// ✅ Hàm này sẽ được gọi sau khi thêm nhân viên mới
  void addNewStaff(UserModel newStaff) {
    filteredItems.add(newStaff);
    update(); // ✅ Cập nhật UI ngay
  }
}
