import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'intro_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset('assets/images/background_1.png', fit: BoxFit.cover),

          SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Column: Character Image
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0, bottom: 16.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          // The Character
                          Image.asset(
                            'assets/images/welcome_screen/Char_1.png',
                            fit: BoxFit.contain,
                          ),
                          // The Fluffy Cloud Overlay
                          Positioned(
                            // Sneak it down just slightly below the frame
                            left: 20,
                            right: 20,
                            child: Image.asset(
                              'assets/images/welcome_screen/cloud_overlay.png',
                              fit: BoxFit.fitWidth,
                              // Optional: Color filter to match the vibe if it's too bright, but we keep it natural for now
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Right Column: Titles and Start Button
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Main Title
                      Flexible(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Image.asset(
                            'assets/images/welcome_screen/Title.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Question / Intro Button
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const IntroScreen(),
                                ),
                              );
                            },
                            splashColor: Colors.white24,
                            highlightColor: Colors.transparent,
                            child: SizedBox(
                              height: 70, // Slightly smaller than play button
                              child: Image.asset(
                                'assets/images/welcome_screen/question.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(width: 24),

                          // Custom Play Button Image
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            },
                            splashColor: Colors.white24,
                            highlightColor: Colors.transparent,
                            child: SizedBox(
                              height:
                                  80, // Adjust size as necessary for the button proportion
                              child: Image.asset(
                                'assets/images/welcome_screen/button_mulai.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
