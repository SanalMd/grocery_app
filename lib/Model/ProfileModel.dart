
import 'package:hive/hive.dart';
part 'ProfileModel.g.dart';

@HiveType(typeId: 1,adapterName: 'ProfileAdapter')
class ProfileModel {
  ProfileModel({
      this.name, 
      this.email, 
      this.mobile, 
      this.address,});

  ProfileModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
  }
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? mobile;
  @HiveField(3)
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['address'] = address;
    return map;
  }

}