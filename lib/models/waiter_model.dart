import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WaiterModel {
  final String waiterPic;
  final String waiterName;
  final String waiterAge;
  final String waiterPhone;
  final String restroName;
  final String userId;
  final String restroId;

  WaiterModel({
    required this.waiterPic,
    required this.waiterName,
    required this.waiterAge,
    required this.waiterPhone,
    required this.restroName,
    required this.userId,
    required this.restroId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'waiterName': waiterName,
      'waiterAge': waiterAge,
      'waiterPhone': waiterPhone,
      'restroName': restroName,
      'userId': userId,
      'restroId': restroId,
      'waiterPic': waiterPic,
    };
  }

  factory WaiterModel.fromMap(Map<String, dynamic> map) {
    return WaiterModel(
      waiterName: map['waiterName'] ?? '',
      waiterAge: map['waiterAge'] ?? '',
      waiterPhone: map['waiterPhone'] ?? '',
      restroName: map['restroName'] ?? '',
      userId: map['userId'] ?? '',
      restroId: map['restroId'] ?? '',
      waiterPic: map['waiterPic'] ?? '',
    );
  }
}
