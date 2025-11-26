import 'package:flutter/material.dart';

class MockPage extends StatefulWidget {
  const MockPage({super.key});

  @override
  State<MockPage> createState() => _MockPageState();
}

class _MockPageState extends State<MockPage>
    with SingleTickerProviderStateMixin {
  // Beispiel-Daten: Favoriten-Clubs
  final List<String> favoriteClubs = [
    "FC Musterstadt",
    "SV Beispiel",
    "TSV Demo",
  ];

  String selectedClub = "FC Musterstadt"; // aktueller Club
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedClub),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.format_list_numbered), text: "Tabelle"),
            Tab(icon: Icon(Icons.event), text: "Nächste"),
            Tab(icon: Icon(Icons.history), text: "Letzte"),
          ],
        ),
      ),
      body: Column(
        children: [
          // -------------------------------
          // Favoriten-Leiste
          // -------------------------------
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              itemCount: favoriteClubs.length,
              itemBuilder: (context, index) {
                final club = favoriteClubs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(club),
                    selected: selectedClub == club,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedClub = club;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // -------------------------------
          // Tabs-Content
          // -------------------------------
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTableTab(),
                _buildUpcomingMatchesTab(),
                _buildLastMatchesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Beispiel-Tab 1: Tabelle
  Widget _buildTableTab() {
    return ListView(
      children: [
        ListTile(title: Text("1. $selectedClub – 45 Punkte")),
        ListTile(title: Text("2. SV Beispiel – 41 Punkte")),
        ListTile(title: Text("3. TSV Demo – 38 Punkte")),
      ],
    );
  }

  // Beispiel-Tab 2: Nächste Spiele
  Widget _buildUpcomingMatchesTab() {
    return ListView(
      children: [
        ListTile(title: Text("Sa 22.03 – $selectedClub vs. SV Beispiel")),
        ListTile(title: Text("Mi 26.03 – TSV Demo vs. $selectedClub")),
      ],
    );
  }

  // Beispiel-Tab 3: Letzte Spiele
  Widget _buildLastMatchesTab() {
    return ListView(
      children: [
        ListTile(title: Text("3:1 – $selectedClub vs. Blau-Weiß Test")),
        ListTile(title: Text("0:0 – $selectedClub vs. TSV Beispiel")),
      ],
    );
  }
}
