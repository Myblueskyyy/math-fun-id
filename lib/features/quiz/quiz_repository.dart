import '../../shared/models/question.dart';

class QuizRepository {
  static List<Question> get preTestQuestions => [
        Question(
          id: 'pre_1',
          text: 'Sebuah barang dibeli seharga Rp250.000 dan dijual seharga Rp300.000. Persentase keuntungan yang diperoleh adalah...',
          options: ['15%', '20%', '25%', '30%'],
          correctAnswerIndex: 1,
          explanation: 'Untung = 300.000 - 250.000 = 50.000. Persentase = (50.000 / 250.000) x 100% = 20%.',
        ),
        Question(
          id: 'pre_2',
          text: 'Toko "Maju Jaya" memberikan diskon 25% untuk semua barang. Jika harga semula Rp560.000, maka harga setelah diskon adalah...',
          options: ['Rp420.000', 'Rp430.000', 'Rp440.000', 'Rp450.000'],
          correctAnswerIndex: 0,
          explanation: 'Diskon = 25% x 560.000 = 140.000. Harga Akhir = 560.000 - 140.000 = 420.000.',
        ),
        Question(
          id: 'pre_3',
          text: 'Rina menabung Rp1.500.000 dengan bunga tunggal 10% per tahun. Besar bunga yang diperoleh selama 6 bulan adalah ....',
          options: ['Rp50.000', 'Rp60.000', 'Rp75.000', 'Rp100.000'],
          correctAnswerIndex: 2,
          explanation: 'Bunga = 1.500.000 x 0,10 x (6/12) = 75.000.',
        ),
        Question(
          id: 'pre_4',
          text: 'Seorang pedagang menjual barang seharga Rp276.000 dan mengalami kerugian 8%. Harga pembelian barang tersebut adalah...',
          options: ['Rp280.000', 'Rp290.000', 'Rp300.000', 'Rp310.000'],
          correctAnswerIndex: 2,
          explanation: 'HJ = 92% x HB. 276.000 = 0,92 x HB. HB = 276.000 / 0,92 = 300.000.',
        ),
        Question(
          id: 'pre_5',
          text: 'Sebuah barang mengalami dua kali kenaikan harga: pertama 10% dan kedua 5%. Jika harga awal Rp200.000, maka harga akhir barang tersebut adalah...',
          options: ['Rp220.000', 'Rp225.000', 'Rp230.000', 'Rp231.000'],
          correctAnswerIndex: 3,
          explanation: 'Kenaikan 1: 10% x 200rb = 20rb (Total 220rb). Kenaikan 2: 5% x 220rb = 11rb. Harga Akhir = 220rb + 11rb = 231rb.',
        ),
      ];

  static List<Question> get diskusi1Questions => [
        Question(
          id: 'd1_1',
          text: 'Seorang pedagang membeli 10 kg gula dengan harga Rp12.000/kg. Total modal pedagang adalah…',
          options: ['Rp100.000', 'Rp110.000', 'Rp120.000', 'Rp150.000'],
          correctAnswerIndex: 2,
          explanation: 'Modal = 10 × 12.000 = Rp120.000',
        ),
        Question(
          id: 'd1_2',
          text: 'Ia menjual seluruh gula tersebut dengan harga Rp15.000/kg. Total hasil penjualan adalah…',
          options: ['Rp120.000', 'Rp130.000', 'Rp140.000', 'Rp150.000'],
          correctAnswerIndex: 3,
          explanation: 'Penjualan = 10 × 15.000 = Rp150.000',
        ),
        Question(
          id: 'd1_3',
          text: 'Besar keuntungan yang diperoleh adalah…',
          options: ['Rp20.000', 'Rp25.000', 'Rp30.000', 'Rp35.000'],
          correctAnswerIndex: 2,
          explanation: 'Keuntungan = Penjualan − Modal = 150.000 − 120.000 = Rp30.000',
        ),
        Question(
          id: 'd1_4',
          text: 'Persentase keuntungan adalah…',
          options: ['20%', '25%', '30%', '35%'],
          correctAnswerIndex: 1,
          explanation: 'Persentase Keuntungan = (30.000 / 120.000) × 100% = 25%',
        ),
        Question(
          id: 'd1_5',
          text: 'Penjual dikatakan Untung jika …',
          options: ['harga jual lebih besar dari harga beli', 'harga jual lebih kecil dari harga beli', 'sama', 'semua benar'],
          correctAnswerIndex: 0,
          explanation: 'Jika harga jual > harga beli → untung. Jika harga jual < harga beli → rugi.',
        ),
      ];

