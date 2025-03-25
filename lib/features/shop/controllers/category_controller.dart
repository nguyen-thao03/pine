import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pine_admin_panel/data/repositories/category_repository.dart';
import 'package:pine_admin_panel/utils/constants/sizes.dart';
import 'package:pine_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:pine_admin_panel/utils/popups/loaders.dart';

import '../models/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  RxBool isLoading = true.obs;
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> filteredItems = <CategoryModel>[].obs;

  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;

  final searchTextController = TextEditingController();

  final _categoryRepository = Get.put(CategoryRepository());

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try{
      isLoading.value = true;
      List<CategoryModel> fetchedItems = [];
      if(allItems.isEmpty){
        fetchedItems = await _categoryRepository.getAllCategories();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);

      isLoading.value = false;
    }catch(e){
      isLoading.value = false;
      PLoaders.errorSnackBar(title: 'Ôi không!', message: e.toString());
    }
  }

  void sortByName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      String nameA = removeDiacritics(a.name.toLowerCase());
      String nameB = removeDiacritics(b.name.toLowerCase());

      if (ascending) {
        return nameA.compareTo(nameB);
      } else {
        return nameB.compareTo(nameA);
      }
    });
  }

  sortByParentName(int columnIndex, bool ascending) {
    sortColumnIndex.value = columnIndex;
    sortAscending.value = ascending;

    filteredItems.sort((a, b) {
      String nameA = removeDiacritics(a.parentId.toLowerCase());
      String nameB = removeDiacritics(b.parentId.toLowerCase());

      if (ascending) {
        return nameA.compareTo(nameB);
      } else {
        return nameB.compareTo(nameA);
      }
    });
  }

  searchQuery(String query) {
    filteredItems.assignAll(allItems.where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
    );
  }

  confirmAndDeleteItem(CategoryModel category) {
    Get.defaultDialog(
      title: 'Xóa danh mục',
      content: const Text('Bạn có chắc muốn xóa danh mục này không?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
            onPressed: () async => await deleteOnConfirm(category),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: PSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PSizes.buttonRadius * 5)),
            ),
            child: const Text('Xóa'),
        ),
      ),
        cancel: SizedBox(
          width: 80,
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: PSizes.buttonHeight / 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(PSizes.buttonRadius * 5)),
            ),
            child: const Text('Thoát'),
          ),
        )
    );
  }

  deleteOnConfirm(CategoryModel category) async {
    try{
      PFullScreenLoader.stopLoading();

      PFullScreenLoader.popUpCircular();

      await _categoryRepository.deleteCategory(category.id);

      removeItemFromLists(category);
      PFullScreenLoader.stopLoading();
      PLoaders.successSnackBar(title: 'Đã xóa danh mục', message: 'Đã xóa danh mục');
    }catch(e){
      PFullScreenLoader.stopLoading();
      PLoaders.errorSnackBar(title: 'Ôi không!', message: e.toString());
    }

  }

  void removeItemFromLists(CategoryModel item) {
    allItems.remove(item);
    filteredItems.remove(item);
  }

  void addItemToLists(CategoryModel item) {
    allItems.add(item);
    filteredItems.add(item);

    filteredItems.refresh();
  }

  void updateItemFromLists(CategoryModel item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if(itemIndex != -1) allItems[itemIndex] = item;
    if(filteredItemIndex != -1) filteredItems[itemIndex] = item;

    filteredItems.refresh();
  }
}