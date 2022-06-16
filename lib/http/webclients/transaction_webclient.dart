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

    final Response response = await client
        .get(Uri.http(baseUrl, 'transactions'))
        .timeout(Duration(seconds: 10));

    print(response.body);

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response =
        await client.post(Uri.http(baseUrl, 'transactions'),
            headers: {
              'Content-type': 'application/json',
              'password': password,
            },
            body: transactionJson);

    if (response.statusCode == 400) {
      throw Exception('Ocorrey um erro na transação!');
    }

    if (response.statusCode == 401) {
      throw Exception('Ocorrey um erro na autenticação!');
    }

    return Transaction.fromJson(jsonDecode(response.body));
  }
}
