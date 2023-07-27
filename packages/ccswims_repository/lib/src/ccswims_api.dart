import 'package:dio/dio.dart';
import 'package:cache/cache.dart';
import 'dart:convert';

class CCSwimsApiClient {
  CCSwimsApiClient({
    CacheClient? cacheClient,
  }) : _cacheClient = cacheClient ?? CacheClient();

  final CacheClient _cacheClient;

  CacheClient get cache => _cacheClient;

  /// Hash a given swimmer for the Cache map, whose keys are strings
  String hashSwimmerForCache(String fullname, String club) {
    return "${fullname}${club}".hashCode.toString();
  }

  String hashTimesForCache(String fullnameSearch, String clubSearch) {
    return "${fullnameSearch}${clubSearch}".hashCode.toString();
  }

  /// Retrieves swimmers times from usa swimming website
  Future<List<dynamic>> swimmerSearchRequest(String fullnameSearch, String clubSearch) async {
    final fullnameCleaned = fullnameSearch.replaceAll(" ", "+");
    final response = await Dio().get("http://ccswimviz.com:8000/swimmers/?fullname=${fullnameCleaned}&club=${clubSearch}",
        options: Options(
          responseType: ResponseType.plain,
        ));
    final decoded = json.decode(response.data) as List<dynamic>;

    return decoded;
  }

  /// Retrieves swimmers times from usa swimming website
  Future<List<dynamic>> allTimesSearchRequest(String fullname, String club) async {
    final fullnameCleaned = fullname.replaceAll(" ", "+");
    final response = await Dio().get("https://ccswimviz.com:8000/alltimes/?fullname=${fullnameCleaned}&club=${club}",
      options: Options(
        responseType: ResponseType.plain,
      ));
    final decoded = json.decode(response.data) as List<dynamic>;

    return decoded;
  }
}

