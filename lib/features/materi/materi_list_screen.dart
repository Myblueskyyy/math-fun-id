import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/models/materi.dart';
import '../../shared/widgets/custom_card.dart';
import '../../core/widgets/bubbly_background.dart';
import 'simulations/jual_beli_simulation.dart';
import 'simulations/untung_rugi_simulation.dart';
import 'simulations/diskon_simulation.dart';
import 'simulations/pajak_simulation.dart';
import 'visual_illustrations/apple_illustration.dart';
import 'visual_illustrations/market_illustration.dart';
import 'materi_detail_screen.dart';
import '../../core/utils/audio_controller.dart';

final List<Materi> listMateri = [
  Materi(
    title: 'Jual-Beli',
    description: 'Konsep dasar perdagangan: Harga Beli & Harga Jual.',
    content:
        'Dalam perdagangan, terdapat dua istilah penting: Harga Beli (HB) dan Harga Jual (HJ). Harga Beli adalah harga saat pedagang membeli barang, sedangkan Harga Jual adalah harga saat pedagang menjual barang tersebut kepada pembeli.',
    formulas: {
      'Harga Beli (HB)': 'Harga awal saat membeli barang.',
      'Harga Jual (HJ)': 'Harga saat menjual barang.',
    },
    examples: [
      ExampleQuestion(
        question:
            'Seseorang membeli buku seharga Rp10.000 dan menjualnya kembali seharga Rp12.000. Mana yang merupakan Harga Beli?',
        solution: 'Harga Beli adalah Rp10.000.',
      ),
    ],
    icon: Icons.shopping_basket_rounded,
    color: Colors.blue,
    interactiveWidget: (context) => const JualBeliSimulation(),
    caseStudy:
        'Budi pergi ke pasar grosir dan membeli sekarung beras seharga Rp 250.000 (Harga Beli). Kemudian, Budi mengemas beras tersebut ke dalam kemasan kecil dan total hasil penjualannya mencapai Rp 300.000 (Harga Jual) di warungnya.',
    visualIllustrationWidget: (context) => const MarketVisualIllustration(),
    voiceOverPath: 'voice-over/anis1.mp3',
  ),
  Materi(
    title: 'Untung-Rugi',
    description: 'Menghitung selisih harga dan persentasenya.',
    content: 'Untung terjadi jika HJ > HB. Rugi terjadi jika HJ < HB.',
    formulas: {
      'Untung': 'HJ - HB',
      'Rugi': 'HB - HJ',
      'Persentase Untung': '(Untung / HB) x 100%',
    },
    examples: [
      ExampleQuestion(
        question:
            'Pedagang beli tas Rp150.000, jual Rp180.000. Berapa untungnya?',
        solution: 'Untung = 180.000 - 150.000 = 30.000.',
      ),
    ],
    icon: Icons.trending_up_rounded,
    color: Colors.green,
    interactiveWidget: (context) => const UntungRugiSimulation(),
    caseStudy:
        'Pak Rahmat membeli sepeda bekas seharga Rp 500.000. Ia memperbaiki sepedanya dengan biaya Rp 100.000 (total modal/harga beli riil Rp 600.000). Sebulan kemudian, pak Rahmat menjual sepedanya seharga Rp 750.000. Artinya pak Rahmat mendapat keuntungan sebesar Rp 150.000.',
    visualIllustrationWidget: (context) =>
        const AppleAdditionIllustration(), // Re-using as simple addition logic visually
    voiceOverPath: 'voice-over/angga1.wav',
  ),
  Materi(
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
  ),
  Materi(
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
        title: const Text('Materi Aritmatika Sosial'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BubblyBackground(
        child: SafeArea(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: listMateri.length,
            itemBuilder: (context, index) {
              final materi = listMateri[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomCard(
                  onTap: () {
                    AudioController.instance.playButtonClick();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MateriDetailScreen(materi: materi),
                      ),
                    );
                  },
                  color: Colors.white,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: materi.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(materi.icon, color: materi.color, size: 30),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              materi.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              materi.description,
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
