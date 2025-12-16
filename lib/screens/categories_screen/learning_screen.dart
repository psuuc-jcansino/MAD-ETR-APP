import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home_screen.dart';

class LearningScreen extends StatefulWidget {
  final Color backgroundColor;
  const LearningScreen({
    super.key,
    this.backgroundColor = const Color(0xFFCE93D8), // purple
  });

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final String sampleChallenge =
      'Read an article or watch a short educational video.';

  bool isDone = false;

  void toggleTaskStatus() {
    setState(() => isDone = !isDone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.backgroundColor.withOpacity(0.85),
              widget.backgroundColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // BACK BUTTON
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.reply,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // ICON
                const FaIcon(
                  FontAwesomeIcons.bookOpen,
                  size: 60,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // TITLE
                _buildTitle(),
                const SizedBox(height: 6),

                // SUBTITLE
                Text(
                  'Expand your knowledge today!',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 30),

                // CHALLENGE CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 8),
                          blurRadius: 14,
                        ),
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'TODAY\'S CHALLENGE',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          sampleChallenge,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // STATUS BUTTON
                        GestureDetector(
                          onTap: toggleTaskStatus,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isDone
                                    ? [Colors.greenAccent, Colors.green]
                                    : [Colors.orangeAccent, Colors.deepOrange],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 4),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FaIcon(
                                  isDone
                                      ? FontAwesomeIcons.checkCircle
                                      : FontAwesomeIcons.circle,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  isDone ? 'Completed' : 'Mark as Done',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // RANDOM CHALLENGE BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: _buildActionButton(
                    icon: FontAwesomeIcons.shuffle,
                    label: 'Get Random Challenge',
                    onTap: () {
                      // TODO: fetch random challenge from SQLite
                    },
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- TITLE ----------
  Widget _buildTitle() {
    return Stack(
      children: [
        Positioned(
          left: 3,
          top: 3,
          child: Text(
            'LEARNING',
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
          'LEARNING',
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

  // ---------- ACTION BUTTON ----------
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: color ?? Colors.black87,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
