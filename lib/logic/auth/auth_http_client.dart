import 'package:http/http.dart' as http;

import '../errors/errors.dart';
import '../general.dart';
import 'auth_facade.dart';

class NoTokenException implements Exception {}

/// Adds the Authorization header using [AuthFacade] (therefore can throw [NoTokenException])
/// + sets contentType, responseType
/// + throws NetworkException if status code is not 200
class AuthHTTPClient extends http.BaseClient {
  final AuthFacade _authFacade;
  final http.Client _inner;
  AuthHTTPClient(this._authFacade, this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final token = await _getTokenOrThrow();
    request.headers['contentType'] = "application/json";
    request.headers['responseType'] = "application/json";
    request.headers['Authorization'] = token;
    printDebug("current auth token: $token");

    printDebug(request);

    final streamedResp = await _inner.send(request);
    if (streamedResp.statusCode != 200) {
      final response = await http.Response.fromStream(streamedResp);
      throw NetworkException(response.statusCode, response.body);
    }
    return streamedResp;
  }

  Future<String> _getTokenOrThrow() => _authFacade.getToken().then(
        (tokenOption) => tokenOption.fold(
          () => throw NoTokenException(),
          (token) => token,
        ),
      );
}
