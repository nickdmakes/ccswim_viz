import 'ccswims_repository.dart';

void main() async {
  final ccswimsRepository = CCSwimsRepository();

  final response = await ccswimsRepository.swimmerSearch("Nicholassdfasdfasdfd", "ISUSC");
  print(response);
  for(final r in response) {
    print(r);
  }
}