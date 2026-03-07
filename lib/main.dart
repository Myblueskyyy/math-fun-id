import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/home/splash_screen.dart';
import 'features/quiz/quiz_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => QuizProvider())],
      child: const MathFunApp(),
    ),
  );
}

class MathFunApp extends StatelessWidget {
  const MathFunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Fun',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
