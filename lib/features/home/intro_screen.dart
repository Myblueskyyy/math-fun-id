import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../core/widgets/bubbly_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const objectives = [
      'Memahami konsep harga beli dan harga jual',
      'Menghitung keuntungan dan kerugian beserta persentasenya',
      'Menghitung besar diskon dan harga setelah diskon',
      'Menghitung besar pajak dan harga setelah pajak',
      'Menyelesaikan masalah kontekstual aritmatika sosial',
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          AppStrings.menuPendahuluan,
          style: TextStyle(color: AppColors.surface),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BubblyBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      size: 60,
                      color: AppColors.surface,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Selamat Datang di Math Fun!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.surface,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Aplikasi ini dirancang untuk membantumu memahami materi Aritmatika Sosial dengan cara yang seru dan interaktif.',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.surface,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Tujuan Pembelajaran:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.surface,
                  ),
                ),
                const SizedBox(height: 16),
                ...objectives.map(
                  (obj) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            obj,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.surface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                BubblyButton(
                  title: 'Mulai Belajar',
                  icon: Icons.play_arrow_rounded,
                  mainColor: const Color(0xFF81C784),
                  shadowColor: const Color(0xFF43A047),
                  isFullWidth: true,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
