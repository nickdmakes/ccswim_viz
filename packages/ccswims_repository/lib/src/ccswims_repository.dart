import 'ccswims_api.dart';
import 'dart:convert';

class CCSwimsRepository {
  CCSwimsRepository({CCSwimsApiClient? ccswimsApiClient})
    : _ccswimsApiClient = ccswimsApiClient ?? CCSwimsApiClient();

  final CCSwimsApiClient _ccswimsApiClient;

  /// Search CCSwims database for swimmers
  Future<dynamic> swimmerSearch(String fullname, String club) async {
    String swimmerSearchHash = _ccswimsApiClient.hashSwimmerForCache(fullname, club);
    List<dynamic>? cachedResult = _ccswimsApiClient.cache.read<List<dynamic>>(key: swimmerSearchHash);
    if(cachedResult != null) {
      return cachedResult;
    } else {
      final swimmers = await _ccswimsApiClient.swimmerSearchRequest(fullname, club);
      _ccswimsApiClient.cache.write<List<dynamic>>(key: swimmerSearchHash, value: swimmers);
      return swimmers;
    }
  }

  /// Get mock data for swimmers
  Future<dynamic> mockSwimmerSearch() async {
    List<dynamic> mockSwimmers = [{"fullname":"Nicholas Madel","club":"JMU"},{"fullname":"Nicholas Matthews","club":"ISUSC"},{"fullname":"Nicholas Matyas","club":"WVAU"},{"fullname":"Nicholas Matyas","club":"WVU"}];
    return mockSwimmers;
  }

  /// Search CCSwims database for all times for a specific swimmer
  Future<dynamic> allTimesSearch(String fullname, String club) async {
    String swimmerTimesHash = _ccswimsApiClient.hashTimesForCache(fullname, club);
    List<dynamic>? cachedResult = _ccswimsApiClient.cache.read<List<dynamic>>(key: swimmerTimesHash);
    if(cachedResult != null) {
      return cachedResult;
    } else {
      final swimmers = await _ccswimsApiClient.allTimesSearchRequest(fullname, club);
      _ccswimsApiClient.cache.write<List<dynamic>>(key: swimmerTimesHash, value: swimmers);
      return swimmers;
    }
  }
}
