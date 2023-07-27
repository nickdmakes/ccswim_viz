// Class for managing the times data (filtering, sorting, etc.)
class TimesDataManager {
  TimesDataManager({required this.times});

  final List<Map<String, dynamic>> times;

  // Method which combines the keys "distance" and "stroke" into a new key "distance_stroke"
  void combineDistanceAndStroke() {
    for (int i = 0; i < times.length; i++) {
      times[i]["distance_stroke"] = "${times[i]["distance"].toString()} ${times[i]["stroke"]}";
    }
  }

  // Method which returns a List<dynamic> property
  List<Map<String, dynamic>> getTimes() {
    return times;
  }
}