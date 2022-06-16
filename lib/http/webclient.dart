import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);

// const String baseUrl = 'http://192.168.58.1:8080/transactions';
const String baseUrl = 'e961-2804-7f4-c2a5-9a16-99ca-aa04-2f58-9662.ngrok.io.';
