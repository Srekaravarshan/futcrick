import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futcrick/Constants.dart';
import 'package:futcrick/Extension.dart';
import 'package:futcrick/Pages/matches/AddGoal.dart';
import 'package:futcrick/Pages/matches/AddRedCard.dart';
import 'package:futcrick/Pages/matches/AddYellowCard.dart';
import 'package:futcrick/datamodel/MatchCard.dart';
import 'package:futcrick/datamodel/MatchDataModel.dart';
import 'package:futcrick/datamodel/Player.dart';
import 'package:futcrick/main.dart';

class TeamDetails extends StatefulWidget {
  final String matchId;
  final String homeTeamShortName;
  final String awayTeamShortName;
  final Map<String, dynamic> playerScoresT1;
  final Map<String, dynamic> playerScoresT2;

  const TeamDetails(
      {Key key,
      this.matchId,
      this.homeTeamShortName,
      this.awayTeamShortName,
      this.playerScoresT1,
      this.playerScoresT2})
      : super(key: key);

  @override
  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
            '${widget.homeTeamShortName} vs ${widget.awayTeamShortName}',
            style: TextStyle(fontFamily: 'Ubuntu')),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: matchesRef.doc(widget.matchId).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return circularProgressIndicator().center();
              }
              MatchDataModel matchData =
                  MatchDataModel.fromDocument(snapshot.data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  MatchCard(
                    matchData: matchData,
                    isLive: matchData.stateOfMatch == 'Live',
                    isUpcoming: matchData.stateOfMatch == 'Upcoming',
                    isFinished: matchData.stateOfMatch == 'Finished',
                    isClickable: false,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddGoal(
                                        matchData: matchData,
                                        isHomeTeam: true,
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: (MediaQuery.of(context).size.width - 5) / 4,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: secondaryColor),
                          child: Text('Add Goals\nTeam 1',
                                  textAlign: TextAlign.end)
                              .center(),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddGoal(
                                      matchData: matchData,
                                      isHomeTeam: false)));
                        },
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: (MediaQuery.of(context).size.width - 5) / 4,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: secondaryColor),
                            child: Text('Add Goals\nTeam 2',
                                    textAlign: TextAlign.start)
                                .center(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddYellowCard(
                                        matchData: matchData,
                                        isHomeTeam: true,
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: (MediaQuery.of(context).size.width - 5) / 4,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: Colors.yellow[700]),
                          child: Text('Add Yellow\ncard',
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.end)
                              .center(),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddYellowCard(
                                      matchData: matchData,
                                      isHomeTeam: false)));
                        },
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: (MediaQuery.of(context).size.width - 5) / 4,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: Colors.yellow[700]),
                            child: Text('Add Yellow\ncard',
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.start)
                                .center(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddRedCard(
                                        matchData: matchData,
                                        isHomeTeam: true,
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          width: (MediaQuery.of(context).size.width - 5) / 4,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              color: secondaryColor),
                          child: Text('Add Red\ncard', textAlign: TextAlign.end)
                              .center(),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddRedCard(
                                      matchData: matchData,
                                      isHomeTeam: false)));
                        },
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: (MediaQuery.of(context).size.width - 5) / 4,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: secondaryColor),
                            child: Text('Add Red\ncard',
                                    textAlign: TextAlign.start)
                                .center(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          matchData.homeTeamName,
                          style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                          child: Text(
                        'vs',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'FiraSans',
                            color: secondaryColor),
                        textAlign: TextAlign.center,
                      )),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          matchData.awayTeamName,
                          style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  myCompareWidget(
                      title: 'Possession',
                      homeTeam: matchData.possessionT1,
                      awayTeam: matchData.possessionT2),
                  SizedBox(height: 12),
                  myCompareWidget(
                      title: 'Shots taken',
                      homeTeam: matchData.shotsTakenT1,
                      awayTeam: matchData.shotsTakenT2),
                  SizedBox(height: 12),
                  myCompareWidget(
                      title: 'Shots on target',
                      homeTeam: matchData.shotsOnTargetT1,
                      awayTeam: matchData.shotsOnTargetT2),
                  SizedBox(height: 12),
                  myCompareWidget(
                      title: 'Free kick',
                      homeTeam: matchData.freeKickT1,
                      awayTeam: matchData.freeKickT2),
                  SizedBox(height: 12),
                  myCompareWidget(
                      title: 'Corner kick',
                      homeTeam: matchData.cornerKickT1,
                      awayTeam: matchData.cornerKickT2),
                  SizedBox(height: 12),
                  myCompareWidget(
                      title: 'Yellow cards',
                      homeTeam: matchData.yellowCardsCountT1,
                      awayTeam: matchData.yellowCardsCountT2),
                  SizedBox(height: 12),
                  myCompareWidget(
                      title: 'Red cards',
                      homeTeam: matchData.redCardsCountT1,
                      awayTeam: matchData.redCardsCountT2),
                  SizedBox(height: 40),
                  myTeamDetailButton(
                      teamShortName: matchData.homeTeamShortName,
                      teamName: matchData.homeTeamName,
                      isHomeTeam: true,
                      playerScores: matchData.playerScoresT1),
                  SizedBox(height: 15),
                  myTeamDetailButton(
                      teamShortName: matchData.awayTeamShortName,
                      teamName: matchData.awayTeamName,
                      isHomeTeam: false,
                      playerScores: matchData.playerScoresT2),
                  SizedBox(height: 50),
                ],
              );
            }),
      ),
    );
  }

  Widget myCompareWidget({String title, int homeTeam, int awayTeam}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        homeTeam.toString(),
        style: TextStyle(fontFamily: 'FiraSans', fontSize: 22),
      ),
      SizedBox(width: 10),
      SizedBox(
        width: 150,
        child: Text(
          title,
          style: TextStyle(
              color: secondaryColor, fontSize: 16, fontFamily: 'Ubuntu'),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(width: 10),
      Text(
        awayTeam.toString(),
        style: TextStyle(fontFamily: 'FiraSans', fontSize: 22),
      ),
    ]);
  }

  Widget myTeamDetailButton(
      {String teamShortName,
      String teamName,
      bool isHomeTeam,
      Map<String, dynamic> playerScores}) {
    return InkWell(
      onTap: () {
        showTeamDetails(teamShortName, teamName, isHomeTeam, playerScores);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 28.0,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset('assets/images/$teamShortName.png'),
            ),
          ),
          SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                teamShortName,
                style: TextStyle(fontFamily: 'Ubuntu', fontSize: 22),
              ),
              SizedBox(height: 2),
              Text(
                'Team details',
                style: TextStyle(
                    fontFamily: 'FiraSans',
                    fontSize: 14,
                    color: Colors.white70,
                    decoration: TextDecoration.underline),
              )
            ],
          )
        ],
      ),
    );
  }

  showTeamDetails(String teamShortName, String teamName, bool isHomeTeam,
      Map<String, dynamic> playerScores) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(44.0)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => Container(
              decoration: BoxDecoration(
                color: sheetColor,
              ),
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/$teamShortName.png'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    teamName,
                    style: TextStyle(fontFamily: 'Ubuntu', fontSize: 22),
                  ),
                  SizedBox(height: 30),
                  ListView.separated(
                    itemCount: teamMap[teamShortName].length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                    itemBuilder: (context, index) {
                      List<Player> playerList = teamMap[teamShortName];
                      return InkWell(
                        onTap: () {
                          showPlayerDetails(playerList, index);
                        },
                        child: myPlayerListTile(
                            playerList, index, isHomeTeam, playerScores),
                      );
                    },
                  )
                ],
              )),
            ));
  }

  myPlayerListTile(List<Player> playerList, int index, bool isHomeTeam,
      Map<String, dynamic> playerScores) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: secondaryColor,
                backgroundImage:
                    AssetImage('assets/images/${playerList[index].id}.jpg'),
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerList[index].name,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    'Players details',
                    style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 14,
                        color: Colors.white70,
                        decoration: TextDecoration.underline),
                  )
                ],
              )
            ],
          ),
          Text(
            playerScores[(playerList[index].id).toString()].toString(),
            style: TextStyle(fontSize: 22, fontFamily: 'Ubuntu'),
          )
        ],
      ),
    );
  }

  showPlayerDetails(List<Player> playerList, int index) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(44.0)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => Container(
              decoration: BoxDecoration(
                color: sheetColor,
              ),
              height: MediaQuery.of(context).size.height * 0.85,
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    backgroundImage:
                        AssetImage('assets/images/${playerList[index].id}.jpg'),
                    // child: Image.asset(
                    //   'assets/images/${playerList[index].id}.jpg',
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    playerList[index].name,
                    style: TextStyle(fontFamily: 'Ubuntu', fontSize: 22),
                  ),
                  Text(
                    'Age: ${playerList[index].age}',
                    style: TextStyle(
                        fontFamily: 'FiraSans',
                        color: Colors.white54,
                        fontSize: 14),
                  ),
                  SizedBox(height: 30),
                  Text(
                    playerList[index].bio,
                    style: TextStyle(
                        fontFamily: 'FiraSans', fontSize: 22, height: 2),
                  ),
                ],
              )),
            ));
  }
}
