import 'dart:convert';

class UserModel {
    String id;
    String name;
    String email;
    String mobile;
    String gender;

    UserModel({
        required this.id,
        required this.name,
        required this.email,
        required this.mobile,
        required this.gender,
    });

    factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "gender": gender,
    };
}
