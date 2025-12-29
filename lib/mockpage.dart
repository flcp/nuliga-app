// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Match {
  final String type;
  final String team1Player1;
  final String? team1Player2;
  final String team2Player1;
  final String? team2Player2;
  final int? team1Score1;
  final int? team2Score1;
  final int? team1Score2;
  final int? team2Score2;
  final int? team1Score3;
  final int? team2Score3;
  final String status;

  Match({
    required this.type,
    required this.team1Player1,
    this.team1Player2,
    required this.team2Player1,
    this.team2Player2,
    this.team1Score1,
    this.team2Score1,
    this.team1Score2,
    this.team2Score2,
    this.team1Score3,
    this.team2Score3,
    required this.status,
  });

  String get winner {
    if (status != 'Abgeschlossen') return '';
    int team1Wins = 0;
    int team2Wins = 0;
    if (team1Score1 != null && team2Score1 != null) {
      if (team1Score1! > team2Score1!) {
        team1Wins++;
      } else {
        team2Wins++;
      }
    }
    if (team1Score2 != null && team2Score2 != null) {
      if (team1Score2! > team2Score2!) {
        team1Wins++;
      } else {
        team2Wins++;
      }
    }
    if (team1Score3 != null && team2Score3 != null) {
      if (team1Score3! > team2Score3!) {
        team1Wins++;
      } else {
        team2Wins++;
      }
    }
    return team1Wins > team2Wins ? 'Team 1' : 'Team 2';
  }
}

class Mockpage extends StatefulWidget {
  const Mockpage({super.key});

  @override
  State<Mockpage> createState() => _MockpageState();
}

