import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../core/theme/theme_provider.dart';
import '../quiz/quiz_provider.dart';
import '../quiz/quiz_repository.dart';
import '../quiz/quiz_screen.dart';
import 'intro_screen.dart';
import '../materi/materi_list_screen.dart';
import '../feedback/feedback_screen.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../core/widgets/bubbly_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Soft cyan background pattern
      extendBody: true, // Allow body to stretch behind the navbar
      body: BubblyBackground(child: _buildBody(context)),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Text(
                        'Aritmatika Sosial',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = const Color(0xFF5E35B1),
                        ),
                      ),
                      const Text(
                        'Aritmatika Sosial',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: BubblyButton(
                        title: 'Pendahuluan',
                        subtitle: 'Tujuan & Manfaat',
                        icon: Icons.smart_toy_rounded, // Robot icon
                        mainColor: const Color(0xFF64B5F6), // Blue
                        shadowColor: const Color(0xFF1E88E5),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const IntroScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: BubblyButton(
                        title: 'Simulasi\n(Pre-test)',
                        subtitle: '5 Soal Latihan',
                        icon: Icons.star_rounded, // Star icon
                        mainColor: const Color(0xFFFFD54F), // Yellow
                        shadowColor: const Color(0xFFFFB300),
                        onTap: () {
                          final provider = Provider.of<QuizProvider>(
                            context,
                            listen: false,
                          );
                          provider.startQuiz(QuizRepository.preTestQuestions);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const QuizScreen(
                                title: AppStrings.menuSimulasi,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: BubblyButton(
                        title: 'Materi\nBelajar',
                        subtitle: 'Konsep & Rumus',
                        icon: Icons.auto_awesome_rounded, // Wizard/Magic icon
                        mainColor: const Color(0xFF81C784), // Green
                        shadowColor: const Color(0xFF43A047),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MateriListScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: BubblyButton(
                        title: 'Evaluasi\n(Post-test)',
                        subtitle: 'Uji Pemahaman',
                        icon: Icons.inventory_2_rounded, // Treasure icon
                        mainColor: const Color(0xFFBA68C8), // Purple
                        shadowColor: const Color(0xFF8E24AA),
                        onTap: () {
                          final provider = Provider.of<QuizProvider>(
                            context,
                            listen: false,
                          );
                          provider.startQuiz(QuizRepository.postTestQuestions);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const QuizScreen(
                                title: AppStrings.menuEvaluasi,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                BubblyButton(
                  title: 'Kesimpulan',
                  subtitle: 'Kesan & Pesan',
                  icon: Icons.cloud_rounded, // Cloud icon
                  mainColor: const Color(0xFFF06292), // Pink
                  shadowColor: const Color(0xFFD81B60),
                  isFullWidth: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 250,
      margin: const EdgeInsets.only(bottom: 15),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background floating island base
          Positioned(
            top: -60,
            child: Container(
              width: 320,
              height: 240,
              decoration: BoxDecoration(
                color: const Color(0xFF8D6E63), // Dirt color
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),
          // Grass top
          Positioned(
            top: -60,
            child: Container(
              width: 330,
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFFA1D07A), // Grass top color
                borderRadius: BorderRadius.circular(150),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
            ),
          ),
          // Floating clouds around the island
          Positioned(
            top: 100,
            left: 20,
            child: Icon(
              Icons.cloud,
              color: Colors.white.withOpacity(0.8),
              size: 40,
            ),
          ),
          Positioned(
            top: 150,
            right: 30,
            child: Icon(
              Icons.cloud,
              color: Colors.white.withOpacity(0.8),
              size: 50,
            ),
          ),
          Positioned(
            top: 170,
            left: 60,
            child: Icon(
              Icons.cloud,
              color: Colors.white.withOpacity(0.4),
              size: 30,
            ),
          ),
          // Math Fun Title
          Positioned(
            top: 0,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildBubblyText('M', const Color(0xFF64B5F6), angle: -0.1),
                    _buildBubblyText('a', const Color(0xFFF06292), angle: 0.05),
                    _buildBubblyText(
                      't',
                      const Color(0xFFFFD54F),
                      angle: -0.05,
                    ),
                    _buildBubblyText('h', const Color(0xFF81C784), angle: 0.1),
                  ],
                ),
                Transform.translate(
                  offset: const Offset(0, -15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildBubblyText(
                        'F',
                        const Color(0xFFBA68C8),
                        angle: -0.08,
                      ),
                      _buildBubblyText(
                        'u',
                        const Color(0xFF64B5F6),
                        angle: 0.02,
                      ),
                      _buildBubblyText(
                        'n',
                        const Color(0xFFFFD54F),
                        angle: -0.05,
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

  Widget _buildBubblyText(String text, Color color, {double angle = 0}) {
    return Transform.rotate(
      angle: angle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Stack(
          children: [
            // Stroke
            Text(
              text,
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 10
                  ..color = Colors.white,
              ),
            ),
            // Shadow under the text itself
            Text(
              text,
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                color: color,
                shadows: const [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == 1) {
              themeProvider.toggleTheme();
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF64B5F6), // Blue like mockup
          unselectedItemColor: isDark
              ? Colors.white54
              : const Color(0xFF9E9E9E),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: [
            const BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Icons.home_rounded, size: 28),
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.nightlight_round,
                  size: 28,
                ),
              ),
              label: 'Mode',
            ),
          ],
        ),
      ),
    );
  }
}
