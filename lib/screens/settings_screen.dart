import 'package:challenge_me_app/screens/home_screen.dart';
import 'package:challenge_me_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'tasks_history_screen.dart';
import 'instructions_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;
  late AnimationController _controller;

  String difficulty = 'Normal';
  bool dailyReminder = true;
  bool animationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleMenu() {
    if (isMenuOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => isMenuOpen = !isMenuOpen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4DD0E1), Color(0xFFFFB74D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildTitle(),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildSectionTitle('CHALLENGE'),
                        _buildDropdownTile(
                          icon: FontAwesomeIcons.fire,
                          title: 'Difficulty',
                          value: difficulty,
                          items: const ['Easy', 'Normal', 'Hard'],
                          onChanged: (val) => setState(() => difficulty = val!),
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('NOTIFICATIONS'),
                        _buildSwitchTile(
                          icon: FontAwesomeIcons.bell,
                          title: 'Daily Reminder',
                          value: dailyReminder,
                          onChanged: (val) =>
                              setState(() => dailyReminder = val),
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('APPEARANCE'),
                        _buildSwitchTile(
                          icon: FontAwesomeIcons.wandMagicSparkles,
                          title: 'Animations',
                          value: animationsEnabled,
                          onChanged: (val) =>
                              setState(() => animationsEnabled = val),
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('ABOUT'),
                        _buildInfoTile(
                          icon: FontAwesomeIcons.circleInfo,
                          title: 'App Version',
                          subtitle: 'Challenge Me v1.0.0',
                        ),
                        const SizedBox(height: 20),
                        _buildDangerTile(
                          icon: FontAwesomeIcons.trash,
                          title: 'Reset Progress',
                          onTap: _confirmReset,
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Overlay when menu is open
          if (isMenuOpen)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(
                color: Colors.black54,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          // FAB menu buttons
          ..._buildFabMenu(),

          // Main FAB
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: toggleMenu,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4DD0E1), Color(0xFF00ACC1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 6),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: Colors.white24,
                      offset: Offset(-2, -2),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _controller,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFabMenu() {
    final buttons = <Map<String, dynamic>>[
      {
        'icon': FontAwesomeIcons.house,
        'tooltip': 'Home',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        ),
      },
      {
        'icon': FontAwesomeIcons.gear,
        'tooltip': 'Settings',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SettingsScreen()),
        ),
      },
      {
        'icon': FontAwesomeIcons.circleQuestion,
        'tooltip': 'Instructions',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const InstructionsScreen()),
        ),
      },
      {
        'icon': FontAwesomeIcons.history,
        'tooltip': 'History',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TasksHistoryScreen()),
        ),
      },
      {
        'icon': FontAwesomeIcons.gamepad,
        'tooltip': 'Game Screen',
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        ),
      },
    ];

    final List<Widget> widgets = [];
    for (var i = 0; i < buttons.length; i++) {
      final double offset = 80.0 * (i + 1);
      widgets.add(
        Positioned(
          bottom: 20 + offset,
          right: 20,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Interval(0.0, 1.0 - i * 0.15, curve: Curves.easeOut),
            ),
            child: GestureDetector(
              onTap: buttons[i]['onTap'] as void Function()?,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFCC80), Color(0xFFFFB74D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(0, 4),
                      blurRadius: 6,
                    ),
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Center(
                  child: FaIcon(
                    buttons[i]['icon'] as IconData,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Widget _buildTitle() {
    return Stack(
      children: [
        Positioned(
          left: 4,
          top: 4,
          child: Text(
            'SETTINGS',
            style: GoogleFonts.bahiana(
              fontSize: 60,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black45,
            ),
          ),
        ),
        Text(
          'SETTINGS',
          style: GoogleFonts.bahiana(
            fontSize: 60,
            color: Colors.white,
            shadows: const [
              Shadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 8),
            blurRadius: 12,
          ),
          BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 6),
        ],
      ),
      child: child,
    );
  }

  Widget _buildDropdownTile({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return _buildCard(
      child: Row(
        children: [
          FaIcon(icon, color: const Color(0xFF4DD0E1)),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          DropdownButton<String>(
            value: value,
            underline: const SizedBox(),
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: GoogleFonts.poppins()),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return _buildCard(
      child: Row(
        children: [
          FaIcon(icon, color: const Color(0xFFFFB74D)),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: value,
            activeColor: const Color(0xFF4DD0E1),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return _buildCard(
      child: Row(
        children: [
          FaIcon(icon, color: Colors.grey),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDangerTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: _buildCard(
        child: Row(
          children: [
            FaIcon(icon, color: Colors.redAccent),
            const SizedBox(width: 15),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmReset() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Reset Progress',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'This will clear your challenge history. Are you sure?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.poppins()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Reset', style: GoogleFonts.poppins(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
