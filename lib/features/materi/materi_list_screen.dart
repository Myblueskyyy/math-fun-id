import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/models/materi.dart';
import '../../shared/widgets/custom_card.dart';
import '../../core/widgets/bubbly_background.dart';
import 'materi_detail_screen.dart';

class MateriListScreen extends StatelessWidget {
  const MateriListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listMateri = [
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
      ),
    ];

    final isDark = Theme.of(context).brightness == Brightness.dark;

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
            padding: const EdgeInsets.all(20),
            itemCount: listMateri.length,
            itemBuilder: (context, index) {
              final materi = listMateri[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomCard(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MateriDetailScreen(materi: materi),
                    ),
                  ),
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
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
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              materi.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark
                                    ? Colors.white70
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: isDark ? Colors.white24 : Colors.grey,
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
