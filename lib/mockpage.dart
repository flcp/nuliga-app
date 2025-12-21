import 'package:flutter/material.dart';

class Mockpage extends StatelessWidget {
  const Mockpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BadmintonResultsScreen());
  }
}

class BadmintonResultsScreen extends StatefulWidget {
  const BadmintonResultsScreen({super.key});

  @override
  State<BadmintonResultsScreen> createState() => _BadmintonResultsScreenState();
}

class _BadmintonResultsScreenState extends State<BadmintonResultsScreen> {
  // Hardcodierte Daten
  final List<Map<String, dynamic>> _matchups = [
    {
      'type': '1. HE',
      'player1': 'Max Mustermann',
      'player2': 'John Doe',
      'result': ['21:18', '21:15'],
      'winner': 'Max Mustermann',
    },
    {
      'type': '2. HE',
      'player1': 'Peter Müller',
      'player2': 'Tom Smith',
      'result': ['18:21', '15:21'],
      'winner': 'Tom Smith',
    },
    {
      'type': '1. HD',
      'player1': 'Müller/Schmidt',
      'player2': 'Doe/Smith',
      'result': ['21:19', '21:17'],
      'winner': 'Müller/Schmidt',
    },
    {
      'type': '2. HD',
      'player1': 'Becker/Wagner',
      'player2': 'Brown/Wilson',
      'result': ['19:21', '21:18', '15:21'],
      'winner': 'Brown/Wilson',
    },
  ];

  // Filter-Optionen
  String? _selectedDiscipline;
  String? _selectedPlayer;

  // Liste der Disziplinen für den Filter
  final List<String> _disciplines = ['1. HE', '2. HE', '1. HD', '2. HD'];

  // Liste der Spieler für den Filter
  List<String> get _players {
    final players = <String>[];
    for (final matchup in _matchups) {
      players.add(matchup['player1']);
      players.add(matchup['player2']);
    }
    return players.toSet().toList();
  }

  // Gefilterte Matchups
  List<Map<String, dynamic>> get _filteredMatchups {
    return _matchups.where((matchup) {
      final disciplineMatch =
          _selectedDiscipline == null || matchup['type'] == _selectedDiscipline;
      final playerMatch =
          _selectedPlayer == null ||
          matchup['player1'] == _selectedPlayer ||
          matchup['player2'] == _selectedPlayer;
      return disciplineMatch && playerMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Badminton Ergebnisse',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gesamtergebnis
            const Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'GESAMTERGEBNIS',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Team A',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '6 : 2',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Team B',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Filter
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedDiscipline,
                    decoration: const InputDecoration(
                      labelText: 'Disziplin',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Alle Disziplinen'),
                      ),
                      ..._disciplines.map((discipline) {
                        return DropdownMenuItem(
                          value: discipline,
                          child: Text(discipline),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedDiscipline = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedPlayer,
                    decoration: const InputDecoration(
                      labelText: 'Spieler',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('Alle Spieler'),
                      ),
                      ..._players.map((player) {
                        return DropdownMenuItem(
                          value: player,
                          child: Text(player),
                        );
                      }),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedPlayer = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Matchups
            Expanded(
              child: ListView.builder(
                itemCount: _filteredMatchups.length,
                itemBuilder: (context, index) {
                  final matchup = _filteredMatchups[index];
                  return _buildMatchupCard(matchup);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchupCard(Map<String, dynamic> matchup) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  matchup['type'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '${matchup['result'].length} Sätze',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    matchup['player1'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: matchup['player1'] == matchup['winner']
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    matchup['player2'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: matchup['player2'] == matchup['winner']
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Center(
              child: Column(
                children: (matchup['result'] as List<String>)
                    .map(
                      (score) => Text(
                        score,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
