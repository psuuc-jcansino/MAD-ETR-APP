import 'package:challenge_me_app/screens/home_screen.dart';
import 'package:challenge_me_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'instructions_screen.dart';
import 'settings_screen.dart';

class TasksHistoryScreen extends StatefulWidget {
  const TasksHistoryScreen({super.key});

  @override
  State<TasksHistoryScreen> createState() => _TasksHistoryScreenState();
}

class _TasksHistoryScreenState extends State<TasksHistoryScreen>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;
  late AnimationController _controller;

  final List<Map<String, dynamic>> completedTasks = [
    {
      'title': 'Talk to a stranger for 2 minutes',
      'category': 'Social',
      'icon': FontAwesomeIcons.peopleGroup,
      'date': 'March 10, 2025',
      'color': const Color(0xFF81D4FA),
      'status': 'Done',
    },
    {
      'title': 'Draw something using only circles',
      'category': 'Creative',
      'icon': FontAwesomeIcons.paintBrush,
      'date': 'March 9, 2025',
      'color': const Color(0xFFFFCC80),
      'status': 'Failed',
    },
    {
      'title': 'Do 20 push-ups',
      'category': 'Physical',
      'icon': FontAwesomeIcons.dumbbell,
      'date': 'March 8, 2025',
      'color': const Color(0xFFA5D6A7),
      'status': 'Done',
    },
    {
      'title': 'Meditate for 5 minutes',
      'category': 'Mindfulness',
      'icon': FontAwesomeIcons.brain,
      'date': 'March 7, 2025',
      'color': const Color(0xFFE6EE9C),
      'status': 'Failed',
    },
    {
      'title': 'Learn 3 new words',
      'category': 'Learning',
      'icon': FontAwesomeIcons.bookOpen,
      'date': 'March 6, 2025',
      'color': const Color(0xFFCE93D8),
      'status': 'Done',
    },
  ];

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
          // Background gradient
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
                  const SizedBox(height: 25),
                  Expanded(
                    child: completedTasks.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: completedTasks.length,
                            itemBuilder: (context, index) {
                              final task = completedTasks[index];
                              return _TaskHistoryTile(
                                title: task['title'] ?? 'No Title',
                                category: task['category'] ?? 'No Category',
                                icon:
                                    task['icon'] ?? FontAwesomeIcons.clipboard,
                                date: task['date'] ?? 'No Date',
                                color: task['color'] ?? Colors.grey,
                                status: task['status'] ?? 'Done',
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 80),
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
            'TASK HISTORY',
            style: GoogleFonts.bahiana(
              fontSize: 55,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black45,
            ),
          ),
        ),
        Text(
          'TASK HISTORY',
          style: GoogleFonts.bahiana(
            fontSize: 55,
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.clipboardCheck,
            size: 60,
            color: Colors.white70,
          ),
          const SizedBox(height: 20),
          Text(
            'No completed challenges yet',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Finish your first challenge to see it here!',
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class _TaskHistoryTile extends StatelessWidget {
  final String title;
  final String category;
  final IconData icon;
  final String date;
  final Color color;
  final String status;

  const _TaskHistoryTile({
    required this.title,
    required this.category,
    required this.icon,
    required this.date,
    required this.color,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDone = status.toLowerCase() == 'done';
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      color: color.withOpacity(0.9),
      child: ListTile(
        leading: FaIcon(icon, color: Colors.white, size: 32),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          '$category • $date',
          style: GoogleFonts.poppins(color: Colors.white70),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isDone ? Colors.green : Colors.redAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