  static List<Question> get postTest1Questions => [
        Question(
          id: 'pt1_1',
          text: 'Harga jual per gelas Rp8.000. Dalam sehari terjual 50 gelas. Jika modal awal Rp300.000, berapa biaya produksi per gelas?',
          options: ['Rp5.000', 'Rp6.000', 'Rp7.000', 'Rp8.000'],
          correctAnswerIndex: 1,
          explanation: 'Biaya produksi per gelas = 300.000 / 50 = Rp6.000',
        ),
        Question(
          id: 'pt1_2',
          text: 'Seorang pedagang membeli 50 kg beras dengan harga Rp10.000/kg. Ia menjual dengan harga Rp12.000/kg. Namun 5 kg rusak. Apakah pedagang untung atau rugi?',
          options: ['Untung', 'Rugi', 'Tidak tau', 'Tidak bisa ditentukan'],
          correctAnswerIndex: 0,
          explanation: 'Modal = 50 × 10.000 = 500.000. Penjualan = 45 × 12.000 = 540.000. Untung 40.000.',
        ),
        Question(
          id: 'pt1_3',
          text: 'Pedagang membeli 10 baju seharga Rp50.000/buah. Ia menjual 6 baju seharga Rp70.000 dan 4 sisanya Rp40.000. Berapakah total keuntungan/kerugian?',
          options: ['Untung Rp40.000', 'Untung Rp80.000', 'Rugi Rp40.000', 'Rugi Rp80.000'],
          correctAnswerIndex: 1,
          explanation: 'Modal = 500.000. Penjualan = (6 × 70.000) + (4 × 40.000) = 420.000 + 160.000 = 580.000. Untung 80.000.',
        ),
        Question(
          id: 'pt1_4',
          text: 'Membeli 20 kaos Rp40.000/buah. Dijual: 10 kaos Rp55.000, 5 kaos Rp50.000, 5 sisa diskon jadi Rp35.000. Berapa pendapatan?',
          options: ['Rp950.000', 'Rp975.000', 'Rp1.000.000', 'Rp1.025.000'],
          correctAnswerIndex: 1,
          explanation: 'Total = 550.000 + 250.000 + 175.000 = Rp975.000',
        ),
        Question(
          id: 'pt1_5',
          text: 'Toko A: Diskon 30%. Toko B: Diskon 20% + cashback Rp10.000. Harga Rp100.000. Mana lebih untung?',
          options: ['Toko A', 'Toko B', 'Sama saja', 'Tidak dapat ditentukan'],
          correctAnswerIndex: 2,
          explanation: 'A: 100.000 - 30.000 = 70.000. B: (100.000 - 20.000) - 10.000 = 70.000.',
        ),
      ];

  static List<Question> get diskusi2Questions => [
        Question(
          id: 'd2_1',
          text: 'Tas harga Rp200.000. Promo A diskon 30%. Harga akhir Promo A adalah…',
          options: ['Rp120.000', 'Rp130.000', 'Rp140.000', 'Rp150.000'],
          correctAnswerIndex: 2,
          explanation: '30% × 200.000 = 60.000. Harga = 200.000 - 60.000 = 140.000.',
        ),
        Question(
          id: 'd2_2',
          text: 'Promo B: Diskon 20% + cashback Rp20.000. Harga akhir Promo B adalah…',
          options: ['Rp120.000', 'Rp130.000', 'Rp140.000', 'Rp150.000'],
          correctAnswerIndex: 2,
          explanation: 'Diskon 20% = 40.000 -> 160.000. Cashback 20.000 -> 140.000.',
        ),
        Question(
          id: 'd2_3',
          text: 'Promo C: Diskon 10% + voucher Rp50.000. Harga akhir Promo C adalah…',
          options: ['Rp130.000', 'Rp140.000', 'Rp150.000', 'Rp160.000'],
          correctAnswerIndex: 0,
          explanation: 'Diskon 10% = 20.000 -> 180.000. Voucher 50.000 -> 130.000.',
        ),
        Question(
          id: 'd2_4',
          text: 'Dari Promo A, B, dan C, mana yang paling menguntungkan?',
          options: ['Promo A', 'Promo B', 'Promo C', 'Semua sama'],
          correctAnswerIndex: 2,
          explanation: 'A=140k, B=140k, C=130k. Promo C paling murah.',
        ),
        Question(
          id: 'd2_5',
          text: 'Beli buku Rp120.000 diskon 25%. Bayar dengan Rp100.000. Kembaliannya adalah…',
          options: ['Rp5.000', 'Rp10.000', 'Rp15.000', 'Rp20.000'],
          correctAnswerIndex: 1,
          explanation: 'Diskon 25% = 30.000 -> Harga 90.000. Bayar 100.000 -> Kembali 10.000.',
        ),
      ];

