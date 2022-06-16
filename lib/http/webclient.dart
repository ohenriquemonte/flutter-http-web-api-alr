import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

// const String baseUrl = 'http://192.168.58.1:8080/transactions';
const String baseUrl =
    'https://15f1-2804-7f4-c1a3-ed50-64b7-8b7-48d5-a8c5.ngrok.io/transactions';
