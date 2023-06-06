import 'dart:async';

import 'package:sehr/presentation/views/business_views/requested_order/apicall.dart';
import 'dart:convert' as convert;

OrderApi _orderApi = OrderApi();

Future<dynamic> getpaymentsdata() async {
  Map<String, dynamic>? data;

  try {
    final response = await _orderApi.fetchMyorders();

    if (response != null) {
      data = convert.jsonDecode(response.body);
    } else {
      // ignore: null_check_always_fails
      return null;
    }
  } on TimeoutException catch (_) {}
  return data;
}
