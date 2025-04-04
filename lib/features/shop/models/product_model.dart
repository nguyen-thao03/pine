import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pine_admin_panel/features/shop/models/brand_model.dart';
import 'package:pine_admin_panel/features/shop/models/product_attribute_model.dart';
import 'package:pine_admin_panel/features/shop/models/product_variation_model.dart';
import 'package:pine_admin_panel/utils/formatters/formatter.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool isFeatured;
  BrandModel? brand;
  String? categoryId;
  String productType;
  String? description;
  List<String>? images;
  int soldQuantity;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.soldQuantity = 0,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0,
    required this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  String get formattedDate => PFormatter.formatDate(date);
  String get formattedCurrency {
    if (salePrice > 0 && salePrice < price) {
      return PFormatter.formatCurrencyRange("${salePrice.toInt()} - ${price.toInt()}");
    }
    return PFormatter.formatCurrencyRange(price.toInt().toString());
  }

  /// Create Empty func for clean code
  static ProductModel empty() => ProductModel(
      id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '', isFeatured: false);

  /// Json Format
  toJson() {
    return {
      'SKU': sku,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Images': images ?? [],
      'Thumbnail': thumbnail,
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Brand': brand?.toJson(), // Kiểm tra null trước khi gọi .toJson()
      'Description': description,
      'ProductType': productType,
      'SoldQuantity': soldQuantity,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'],
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      soldQuantity: data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0 : 0,
      price: double.parse((data['Price'] ?? 0).toString()),
      salePrice:  double.parse((data['SalePrice'] ?? 0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null, // ✅ Kiểm tra null
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList()
          : [], // ✅ Kiểm tra null
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList()
          : [], // ✅ Kiểm tra null
    );
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return ProductModel(
      id: document.id,
      sku: data['SKU'] ?? '',
      title: data['Title'] ?? '',
      stock: data['Stock'] ?? 0,
      soldQuantity: data.containsKey('SoldQuantity') ? data['SoldQuantity'] ?? 0 : 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0).toString()),
      salePrice:  double.parse((data['SalePrice'] ?? 0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList()
          : [], // ✅ Kiểm tra null
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList()
          : [], // ✅ Kiểm tra null
    );
  }
}
