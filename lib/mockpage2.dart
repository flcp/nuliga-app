import 'package:flutter/material.dart';

class Match {
  final String discipline;
  final String teamAPlayer1;
  final String teamAPlayer2;
  final String teamBPlayer1;
  final String teamBPlayer2;
  final int teamAScore;
  final int teamBScore;
  final List<String> setScores;
  final bool isWinner;

  Match({
    required this.discipline,
    required this.teamAPlayer1,
    this.teamAPlayer2 = '',
    required this.teamBPlayer1,
    this.teamBPlayer2 = '',
    required this.teamAScore,
    required this.teamBScore,
    required this.setScores,
    required this.isWinner,
  });
}

class Mockpage2 extends StatelessWidget {
  const Mockpage2({Key? key}) : super(key: key);

  List<Match> _getMockMatches() {
    return [
      Match(
        discipline: '1. Herreneinzel',
        teamAPlayer1: 'Max Müller',
        teamBPlayer1: 'Tom Schmidt',
        teamAScore: 2,
        teamBScore: 1,
        setScores: ['21-18', '19-21', '21-17'],
        isWinner: true,
      ),
      Match(
        discipline: '2. Herreneinzel',
        teamAPlayer1: 'Felix Weber',
        teamBPlayer1: 'Jan Becker',
        teamAScore: 0,
        teamBScore: 2,
        setScores: ['15-21', '18-21'],
        isWinner: false,
      ),
      Match(
        discipline: '3. Herreneinzel',
        teamAPlayer1: 'Leon Fischer',
        teamBPlayer1: 'Paul Wagner',
        teamAScore: 2,
        teamBScore: 0,
        setScores: ['21-15', '21-19'],
        isWinner: true,
      ),
      Match(
        discipline: '1. Herrendoppel',
        teamAPlayer1: 'Max Müller',
        teamAPlayer2: 'Felix Weber',
        teamBPlayer1: 'Tom Schmidt',
        teamBPlayer2: 'Jan Becker',
        teamAScore: 2,
        teamBScore: 1,
        setScores: ['21-19', '18-21', '21-16'],
        isWinner: true,
      ),
      Match(
        discipline: '2. Herrendoppel',
        teamAPlayer1: 'Leon Fischer',
        teamAPlayer2: 'Tim Hoffmann',
        teamBPlayer1: 'Paul Wagner',
        teamBPlayer2: 'Lukas Richter',
        teamAScore: 1,
        teamBScore: 2,
        setScores: ['21-18', '17-21', '19-21'],
        isWinner: false,
      ),
      Match(
        discipline: 'Dameneinzel',
        teamAPlayer1: 'Anna Klein',
        teamBPlayer1: 'Sarah Schneider',
        teamAScore: 2,
        teamBScore: 0,
        setScores: ['21-16', '21-14'],
        isWinner: true,
      ),
      Match(
        discipline: 'Damendoppel',
        teamAPlayer1: 'Anna Klein',
        teamAPlayer2: 'Lisa Braun',
        teamBPlayer1: 'Sarah Schneider',
        teamBPlayer2: 'Julia Koch',
        teamAScore: 2,
        teamBScore: 0,
        setScores: ['21-12', '21-15'],
        isWinner: true,
      ),
      Match(
        discipline: 'Mixed',
        teamAPlayer1: 'Max Müller',
        teamAPlayer2: 'Anna Klein',
        teamBPlayer1: 'Tom Schmidt',
        teamBPlayer2: 'Sarah Schneider',
        teamAScore: 0,
        teamBScore: 2,
        setScores: ['18-21', '16-21'],
        isWinner: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final matches = _getMockMatches();
    final totalWins = matches.where((m) => m.isWinner).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Match Results',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: totalWins >= 5
                    ? [Colors.green.shade400, Colors.green.shade600]
                    : [Colors.blue.shade400, Colors.blue.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Team A',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$totalWins',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(width: 2, height: 60, color: Colors.white30),
                Column(
                  children: [
                    const Text(
                      'Team B',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${8 - totalWins}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return MatchCard(match: matches[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final Match match;

  const MatchCard({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchDetailPage(match: match),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.discipline,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            match.teamAPlayer1,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: match.isWinner
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                          if (match.teamAPlayer2.isNotEmpty)
                            Text(
                              match.teamAPlayer2,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: match.isWinner
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: match.isWinner
                            ? Colors.green.shade50
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${match.teamAScore}:${match.teamBScore}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: match.isWinner
                              ? Colors.green.shade700
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            match.teamBPlayer1,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: !match.isWinner
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          if (match.teamBPlayer2.isNotEmpty)
                            Text(
                              match.teamBPlayer2,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: !match.isWinner
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              textAlign: TextAlign.right,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MatchDetailPage extends StatelessWidget {
  final Match match;

  const MatchDetailPage({Key? key, required this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(match.discipline),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: match.isWinner
                      ? [Colors.green.shade400, Colors.green.shade600]
                      : [Colors.red.shade400, Colors.red.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    match.isWinner ? 'GEWONNEN' : 'VERLOREN',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${match.teamAScore} : ${match.teamBScore}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 56,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Spieler',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: match.isWinner
                                    ? Colors.green.shade50
                                    : Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    match.teamAPlayer1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (match.teamAPlayer2.isNotEmpty)
                                    Text(
                                      match.teamAPlayer2,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: !match.isWinner
                                    ? Colors.green.shade50
                                    : Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    match.teamBPlayer1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  if (match.teamBPlayer2.isNotEmpty)
                                    Text(
                                      match.teamBPlayer2,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sätze',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...match.setScores.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final score = entry.value;
                    final scores = score.split('-');
                    final teamASetScore = int.parse(scores[0]);
                    final teamBSetScore = int.parse(scores[1]);
                    final teamAWonSet = teamASetScore > teamBSetScore;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${idx + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              scores[0],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: teamAWonSet
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          const Text(
                            ':',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              scores[1],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: !teamAWonSet
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
