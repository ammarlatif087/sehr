class AppUrls {
  static const String _baseUrl = 'http://3.133.0.29/api';

  static const String loginEndPoint = '$_baseUrl/auth/login';
  static const String currentUser = '$_baseUrl/user/me';
  static const String registerEndPoint = '$_baseUrl/user/register';
  static const String verifyOtpEndPoint = '$_baseUrl/auth/verify-otp';
  static const String blogEndPoint = '$_baseUrl/blog/posts';
  static const String educationEndPoint = '$_baseUrl/education';
  static const String businessEndPoint = '$_baseUrl/business';
  static const String getBusinessEndPoint = '$_baseUrl/business?';
  static const String addToFavourite = '$_baseUrl/user/favorites';
  static const String verifyPhoneNo = '$_baseUrl/auth/verify-otp';
}