  static List<Question> get postTest2Questions => [
        Question(
          id: 'pt2_1',
          text: 'Harga sebuah baju Rp100.000 mendapat diskon 20%. Besar diskon adalah…',
          options: ['Rp10.000', 'Rp15.000', 'Rp20.000', 'Rp25.000'],
          correctAnswerIndex: 2,
          explanation: 'Diskon = 20% × Rp100.000 = Rp20.000',
        ),
        Question(
          id: 'pt2_2',
          text: 'Harga sepatu Rp200.000 didiskon 25%. Harga yang harus dibayar adalah…',
          options: ['Rp140.000', 'Rp150.000', 'Rp160.000', 'Rp170.000'],
          correctAnswerIndex: 1,
          explanation: 'Diskon = 25% x 200.000 = 50.000. Harga = 200.000 - 50.000 = 150.000.',
        ),
        Question(
          id: 'pt2_3',
          text: 'Sebuah tas seharga Rp150.000 mendapat diskon 20% lalu 10%. Harga akhirnya adalah…',
          options: ['Rp105.000', 'Rp108.000', 'Rp110.000', 'Rp120.000'],
          correctAnswerIndex: 1,
          explanation: 'Diskon 1 (20%) -> Rp120.000. Diskon 2 (10% dari 120.000) -> Rp108.000.',
        ),
        Question(
          id: 'pt2_4',
          text: 'Harga awal Rp120.000 menjadi Rp96.000 setelah diskon. Persentase diskon adalah…',
          options: ['15%', '20%', '25%', '30%'],
          correctAnswerIndex: 1,
          explanation: 'Besar diskon 24.000. Persentase = (24.000 / 120.000) x 100% = 20%.',
        ),
        Question(
          id: 'pt2_5',
          text: 'Setelah diskon 20%, harga menjadi Rp80.000. Harga awal barang adalah…',
          options: ['Rp90.000', 'Rp95.000', 'Rp100.000', 'Rp110.000'],
          correctAnswerIndex: 2,
          explanation: '0,8 * x = 80.000 -> x = 100.000.',
        ),
      ];

  static List<Question> get diskusi3Questions => [
        Question(
          id: 'd3_1',
          text: 'Di restoran: Makanan Rp120.000, Minuman Rp30.000. Total harga sebelum pajak adalah…',
          options: ['Rp130.000', 'Rp140.000', 'Rp150.000', 'Rp160.000'],
          correctAnswerIndex: 2,
          explanation: '120.000 + 30.000 = 150.000',
        ),
        Question(
          id: 'd3_2',
          text: 'Pajak restoran 10%. Besar pajak yang dikenakan adalah…',
          options: ['Rp10.000', 'Rp12.000', 'Rp15.000', 'Rp18.000'],
          correctAnswerIndex: 2,
          explanation: '10% × 150.000 = Rp15.000',
        ),
        Question(
          id: 'd3_3',
          text: 'Biaya layanan 5%. Besar biaya layanan adalah…',
          options: ['Rp5.000', 'Rp7.500', 'Rp10.000', 'Rp15.000'],
          correctAnswerIndex: 1,
          explanation: '5% × 150.000 = Rp7.500',
        ),
        Question(
          id: 'd3_4',
          text: 'Total yang harus dibayar pelanggan (termasuk pajak dan layanan) adalah…',
          options: ['Rp165.000', 'Rp172.500', 'Rp180.000', 'Rp187.500'],
          correctAnswerIndex: 1,
          explanation: 'Total = 150.000 + 15.000 + 7.500 = Rp172.500',
        ),
      ];

  static List<Question> get postTest3Questions => [
        Question(
          id: 'pt3_1',
          text: 'Harga sebuah tas Rp200.000. Jika dikenakan PPN 11%, harga yang harus dibayar adalah…',
          options: ['Rp211.000', 'Rp220.000', 'Rp222.000', 'Rp225.000'],
          correctAnswerIndex: 2,
          explanation: 'PPN 11% dari 200.000 = 22.000. Total = 222.000.',
        ),
        Question(
          id: 'pt3_2',
          text: 'Siswa punya uang Rp300.000, beli barang Rp270.000 pajak 10%. Apakah uangnya cukup?',
          options: ['Cukup', 'Tidak cukup', 'Tidak dapat ditentukan', 'Sama saja'],
          correctAnswerIndex: 0,
          explanation: 'Pajak 10% = 27.000. Total 297.000. 300.000 > 297.000 (Cukup).',
        ),
        Question(
          id: 'pt3_3',
          text: 'Barang Rp500.000. Toko A: Diskon 10% + Pajak 10%. Toko B: Tanpa diskon, bebas pajak. Mana yang terbaik?',
          options: ['Toko A', 'Toko B', 'Sama saja', 'Tidak dapat ditentukan'],
          correctAnswerIndex: 0,
          explanation: 'A: Diskon 10% -> 450.000. + Pajak 10% -> 495.000. B: 500.000. Toko A lebih baik.',
        ),
        Question(
          id: 'pt3_4',
          text: 'Uang Rp100.000, barang Rp95.000 pajak 10%. Apakah uangnya cukup?',
          options: ['Cukup', 'Tidak cukup', 'Tidak dapat ditentukan', 'Sama saja'],
          correctAnswerIndex: 1,
          explanation: 'Pajak 9.500. Total = 104.500. 100.000 < 104.500 (Tidak Cukup).',
        ),
        Question(
          id: 'pt3_5',
          text: 'Sepatu Rp300.000 diskon 20%, dikenakan pajak 10%. Total dibayar adalah…',
          options: ['Rp240.000', 'Rp264.000', 'Rp270.000', 'Rp280.000'],
          correctAnswerIndex: 1,
          explanation: 'Diskon 20% -> 240.000. Pajak 10% -> 24.000. Total = 264.000.',
        ),
      ];
}
