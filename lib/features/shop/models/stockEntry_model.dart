import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pine_admin_panel/features/shop/models/product_model.dart';
import 'package:pine_admin_panel/features/shop/models/brand_model.dart';
import 'package:pine_admin_panel/utils/formatters/formatter.dart';

class StockEntryModel {
  String id;
  ProductModel product; // Sản phẩm được nhập
  int quantity; // Số lượng nhập
  double costPrice; // Giá nhập của sản phẩm
  DateTime entryDate; // Ngày nhập hàng
  String supplier; // Nhà cung cấp sản phẩm
  String? invoiceNumber; // Số hóa đơn (nếu có)
  String? enteredBy; // Người nhập hàng
  bool isConfirmed; // Đã xác nhận nhập hàng chưa

  StockEntryModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.costPrice,
    required this.entryDate,
    required this.supplier,
    this.invoiceNumber,
    this.enteredBy,
    this.isConfirmed = false,
  });

  // Phương thức định dạng ngày nhập hàng
  String get formattedEntryDate => PFormatter.formatDate(entryDate);

  // Phương thức định dạng giá nhập
  String get formattedCurrency => PFormatter.formatCurrencyRange(costPrice.toString());

  // Phương thức tạo đối tượng StockEntryModel từ dữ liệu JSON
  toJson() {
    return {
      'ProductId': product.id,
      'Quantity': quantity,
      'CostPrice': costPrice,
      'EntryDate': entryDate,
      'Supplier': supplier,
      'InvoiceNumber': invoiceNumber,
      'EnteredBy': enteredBy,
      'IsConfirmed': isConfirmed,
    };
  }

  // Phương thức tạo đối tượng StockEntryModel từ snapshot của Firebase
  factory StockEntryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return StockEntryModel(
      id: document.id,
      product: ProductModel.fromSnapshot(data['Product']), // Chuyển đối tượng ProductModel từ dữ liệu JSON
      quantity: data['Quantity'] ?? 0,
      costPrice: (data['CostPrice'] ?? 0).toDouble(),
      entryDate: (data['EntryDate'] as Timestamp).toDate(),
      supplier: data['Supplier'] ?? '',
      invoiceNumber: data['InvoiceNumber'],
      enteredBy: data['EnteredBy'],
      isConfirmed: data['IsConfirmed'] ?? false,
    );
  }

  // Phương thức tạo đối tượng StockEntryModel từ query snapshot của Firebase
  factory StockEntryModel.fromQuerySnapshot(QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;

    return StockEntryModel(
      id: document.id,
      product: ProductModel.fromSnapshot(data['Product']),
      quantity: data['Quantity'] ?? 0,
      costPrice: (data['CostPrice'] ?? 0).toDouble(),
      entryDate: (data['EntryDate'] as Timestamp).toDate(),
      supplier: data['Supplier'] ?? '',
      invoiceNumber: data['InvoiceNumber'],
      enteredBy: data['EnteredBy'],
      isConfirmed: data['IsConfirmed'] ?? false,
    );
  }

  // Phương thức kiểm tra xem dữ liệu nhập hàng có hợp lệ không
  bool isValidEntry() {
    if (product.id.isEmpty || quantity <= 0 || costPrice <= 0 || supplier.isEmpty) {
      return false;
    }
    return true;
  }

  // Phương thức kiểm tra xem đơn nhập hàng đã được xác nhận chưa
  void confirmEntry() {
    isConfirmed = true;
  }

  // Phương thức kiểm tra thông tin nhập hàng
  void updateStock() {
    if (isConfirmed) {
      product.stock += quantity;
    }
  }
}
