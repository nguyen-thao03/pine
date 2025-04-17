import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pine_admin_panel/features/shop/models/supplier_model.dart';

class PDFInvoiceGenerator {
  static Future<Uint8List> generateSupplierInvoice(SupplierModel supplier) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('HÓA ĐƠN NHÀ CUNG CẤP', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),

            pw.Text('Tên nhà cung cấp: ${supplier.name}'),
            pw.Text('Số điện thoại: ${supplier.phone ?? "Không có"}'),
            pw.Text('Địa chỉ: ${supplier.address ?? "Không có"}'),

            pw.SizedBox(height: 40),
            pw.Text('Chi tiết đơn hàng...', style: pw.TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );

    return pdf.save();
  }
}
