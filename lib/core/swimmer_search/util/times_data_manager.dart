import 'package:intl/intl.dart';

// Class for managing the times data (filtering, sorting, etc.)
class TimesDataManager {
  TimesDataManager({required this.times}) {
    _combineDistanceAndStroke();
    _sortByDate();
  }

  final List<Map<String, dynamic>> times;

  // Method which combines the keys "distance" and "stroke" into a new key "distance_stroke"
  void _combineDistanceAndStroke() {
    for (int i = 0; i < times.length; i++) {
      times[i]["distance_stroke"] = "${times[i]["distance"].toString()} ${times[i]["stroke"]}";
    }
  }

  // Sort times by date using the intl package. Date is in the format "mm/dd/yyyy"
  void _sortByDate() {
    times.sort((a, b) {
      final DateFormat formatter = DateFormat("MM/dd/yyyy");
      final DateTime aDate = formatter.parse(a["date"]);
      final DateTime bDate = formatter.parse(b["date"]);
      return bDate.compareTo(aDate);
    });
  }

  // Method which filters the times by best time for each distance_stroke.
  void filterByBestTimes() {
    // Create a map of the best times for each distance_stroke
    final Map<String, Duration> bestTimes = {};

    // Loop through each time
    for (int i = 0; i < times.length; i++) {
      // Get the distance_stroke of the current time
      final String distanceStroke = times[i]["distance_stroke"];

      // If the distance_stroke is not in the bestTimes map, add it
      if (!bestTimes.containsKey(distanceStroke)) {
        bestTimes[distanceStroke] = timeStrToDuration(times[i]["time"]);
      } else {
        // If the distance_stroke is in the bestTimes map, compare the current time to the best time
        final Duration currentTime = timeStrToDuration(times[i]["time"]);
        if (currentTime < bestTimes[distanceStroke]!) {
          bestTimes[distanceStroke] = currentTime;
        }
      }
    }

    // Create a new list of times which will be filtered
    final List<Map<String, dynamic>> filteredTimes = [];

    // Loop through each time
    for (int i = 0; i < times.length; i++) {
      // Get the distance_stroke of the current time
      final String distanceStroke = times[i]["distance_stroke"];

      // If the current time is the best time for the distance_stroke, add it to the filteredTimes list
      if (bestTimes[distanceStroke] == timeStrToDuration(times[i]["time"])) {
        filteredTimes.add(times[i]);
      }
    }

    // Set the times list to the filteredTimes list
    times.clear();
    times.addAll(filteredTimes);
  }

  // filter times by season. season is in the format "yy-yy" which is equivalent to "20yy-20yy".
  // Seasons begin on August 1st and August 1st of the following year.
  void filterBySeason(String startYear, String endYear) {
    // Create a new list of times which will be filtered
    final List<Map<String, dynamic>> filteredTimes = [];

    // Loop through each time
    for (int i = 0; i < times.length; i++) {
      // Get the date of the current time
      final DateFormat formatter = DateFormat("MM/dd/yyyy");
      final DateTime timeDate = formatter.parse(times[i]["date"]);

      // Get the year and month of the current time
      final int timeYear = int.parse(timeDate.year.toString().substring(2));
      final int timeMonth = timeDate.month;

      // If its during the start year, add it to the filteredTimes list if it is after August 1st
      // If its during the end year, add it to the filteredTimes list if it is before August 1st
      if (timeYear == int.parse(startYear)) {
        if (timeMonth >= 8) {
          filteredTimes.add(times[i]);
        }
      } else if (timeYear == int.parse(endYear)) {
        if (timeMonth < 8) {
          filteredTimes.add(times[i]);
        }
      }
    }
    // Set the times list to the filteredTimes list
    times.clear();
    times.addAll(filteredTimes);
  }


  // convert time string into a Duration
  // Some times are in the format "0:00.00" and some are in the format "00.00"
  Duration timeStrToDuration(String time) {
    final List<String> timeParts = time.split(":");
    if (timeParts.length == 2) {
      final int minutes = int.parse(timeParts[0]);
      final List<String> secondsParts = timeParts[1].split(".");
      final int seconds = int.parse(secondsParts[0]);
      final int centiseconds = int.parse(secondsParts[1]);
      return Duration(minutes: minutes, seconds: seconds, milliseconds: centiseconds*10);
    } else {
      final List<String> secondsParts = timeParts[0].split(".");
      final int seconds = int.parse(secondsParts[0]);
      final int centiseconds = int.parse(secondsParts[1]);
      return Duration(seconds: seconds, milliseconds: centiseconds*10);
    }
  }

  // Method which filters the times by stroke
  void filterByStroke(String stroke) {
    // Create a new list of times which will be filtered
    final List<Map<String, dynamic>> filteredTimes = [];

    // Loop through each time
    for (int i = 0; i < times.length; i++) {
      // Get the stroke of the current time
      final String timeStroke = times[i]["stroke"];

      // If the current time is the correct stroke, add it to the filteredTimes list
      if (timeStroke == stroke) {
        filteredTimes.add(times[i]);
      }
    }

    // Set the times list to the filteredTimes list
    times.clear();
    times.addAll(filteredTimes);
  }

  // Method which filters the times by distance
  void filterByDistance(String distance) {
    // Create a new list of times which will be filtered
    final List<Map<String, dynamic>> filteredTimes = [];

    // Loop through each time
    for (int i = 0; i < times.length; i++) {
      // Get the distance of the current time
      final String timeDistance = times[i]["distance"];

      // If the current time is the correct distance, add it to the filteredTimes list
      if (timeDistance == distance) {
        filteredTimes.add(times[i]);
      }
    }

    // Set the times list to the filteredTimes list
    times.clear();
    times.addAll(filteredTimes);
  }

  // Method which returns a List<dynamic> property
  List<Map<String, dynamic>> getTimes() {
    return times;
  }
}
