import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView>
    with SingleTickerProviderStateMixin {
  bool _darkMode = false;
  bool _notifications = true;

  String _selectedLanguage = "English";
  bool _showLanguages = false;

  final List<Map<String, String>> _languages = [
    {"name": "English", "flag": "🇺🇸"},
    {"name": "Amharic", "flag": "🇪🇹"},
    {"name": "French", "flag": "🇫🇷"},
    {"name": "Spanish", "flag": "🇪🇸"},
    {"name": "Arabic", "flag": "🇸🇦"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Header
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: colorScheme.surface,
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage("assets/profile_placeholder.png"),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: MediaQuery.of(context).size.width / 2 - 70,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.surface,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(Icons.edit, color: colorScheme.primary),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Settings List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSwitchTile(
                  title: "Dark Mode",
                  value: _darkMode,
                  onChanged: (val) => setState(() => _darkMode = val),
                  icon: Icons.dark_mode,
                  color: Colors.indigo,
                ),
                const SizedBox(height: 12),
                _buildSwitchTile(
                  title: "Notifications",
                  value: _notifications,
                  onChanged: (val) => setState(() => _notifications = val),
                  icon: Icons.notifications,
                  color: Colors.orange,
                ),
                const SizedBox(height: 12),

                // Language Selector
                _buildLanguageSelector(),

                const SizedBox(height: 12),
                _buildActionTile(
                  title: "Privacy & Security",
                  icon: Icons.lock,
                  color: Colors.green,
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _buildActionTile(
                  title: "Help & Support",
                  icon: Icons.help,
                  color: Colors.red,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Switch Tile
  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: SwitchListTile(
        secondary: CircleAvatar(
          radius: 22,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  // Action Tile
  Widget _buildActionTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Premium Language Selector
  Widget _buildLanguageSelector() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header row
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => setState(() => _showLanguages = !_showLanguages),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.blue.withOpacity(0.15),
                      child: const Icon(Icons.language, color: Colors.blue),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Language: $_selectedLanguage",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 250),
                      turns: _showLanguages ? 0.5 : 0,
                      child: const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 28, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // Expandable list
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _showLanguages
                    ? Column(
                        key: const ValueKey("langList"),
                        children: _languages.map((lang) {
                          final isActive = _selectedLanguage == lang["name"];
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              setState(() {
                                _selectedLanguage = lang["name"]!;
                                _showLanguages = false;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: isActive
                                    ? Colors.blue.withOpacity(0.08)
                                    : Colors.white,
                                border: Border.all(
                                  color: isActive
                                      ? Colors.blue
                                      : Colors.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(lang["flag"] ?? "",
                                      style: const TextStyle(fontSize: 20)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(lang["name"]!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15)),
                                  ),
                                  if (isActive)
                                    const Icon(Icons.check_circle,
                                        color: Colors.blue, size: 20),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
