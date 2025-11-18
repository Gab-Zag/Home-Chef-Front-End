import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

class FakeHttpClient extends Fake implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return FakeHttpRequest();
  }
}

class FakeHttpRequest extends Fake implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async {
    return FakeHttpResponse();
  }
}

class FakeHttpResponse extends Fake implements HttpClientResponse {
  @override
  int get statusCode => 200;

  final _data = utf8.encode('{"meals":[{"strMeal":"Pizza"}]}');

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int>)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final controller = Stream<List<int>>.fromIterable([_data]);
    return controller.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  Future<List<int>> get first async => _data;
}


