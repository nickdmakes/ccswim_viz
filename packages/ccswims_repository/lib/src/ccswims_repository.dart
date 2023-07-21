import 'ccswims_api.dart';

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
