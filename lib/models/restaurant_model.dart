// ignore_for_file: public_member_api_docs, sort_constructors_first
class RestroModel {
  final String restroName;
  final String owner;
  final String address;
  final String phoneNumber;
  final String restroEmail;
  final String restroPic;
  final String restroId;

  RestroModel({
    required this.restroName,
    required this.owner,
    required this.address,
    required this.phoneNumber,
    required this.restroEmail,
    required this.restroPic,
    required this.restroId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restroName': restroName,
      'owner': owner,
      'address': address,
      'phoneNumber': phoneNumber,
      'restroPic': restroPic,
      'restroId': restroId,
      'restroEmail': restroEmail,
    };
  }

  factory RestroModel.fromMap(Map<String, dynamic> map) {
    return RestroModel(
      restroName: map['restroName'] ?? '',
      owner: map['owner'] ?? '',
      address: map['address'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      restroPic: map['restroPic'] ?? '',
      restroId: map['restroId'] ?? '',
      restroEmail: map['restroEmail'] ?? '',
    );
  }
}
