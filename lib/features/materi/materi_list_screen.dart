import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/models/materi.dart';
import '../../shared/models/pertemuan.dart';
import '../../shared/widgets/custom_card.dart';
import '../../core/widgets/bubbly_background.dart';
import 'simulations/jual_beli_simulation.dart';
import 'simulations/untung_rugi_simulation.dart';
import 'simulations/diskon_simulation.dart';
import 'simulations/pajak_simulation.dart';
import 'visual_illustrations/apple_illustration.dart';
import 'visual_illustrations/market_illustration.dart';
import 'pertemuan_detail_screen.dart';
import '../../core/utils/audio_controller.dart';
import '../quiz/quiz_provider.dart';

final List<Pertemuan> listPertemuan = [
  Pertemuan(
    title: 'Pertemuan Pertama',
    subtitle: 'Jual Beli & Untung Rugi',
    color: Colors.blue,
    icon: Icons.storefront_rounded,
    preTestType: QuizType.preTest,
    diskusiType: QuizType.diskusi1,
    postTestType: QuizType.postTest1,
    materi: Materi(
      title: 'Jual Beli & Untung Rugi',
      description: 'Konsep dasar perdagangan dan menghitung keuntungannya.',
      content:
          'Dalam perdagangan, terdapat dua istilah penting: Harga Beli (HB) dan Harga Jual (HJ). Harga Beli adalah harga saat pedagang membeli barang, sedangkan Harga Jual adalah harga saat pedagang menjual barang tersebut kepada pembeli.\n\nUntung terjadi jika Harga Jual > Harga Beli. Rugi terjadi jika Harga Jual < Harga Beli.',
      formulas: {
        'Harga Beli (HB)': 'Harga awal saat membeli barang.',
        'Harga Jual (HJ)': 'Harga saat menjual barang.',
        'Untung': 'HJ - HB',
        'Rugi': 'HB - HJ',
        'Persentase Untung': '(Untung / HB) x 100%',
      },
      examples: [
        ExampleQuestion(
          question:
              'Seseorang membeli buku seharga Rp10.000 dan menjualnya kembali seharga Rp12.000. Mana yang merupakan Harga Beli?',
          solution: 'Harga Beli adalah Rp10.000.',
        ),
        ExampleQuestion(
          question:
              'Pedagang beli tas Rp150.000, jual Rp180.000. Berapa untungnya?',
          solution: 'Untung = 180.000 - 150.000 = 30.000.',
        ),
      ],
      icon: Icons.shopping_basket_rounded,
      color: Colors.blue,
      interactiveWidget: (context) => const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          JualBeliSimulation(),
          SizedBox(height: 16),
          UntungRugiSimulation(),
        ],
      ),
      caseStudy:
          'Budi pergi ke pasar grosir dan membeli sekarung beras seharga Rp 250.000 (Harga Beli). Kemudian, Budi mengemas beras tersebut ke dalam kemasan kecil dan total hasil penjualannya mencapai Rp 300.000 (Harga Jual) di warungnya. Artinya Budi mendapat keuntungan sebesar Rp 50.000.',
      visualIllustrationWidget: (context) => const MarketVisualIllustration(),
      voiceOverPath: 'voice-over/anis1.mp3', // Note: Need to combine or pick one
      visualNovels: [
        {'title': 'Mainkan VN Jual-Beli', 'episode': 'Episode1'},
        {'title': 'Mainkan VN Untung-Rugi', 'episode': 'Episode2'},
      ],
    ),
  ),
  Pertemuan(
    title: 'Pertemuan Kedua',
    subtitle: 'Diskon',
    color: Colors.orange,
    icon: Icons.local_offer_rounded,
    preTestType: null,
    diskusiType: QuizType.diskusi2,
    postTestType: QuizType.postTest2,
    materi: Materi(
      title: 'Diskon',
      description: 'Potongan harga untuk pembeli.',
      content:
          'Diskon adalah potongan harga yang diberikan penjual. Biasanya dinyatakan dalam persentase.',
      formulas: {
        'Besar Diskon': 'Persentase x Harga Awal',
        'Harga Akhir': 'Harga Awal - Diskon',
      },
      examples: [
        ExampleQuestion(
          question: 'Jaket Rp250.000 diskon 20%. Berapa harganya?',
          solution:
              'Diskon = 20% x 250.000 = 50.000. Harga = 250.000 - 50.000 = 200.000.',
        ),
      ],
      icon: Icons.local_offer_rounded,
      color: Colors.orange,
      interactiveWidget: (context) => const DiskonSimulation(),
      caseStudy:
          'Jelang hari raya, toko pakaian X memberikan diskon besar-besaran "Flash Sale 50%". Siti melihat baju yang awalnya dilabeli Rp 200.000. Karena diskon tersebut, Siti hanya perlu membayar separuhnya, yakni Rp 100.000 di kasir.',
      voiceOverPath: 'voice-over/anis2.mp3',
      visualNovels: [
        {'title': 'Mainkan VN Diskon', 'episode': 'Episode3'},
      ],
    ),
  ),
  Pertemuan(
    title: 'Pertemuan Ketiga',
    subtitle: 'Pajak',
    color: Colors.red,
    icon: Icons.receipt_long_rounded,
    preTestType: null,
    diskusiType: QuizType.diskusi3,
    postTestType: QuizType.postTest3,
    materi: Materi(
      title: 'Pajak',
      description: 'Biaya tambahan untuk pemerintah.',
      content:
          'Pajak adalah biaya tambahan wajib dalam transaksi. Contohnya PPN di restoran.',
      formulas: {
        'Besar Pajak': 'Persentase x Harga Barang',
        'Total Bayar': 'Harga Barang + Pajak',
      },
      examples: [
        ExampleQuestion(
          question: 'Makan Rp300.000 kena pajak 10%. Berapa totalnya?',
          solution: 'Pajak = 10% x 300.000 = 30.000. Total = 330.000.',
        ),
      ],
      icon: Icons.receipt_long_rounded,
      color: Colors.red,
      interactiveWidget: (context) => const PajakSimulation(),
      caseStudy:
          'Keluarga Andi makan malam di sebuah restoran populer. Total pesanan makanan mereka di menu adalah Rp 400.000. Saat membayar, ternyata tertera PPN 11% dari pemerintah. Andi pun harus membayar ekstra tambahan Rp 44.000 sehingga total yang digesek ke kartu adalah Rp 444.000.',
      voiceOverPath: 'voice-over/angga2.wav',
      visualNovels: [
        {'title': 'Mainkan VN Pajak', 'episode': 'Episode4'},
      ],
    ),
  ),
];

class MateriListScreen extends StatelessWidget {
  const MateriListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Pembelajaran Aritmatika Sosial'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BubblyBackground(
        child: SafeArea(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: listPertemuan.length,
            itemBuilder: (context, index) {
              final pertemuan = listPertemuan[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomCard(
                  onTap: () {
                    AudioController.instance.playButtonClick();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PertemuanDetailScreen(pertemuan: pertemuan),
                      ),
                    );
                  },
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: pertemuan.color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(pertemuan.icon, color: pertemuan.color, size: 30),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pertemuan.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              pertemuan.subtitle,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
