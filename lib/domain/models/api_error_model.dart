// class ApiErrorModel {
//   int? _statusCode;
//   String? _message;

//   ApiErrorModel({int? statusCode, String? message}) {
//     if (statusCode != null) {
//       _statusCode = statusCode;
//     }
//     if (message != null) {
//       _message = message;
//     }
//   }

//   int? get statusCode => _statusCode;
//   set statusCode(int? statusCode) => _statusCode = statusCode;
//   String? get message => _message;
//   set message(String? message) => _message = message;

//   ApiErrorModel.fromJson(Map<String, dynamic> json) {
//     _statusCode = json['statusCode'];
//     _message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['statusCode'] = _statusCode;
//     data['message'] = _message;
//     return data;
//   }
// }
