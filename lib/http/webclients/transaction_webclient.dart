import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import '../interceptors/logging_interceptor.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    Client client = InterceptedClient.build(
      interceptors: [LoggingInterceptor()],
    );
    final Response response =
        await client.get(Uri.http(baseUrl, '/transactions'));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction?> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response =
        await client.post(Uri.http(baseUrl, '/transactions'),
            headers: {
              'Content-type': 'application/json',
              'password': password,
            },
            body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode))
      return _statusCodeResponses[statusCode]!;

    return 'Erro desconhecido';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Ocorreu um erro na transação!',
    401: 'Ocorreu um erro na autenticação!',
    409: 'Transação já enviada'
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
