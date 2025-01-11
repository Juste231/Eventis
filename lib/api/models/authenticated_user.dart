

class AuthenticatedUser {
  String? token;
  User? user;

  AuthenticatedUser({
    this.token,
    this.user,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    return AuthenticatedUser(
      token: data["token"],
      user: data["user"] == null ? null : User.fromJson(data["user"]),
  );
}

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? role;

  User({this.firstname, this.lastname, this.email, this.password, this.role});

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    return data;
  }
}