import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:winning_team/service/api_service.dart';

class WinningTeam extends StatefulWidget {
  const WinningTeam({Key? key}) : super(key: key);

  @override
  _WinningTeamState createState() => _WinningTeamState();
}

class _WinningTeamState extends State<WinningTeam> {
  String teamName = '';
  String teamLogo = '';
  String teamAddress = '';
  String teamVenue = '';
  String teamWebsite = '';
  bool pageLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWinningTeamDetails();
  }

  void getWinningTeamDetails() async {
    var winningTeam = await getDataFromService();
    String name = json.decode(winningTeam.body)['name'];
    String address = json.decode(winningTeam.body)['address'];
    String venue = json.decode(winningTeam.body)['venue'];
    String logo = json.decode(winningTeam.body)['crest'];
    setState(() {
      teamName = name;
      teamAddress = address;
      teamVenue = venue;
      teamLogo = logo;
      pageLoaded = true;
    });
  }

  Future<dynamic> getDataFromService() async {
    return await ApiService().getTeamWithMostWins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageLoaded
          ? SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (teamLogo != '')
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: Image.network(teamLogo),
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(teamName,
                        style: GoogleFonts.quicksand(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(teamAddress, style: GoogleFonts.quicksand(fontSize: 16.0, color: Colors.black)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(teamVenue, style: GoogleFonts.quicksand(fontSize: 16.0, color: Colors.black)),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
    );
  }
}
