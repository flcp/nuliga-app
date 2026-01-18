import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nuliga_app/model/followed_club.dart';
import 'package:nuliga_app/services/settings_service.dart';

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

  Timer? _rankingUrlDebounceTimer;

  bool? _isRankingUrlValid;

  final settingsService = SettingsService();

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

    _rankingUrlController.addListener(_onRankingUrlChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _shortNameController.dispose();
    _rankingUrlController.removeListener(_onRankingUrlChanged);
    _rankingUrlController.dispose();
    _matchesUrlController.dispose();

    _rankingUrlDebounceTimer?.cancel();
    super.dispose();
  }

  void _onRankingUrlChanged() async {
    _rankingUrlDebounceTimer?.cancel();
    if (_rankingUrlController.text.isEmpty) {
      setState(() {
        _isRankingUrlValid = null;
      });
      return;
    }

    _rankingUrlDebounceTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        final isValid = await _validateRankingUrl();
        setState(() {
          _isRankingUrlValid = isValid;
        });
      },
    );
  }

  Future<bool> _validateRankingUrl() {
    return settingsService.validateRankingTableUrl(_rankingUrlController.text);
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
            _buildTextField(
              'Liga Überblick URL',
              _rankingUrlController,
              isValid: _isRankingUrlValid,
            ),
            const SizedBox(height: 16),
            _buildTextField('Spielplan - gesamt', _matchesUrlController),

            const SizedBox(height: 32),
            FilledButton(onPressed: _saveClub, child: const Text('Speichern')),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool? isValid,
    String? validationText,
  }) {
    final validColor = Colors.green;
    final invalidColor = Colors.red;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: isValid != null
          ? BorderSide(color: isValid ? validColor : invalidColor, width: 2)
          : const BorderSide(width: 2),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
          ),
        ),
        if (isValid == false && validationText != null) ...[
          const SizedBox(height: 4),
          Text(
            validationText,
            style: TextStyle(fontSize: 12, color: invalidColor),
          ),
        ],
      ],
    );
  }
}
