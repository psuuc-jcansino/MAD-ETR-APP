import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutGameScreen extends StatelessWidget {
  const AboutGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 130;
    const double iconOpacity = 0.25;

    return Scaffold(
      body: Container(
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
          child: Stack(
            children: [
              // Floating background corner icons
              _buildFloatingIcon(
                FontAwesomeIcons.solidStar,
                -60,
                -40,
                -0.25,
                iconSize,
                iconOpacity,
                top: true,
                left: true,
              ),
              _buildFloatingIcon(
                FontAwesomeIcons.paintbrush,
                -50,
                -50,
                0.25,
                iconSize,
                iconOpacity,
                top: true,
                right: true,
              ),
              _buildFloatingIcon(
                FontAwesomeIcons.heart,
                -40,
                -60,
                0.2,
                iconSize,
                iconOpacity,
                bottom: true,
                left: true,
              ),
              _buildFloatingIcon(
                FontAwesomeIcons.gem,
                -50,
                -50,
                -0.2,
                iconSize,
                iconOpacity,
                bottom: true,
                right: true,
              ),

              // Main content scrollable
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 80,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Bulb icon with subtle shadow for depth
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // boxShadow: const [
                          //   BoxShadow(
                          //     color: Colors.black38,
                          //     offset: Offset(0, 4),
                          //     blurRadius: 12,
                          //   ),
                          // ],
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.lightbulb,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 25),

                      _buildTitle(),
                      const SizedBox(height: 30),

                      Text(
                        'ChallengeMe! lets you step out of your comfort zone with small, fun daily challenges. '
                        'Each day, try a new task to boost creativity, practice mindfulness, or connect with others. '
                        'Track your progress, see your completed challenges, and enjoy the thrill of surprising yourself '
                        'with a random challenge each day. Make self-improvement playful, rewarding, and exciting!',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      // Got It! button
                      SizedBox(
                        width: 200,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFD17A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            elevation: 12,
                            shadowColor: Colors.black45,
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'GOT IT!',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingIcon(
    IconData icon,
    double xOffset,
    double yOffset,
    double rotation,
    double size,
    double opacity, {
    bool top = false,
    bool bottom = false,
    bool left = false,
    bool right = false,
  }) {
    return Positioned(
      top: top ? yOffset : null,
      bottom: bottom ? yOffset : null,
      left: left ? xOffset : null,
      right: right ? xOffset : null,
      child: Transform.rotate(
        angle: rotation,
        child: FaIcon(
          icon,
          size: size,
          color: Colors.white.withOpacity(opacity),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Stack(
      children: [
        Positioned(
          left: 4,
          top: 4,
          child: Text(
            'ABOUT GAME',
            style: GoogleFonts.bahiana(
              fontSize: 62,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black45,
            ),
          ),
        ),
        Text(
          'ABOUT GAME',
          style: GoogleFonts.bahiana(
            fontSize: 62,
            color: Colors.white,
            shadows: const [
              Shadow(
                color: Colors.black38,
                offset: Offset(3, 3),
                blurRadius: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
