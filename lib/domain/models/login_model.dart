// class LoginModel {
//   String? _username;
//   String? _password;

//   LoginModel({String? username, String? password}) {
//     if (username != null) {
//       _username = username;
//     }
//     if (password != null) {
//       _password = password;
//     }
//   }

//   String? get username => _username;
//   set username(String? username) => _username = username;
//   String? get password => _password;
//   set password(String? password) => _password = password;

//   LoginModel.fromJson(Map<String, dynamic> json) {
//     _username = json['username'];
//     _password = json['password'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['username'] = _username;
//     data['password'] = _password;
//     return data;
//   }
// }
