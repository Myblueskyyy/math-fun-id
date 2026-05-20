import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/bubbly_background.dart';

class BiodataScreen extends StatelessWidget {
  const BiodataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Biodata Penulis',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BubblyBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: const AssetImage('assets/images/penulis.jpg'),
                        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Sefti Umami',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Mahasiswa Pendidikan Matematika Pascasarjana\nUniversitas Muhammadiyah Malang',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Sefti Umami lahir di Musi Rawas pada tanggal 11 September 1981. Penulis merupakan mahasiswa Program Studi Pendidikan Matematika Pascasarjana di Universitas Muhammadiyah Malang. Penulis memiliki ketertarikan pada bidang pendidikan matematika, khususnya pengembangan media pembelajaran interaktif. Media Pembelajaran ini disusun sebagai bentuk kontribusi penulis dalam mengembangkan media pembelajaran matematika interaktif berbasis smartphone guna meningkatkan kemampuan literasi numerasi siswa SMP. Penulis berharap penelitian ini dapat memberikan manfaat bagi guru, peserta didik, maupun pengembangan pendidikan matematika di Indonesia.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.textPrimary,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
