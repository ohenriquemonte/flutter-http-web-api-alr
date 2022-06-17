import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);

// const String baseUrl = 'http://192.168.58.1:8080/transactions';
const String baseUrl = '9117-2804-7f4-c2a5-9a16-88a1-99ee-bb5e-7a3d.ngrok.io';
