import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'httpinterceptor.dart';

class WebClient {
  String baseUrl = 'http://192.168.0.105:8080/transactions';

  Client client = HttpClientWithInterceptor.build(
    interceptors: [
      LoggingInterceptor(),
    ],
    requestTimeout: Duration(seconds: 5),
  );
}
