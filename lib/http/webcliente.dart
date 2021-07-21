import 'package:bytebank2/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';



final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

final baseUrl = Uri.http('192.168.0.9:8081', 'transactions');


