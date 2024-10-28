import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'common.dart';

class _FakeBuildContext extends Fake implements BuildContext {}

class MockGeocodingPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements GeocodingPlatform {
  @override
  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    return [mockPlacemark];
  }
}

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

void registerFakes() {
  registerFallbackValue(_FakeBuildContext());
}
