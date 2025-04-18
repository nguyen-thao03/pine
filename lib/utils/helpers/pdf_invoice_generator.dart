import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pine_admin_panel/features/shop/models/supplier_model.dart';

class PDFInvoiceGenerator {
  static String formatCurrency(double amount) {
    final format = NumberFormat("#,###", "vi_VN");  // Định dạng theo kiểu Việt Nam
    return "${format.format(amount)}₫";  // Thêm ký tự "₫" sau số tiền
  }

  static Future<Uint8List> generateSupplierInvoice(SupplierModel supplier) async {
    final pdf = pw.Document();

    // Load the fonts
    final regularFont = pw.Font.ttf(await rootBundle.load('assets/fonts/Cabin-Regular.ttf'));
    final boldFont = pw.Font.ttf(await rootBundle.load('assets/fonts/Cabin-Bold.ttf'));

    pdf.addPage(
      pw.Page(
        build: (context) => pw.DefaultTextStyle(
          style: pw.TextStyle(font: regularFont, fontSize: 14),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Title
              pw.Align(
                alignment: pw.Alignment.center,  // Căn giữa
                child: pw.Text(
                  'HÓA ĐƠN NHẬP HÀNG',
                  style: pw.TextStyle(font: boldFont, fontSize: 24),
                ),
              ),

              pw.SizedBox(height: 20),

              // Supplier Info
              pw.Text('Tên nhà cung cấp: ${supplier.name}'),
              pw.Text('Số điện thoại: ${supplier.phone ?? "Không có"}'),
              pw.Text('Địa chỉ: ${supplier.address ?? "Không có"}'),
              pw.SizedBox(height: 20),

              // Product List Table
              pw.Text('Danh sách hàng hóa:', style: pw.TextStyle(font: boldFont)),
              pw.Table.fromTextArray(
                headers: ['STT', 'Tên sản phẩm', 'Số lượng', 'Đơn giá', 'Thành tiền'],
                data: List.generate(supplier.products.length, (index) {
                  final item = supplier.products[index];
                  return [
                    '${index + 1}',
                    item.product.title,
                    '${item.quantity}',
                    formatCurrency(item.price),
                    formatCurrency(item.total),
                  ];
                }),
                headerStyle: pw.TextStyle(font: boldFont),
                cellStyle: pw.TextStyle(font: regularFont),
                border: pw.TableBorder.all(),
                cellAlignment: pw.Alignment.centerLeft,
              ),
              pw.SizedBox(height: 20),

              // Total amount
              pw.Text('Tổng tiền: ${formatCurrency(supplier.totalAmount)}', style: pw.TextStyle(font: boldFont)),
            ],
          ),
        ),
      ),
    );

    return pdf.save();
  }

}
