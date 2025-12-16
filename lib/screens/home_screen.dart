import 'package:challenge_me_app/screens/tasks_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart'; // <-- QuickAlert

import 'main_screen.dart';
import 'instructions_screen.dart';
import 'settings_screen.dart';

import 'categories_screen/social_screen.dart';
import 'categories_screen/creative_screen.dart';
import 'categories_screen/physical_screen.dart';
import 'categories_screen/mindfulness_screen.dart';
import 'categories_screen/learning_screen.dart';
import 'categories_screen/fun_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;
  late AnimationController _controller;

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Social',
      'icon': FontAwesomeIcons.peopleGroup,
      'color': const Color(0xFF81D4FA),
      'screen': const SocialScreen(),
    },
    {
      'title': 'Creative',
      'icon': FontAwesomeIcons.paintBrush,
      'color': const Color(0xFFFFCC80),
      'screen': const CreativeScreen(),
    },
    {
      'title': 'Physical',
      'icon': FontAwesomeIcons.dumbbell,
      'color': const Color(0xFFA5D6A7),
      'screen': const PhysicalScreen(),
    },
    {
      'title': 'Mindfulness',
      'icon': FontAwesomeIcons.brain,
      'color': const Color(0xFFE6EE9C),
      'screen': const MindfulnessScreen(),
    },
    {
      'title': 'Learning',
      'icon': FontAwesomeIcons.bookOpen,
      'color': const Color(0xFFCE93D8),
      'screen': const LearningScreen(),
    },
    {
      'title': 'Fun',
      'icon': FontAwesomeIcons.faceLaughBeam,
      'color': const Color(0xFFFF90A0),
      'screen': const FunScreen(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          title: ' QUICK TIP ',
          text: 'Choose a category and start your challenge!',
          confirmBtnText: 'GOT IT!',
          barrierDismissible: true,
          backgroundColor: Colors.white,
          titleColor: Colors.black,
          textColor: Colors.black,
          confirmBtnColor: const Color(0xFF4DD0E1),
          onConfirmBtnTap: () => Navigator.pop(context),
        );
      });
    });
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
          // Background + Grid
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
                  const SizedBox(height: 30),
                  _buildTitle(),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        itemCount: categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: 1,
                            ),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return _buildCategoryCard(
                            context: context,
                            title: category['title'] as String,
                            icon: category['icon'] as IconData,
                            color: category['color'] as Color,
                            screen: category['screen'] as Widget,
                          );
                        },
                      ),
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

          // FAB Menu Buttons
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

  // ---------------- Title ----------------
  Widget _buildTitle() {
    return Stack(
      children: [
        Positioned(
          left: 4,
          top: 4,
          child: Text(
            'START CHALLENGE',
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
          'START CHALLENGE',
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

  // ---------------- Category Card ----------------
  Widget _buildCategoryCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 6),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 3),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 15),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- FAB Menu ----------------
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
}
