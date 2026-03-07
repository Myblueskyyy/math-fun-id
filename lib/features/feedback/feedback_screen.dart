import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bubbly_background.dart';
import '../../core/widgets/bubbly_button.dart';
import '../../shared/widgets/custom_card.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSubmitted = false;

  Future<void> _sendEmail() async {
    final Email email = Email(
      body: _feedbackController.text,
      subject: 'Feedback Aplikasi Math Fun',
      recipients: ['ahmdfaiz27@gmail.com'], // Ganti dengan email developer asli
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      setState(() => _isSubmitted = true);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengirim email: $error'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Kesimpulan'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BubblyBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: _isSubmitted
                ? _buildSuccessState(context)
                : _buildFormState(context),
          ),
        ),
      ),
    );
  }

  Widget _buildFormState(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bagaimana pengalaman belajarmu?',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Berikan kesan, pesan, atau kendala yang kamu alami selama belajar Aritmatika Sosial menggunakan aplikasi ini.',
          style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 32),
        CustomCard(
          padding: 16,
          color: Colors.white,
          child: TextField(
            controller: _feedbackController,
            maxLines: 8,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              hintText: 'Tuliskan di sini...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 32),
        BubblyButton(
          title: 'Kirim Masukan',
          icon: Icons.send_rounded,
          mainColor: const Color(0xFFBA68C8), // Purple
          shadowColor: const Color(0xFF8E24AA),
          isFullWidth: true,
          onTap: () {
            if (_feedbackController.text.isNotEmpty) {
              _sendEmail();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Silakan tuliskan masukanmu terlebih dahulu.'),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 80,
          ),
          const SizedBox(height: 24),
          const Text(
            'Terima Kasih!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Masukanmu sangat berarti untuk pengembangan aplikasi ini kedepannya.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 48),
          BubblyButton(
            title: 'Kembali ke Menu',
            icon: Icons.home_rounded,
            mainColor: const Color(0xFF64B5F6),
            shadowColor: const Color(0xFF1E88E5),
            isFullWidth: true,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
