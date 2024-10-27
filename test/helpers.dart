import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class CustomRequestMatcher implements HttpRequestMatcher {
  const CustomRequestMatcher({this.matchMethod = false});

  final bool matchMethod;

  @override
  bool matches(RequestOptions ongoingRequest, Request matcher) {
    final isTheSameRoute = doesRouteMatch(ongoingRequest.path, matcher.route);
    return isTheSameRoute &&
        (!matchMethod || ongoingRequest.method == matcher.method?.name);
  }
}

bool doesRouteMatch(dynamic actual, dynamic expected) {
  // If null then fail. The route should never be null.
  if (actual == null || expected == null) {
    return false;
  }

  if (actual is String && expected is String) {
    final actualUri = Uri.parse(actual);
    final expectedUri = Uri.parse(expected);

    final actualParameters = Map<String, String>.from(actualUri.queryParameters)
      ..remove('api_key');

    final expectedParameters =
        Map<String, String>.from(expectedUri.queryParameters)
          ..remove('api_key');

    return actualUri.replace(queryParameters: actualParameters) ==
        expectedUri.replace(queryParameters: expectedParameters);
  }

  // Allow regex match of route, expected should be provided via the mocking.
  if (expected is RegExp && actual is String) {
    return expected.hasMatch(actual);
  }

  // Default to no match.
  return false;
}
