import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pine_admin_panel/utils/formatters/formatter.dart';

class CouponModel {
  String id;
  String couponCode;
  String type; // Percentage or Fixed Amount
  double discountAmount;
  double minimumPurchaseAmount;
  DateTime? endDate;
  bool status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String description;
  int usedCount;

  CouponModel({
    required this.id,
    required this.couponCode,
    required this.type,
    required this.discountAmount,
    required this.minimumPurchaseAmount,
    this.endDate,
    this.status = false,
    this.createdAt,
    this.updatedAt,
    this.description = '',
    this.usedCount = 0,
  });

  String get formattedDate => PFormatter.formatDate(createdAt);
  String get formattedUpdatedDate => PFormatter.formatDate(updatedAt);
  String get formattedEndDate => PFormatter.formatDate(endDate);

  /// Empty Helper Function
  static CouponModel empty() => CouponModel(
    id: '',
    couponCode: '',
    type: '',
    discountAmount: 0,
    minimumPurchaseAmount: 0,
    status: false,
    description: '',
  );

  /// Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'CouponCode': couponCode,
      'Type': type,
      'DiscountAmount': discountAmount,
      'MinimumPurchaseAmount': minimumPurchaseAmount,
      'EndDate': endDate,
      'Status': status,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
      'Description': description,
    };
  }

  /// Map Json oriented document snapshot from Firebase to CouponModel
  factory CouponModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return CouponModel(
        id: document.id,
        couponCode: data['CouponCode'] ?? '',
        type: data['Type'] ?? '',
        discountAmount: (data['DiscountAmount'] ?? 0.0).toDouble(),
        minimumPurchaseAmount: (data['MinimumPurchaseAmount'] ?? 0.0).toDouble(),
        endDate: data.containsKey('EndDate') ? data['EndDate']?.toDate() : null,
        status: data['Status'] ?? true,
        createdAt: data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        updatedAt: data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
        description: data['Description'] ?? '',
        usedCount: 0, // mặc định nếu không có
      );
    } else {
      return CouponModel.empty();
    }
  }

  CouponModel copyWith({
    String? id,
    String? couponCode,
    String? type,
    double? discountAmount,
    double? minimumPurchaseAmount,
    DateTime? endDate,
    bool? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    int? usedCount,
  }) {
    return CouponModel(
      id: id ?? this.id,
      couponCode: couponCode ?? this.couponCode,
      type: type ?? this.type,
      discountAmount: discountAmount ?? this.discountAmount,
      minimumPurchaseAmount: minimumPurchaseAmount ?? this.minimumPurchaseAmount,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      usedCount: usedCount ?? this.usedCount,
    );
  }

}
