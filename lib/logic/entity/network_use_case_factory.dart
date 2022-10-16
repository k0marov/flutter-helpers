import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../errors/errors.dart';

abstract class InpMapper<V> {
  Map<String, dynamic> toJson(V v);
}

abstract class OutMapper<V> {
  V fromJson(Map<String, dynamic> json);
}

abstract class FullMapper<V> implements InpMapper<V>, OutMapper<V> {}

class NoInpMapper<V> implements InpMapper<V> {
  @override
  Map<String, dynamic> toJson(V) {
    return {};
  }
}

class NoOutMapper implements OutMapper<void> {
  @override
  void fromJson(Map<String, dynamic> json) {}
}

typedef BaseNetworkUseCase<Inp, Out> = Future<Either<Exception, Out>> Function(Inp inp);
typedef URIGetter<Inp> = Uri Function(Inp inp, String apiHost);

class NetworkUseCaseFactory {
  final String _apiHost;
  final http.Client _client;

  const NetworkUseCaseFactory(this._apiHost, this._client);

  BaseNetworkUseCase<Inp, Out> newBaseNetworkUseCase<Inp, Out>(
      {required InpMapper<Inp> inpMapper,
      required URIGetter<Inp> getUri,
      required String method,
      required OutMapper<Out> outMapper}) {
    return (inp) {
      return withExceptionHandling(() async {
        final uri = getUri(inp, _apiHost);
        final request = http.Request(method, uri);
        request.body = json.encode(inpMapper.toJson(inp));
        final respStream = await _client.send(request);
        final resp = await http.Response.fromStream(respStream);
        if (resp.statusCode != 200) {
          throw NetworkException(resp.statusCode, resp.body);
        }
        final respBody = resp.body.isNotEmpty ? json.decode(resp.body) : <String, dynamic>{};
        return outMapper.fromJson(respBody);
      });
    };
  }
}