class _MockpageState extends State<Mockpage> {
  final List<Match> matches = [
    Match(
      type: 'HE1',
      team1Player1: 'M. Schmidt',
      team2Player1: 'L. Weber',
      team1Score1: 21,
      team2Score1: 18,
      team1Score2: 19,
      team2Score2: 21,
      team1Score3: 21,
      team2Score3: 17,
      status: 'Abgeschlossen',
    ),
    Match(
      type: 'HE2',
      team1Player1: 'T. Müller',
      team2Player1: 'S. Becker',
      team1Score1: 21,
      team2Score1: 15,
      team1Score2: 21,
      team2Score2: 18,
      status: 'Abgeschlossen',
    ),
    Match(
      type: 'HE3',
      team1Player1: 'J. Wagner',
      team2Player1: 'F. Fischer',
      team1Score1: 18,
      team2Score1: 21,
      team1Score2: 14,
      team2Score2: 8,
      status: 'Live',
    ),
    Match(
      type: 'HD1',
      team1Player1: 'A. Klein',
      team1Player2: 'B. Wolf',
      team2Player1: 'C. Schulz',
      team2Player2: 'D. Hoffmann',
      team1Score1: 21,
      team2Score1: 19,
      team1Score2: 18,
      team2Score2: 21,
      team1Score3: 15,
      team2Score3: 10,
      status: 'Live',
    ),
    Match(
      type: 'HD2',
      team1Player1: 'E. Braun',
      team1Player2: 'G. Richter',
      team2Player1: 'H. Krause',
      team2Player2: 'I. Lehmann',
      status: 'Geplant',
    ),
    Match(
      type: 'DE',
      team1Player1: 'S. König',
      team2Player1: 'L. Huber',
      status: 'Geplant',
    ),
    Match(
      type: 'DD',
      team1Player1: 'M. Schmitt',
      team1Player2: 'N. Werner',
      team2Player1: 'O. Meyer',
      team2Player2: 'P. Keller',
      status: 'Geplant',
    ),
    Match(
      type: 'MX',
      team1Player1: 'Q. Koch',
      team1Player2: 'R. Bauer',
      team2Player1: 'S. Neumann',
      team2Player2: 'T. Schwarz',
      status: 'Geplant',
    ),
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  return _buildMatchCard(matches[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1A237E), Color(0xFF0D47A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Live Match',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '8 Spiele',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              _buildScorePill('Team A: 3', Colors.green),
              SizedBox(width: 8),
              _buildScorePill('Team B: 1', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScorePill(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMatchCard(Match match, int index) {
    final statusColor = match.status == 'Abgeschlossen'
        ? Colors.green
        : match.status == 'Live'
        ? Colors.red
        : Colors.grey;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => _buildExpandedView(match),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3A5F), Color(0xFF2D4A6F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _getMatchTypeName(match.type),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: statusColor.withOpacity(0.5),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  if (match.status == 'Abgeschlossen' ||
                      match.status == 'Live') ...[
                    Text(
                      '${match.team1Score1 ?? 0} : ${match.team2Score1 ?? 0}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (match.team1Score2 != null)
                      Text(
                        '${match.team1Score2} : ${match.team2Score2}',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                  ] else ...[
                    Icon(Icons.sports_tennis, color: Colors.white38, size: 40),
                    SizedBox(height: 4),
                    Text(
                      'Geplant',
                      style: TextStyle(color: Colors.white60, fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedView(Match match) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Color(0xFF0A0E27),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getMatchTypeName(match.type),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: match.status == 'Abgeschlossen'
                              ? Colors.green.withOpacity(0.2)
                              : match.status == 'Live'
                              ? Colors.red.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          match.status,
                          style: TextStyle(
                            color: match.status == 'Abgeschlossen'
                                ? Colors.green
                                : match.status == 'Live'
                                ? Colors.red
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  _buildTeamInfo(
                    'Team 1',
                    match.team1Player1,
                    match.team1Player2,
                  ),
                  SizedBox(height: 24),
                  if (match.status != 'Geplant') _buildScoreDetails(match),
                  SizedBox(height: 24),
                  _buildTeamInfo(
                    'Team 2',
                    match.team2Player1,
                    match.team2Player2,
                  ),
                  if (match.winner.isNotEmpty) ...[
                    SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber.shade700,
                            Colors.orange.shade600,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.emoji_events, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            '${match.winner} gewinnt!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamInfo(String teamName, String player1, String? player2) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF1E3A5F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            teamName,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            player1,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (player2 != null) ...[
            SizedBox(height: 4),
            Text(
              player2,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildScoreDetails(Match match) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2D4A6F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Satzergebnisse',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          if (match.team1Score1 != null)
            _buildSetRow('Satz 1', match.team1Score1!, match.team2Score1!),
          if (match.team1Score2 != null) ...[
            SizedBox(height: 8),
            _buildSetRow('Satz 2', match.team1Score2!, match.team2Score2!),
          ],
          if (match.team1Score3 != null) ...[
            SizedBox(height: 8),
            _buildSetRow('Satz 3', match.team1Score3!, match.team2Score3!),
          ],
        ],
      ),
    );
  }

  Widget _buildSetRow(String setName, int score1, int score2) {
    final winner = score1 > score2 ? 1 : 2;
    return Row(
      children: [
        Expanded(
          child: Text(setName, style: TextStyle(color: Colors.white70)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: winner == 1
                ? Colors.green.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            score1.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: winner == 1 ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            ':',
            style: TextStyle(color: Colors.white70, fontSize: 18),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: winner == 2
                ? Colors.green.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            score2.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: winner == 2 ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  String _getMatchTypeName(String type) {
    switch (type) {
      case 'HE1':
      case 'HE2':
      case 'HE3':
        return 'Herren Einzel ${type.substring(2)}';
      case 'HD1':
      case 'HD2':
        return 'Herren Doppel ${type.substring(2)}';
      case 'DE':
        return 'Damen Einzel';
      case 'DD':
        return 'Damen Doppel';
      case 'MX':
        return 'Mixed';
      default:
        return type;
    }
  }
}
