import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  String apiUrl = 'https://api.football-data.org/v4/';
  var headers = {
    'X-Auth-Token': '6dd5adbc5da64e488f904313c2d56ca0',
  };
  //This method is designed to return the team with the most wins in the last 30 days of the premier league
  Future<dynamic> getTeamWithMostWins() async {
    //This GET request checks for the matches played 30 days after the date of the last game of the premier league
    //It only retrieves matches that are finished to avoid get rescheduled or cancelled matches.
    var response = await http.get(
        Uri.parse(apiUrl + 'competitions/PL/matches?dateFrom=2022-04-22&dateTo=2022-05-22&status=FINISHED'),
        headers: headers);

    List<int> winnerArray = [];
    List<dynamic> parsedJson = json.decode(response.body)['matches'];
    for (int i = 0; i < parsedJson.length; i++) {
      String winnerData = parsedJson[i]['score']['winner'];
      if (winnerData == 'HOME_TEAM') {
        winnerArray.add(parsedJson[i]['homeTeam']["id"]);
      } else if (winnerData == 'AWAY_TEAM') {
        winnerArray.add(parsedJson[i]['awayTeam']["id"]);
      }
    }

    return getMostPopularTeamInArray(winnerArray);
  }

  //This method returns the most popular integer in an array
  //In this case, it returns back the most popular teamId
  dynamic getMostPopularTeamInArray(List<int> teams) {
    teams.sort();
    var popularTeams = [];
    List<Map<dynamic, dynamic>> data = [];
    var maxOccurrence = 0;

    var i = 0;
    while (i < teams.length) {
      var number = teams[i];
      var occurrence = 1;
      for (int j = 0; j < teams.length; j++) {
        if (j == i) {
          continue;
        } else if (number == teams[j]) {
          occurrence++;
        }
      }
      teams.removeWhere((it) => it == number);
      data.add({number: occurrence});
      if (maxOccurrence < occurrence) {
        maxOccurrence = occurrence;
      }
    }

    for (var map in data) {
      if (map[map.keys.toList()[0]] == maxOccurrence) {
        popularTeams.add(map.keys.toList()[0]);
      }
    }

    return getTeamDetails(popularTeams[0]);
  }

  //This method takes a team's id and passes back it's details
  dynamic getTeamDetails(int teamId) async {
    var response = await http.get(Uri.parse(apiUrl + 'teams/$teamId'), headers: headers);
    return response;
  }
}
