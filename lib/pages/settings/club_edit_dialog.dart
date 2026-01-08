import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';

class ClubEditPage extends StatefulWidget {
  final FollowedClub? club;

  const ClubEditPage({super.key, this.club});

  @override
  State<ClubEditPage> createState() => _ClubEditPageState();
}

class _ClubEditPageState extends State<ClubEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _shortNameController;
  late TextEditingController _rankingUrlController;
  late TextEditingController _matchesUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.club?.name ?? '');
    _shortNameController = TextEditingController(
      text: widget.club?.shortName ?? '',
    );
    _rankingUrlController = TextEditingController(
      text: widget.club?.rankingTableUrl ?? '',
    );
    _matchesUrlController = TextEditingController(
      text: widget.club?.matchesUrl ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _shortNameController.dispose();
    _rankingUrlController.dispose();
    _matchesUrlController.dispose();
    super.dispose();
  }

  void _saveClub() {
    final club = FollowedClub(
      name: _nameController.text,
      shortName: _shortNameController.text,
      rankingTableUrl: _rankingUrlController.text,
      matchesUrl: _matchesUrlController.text,
    );
    Navigator.pop(context, club);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.club == null ? 'Club hinzufügen' : 'Club bearbeiten',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildTextField('Name', _nameController),
            const SizedBox(height: 16),
            _buildTextField('Kürzel', _shortNameController),
            const SizedBox(height: 16),
            _buildTextField('Tabelle', _rankingUrlController),
            const SizedBox(height: 16),
            _buildTextField('Spielplan - gesamt', _matchesUrlController),
            const SizedBox(height: 32),
            FilledButton(onPressed: _saveClub, child: const Text('Speichern')),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
