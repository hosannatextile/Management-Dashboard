class LoginData {
  String? message;
  String? accessToken;
  String? refreshToken;
  User? user;

  LoginData({this.message, this.accessToken, this.refreshToken, this.user});

  LoginData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? fullName;
  String? cnic;
  String? email;
  String? role;
  String? username;

  User(
      {this.id,
      this.fullName,
      this.cnic,
      this.email,
      this.role,
      this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    cnic = json['cnic'];
    email = json['email'];
    role = json['role'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['cnic'] = cnic;
    data['email'] = email;
    data['role'] = role;
    data['username'] = username;
    return data;
  }
}
