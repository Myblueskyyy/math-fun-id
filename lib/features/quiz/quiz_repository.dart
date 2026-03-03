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

  static List<Question> get postTestQuestions => [
        Question(
          id: 'post_1',
          text: 'Barang dibeli seharga Rp180.000 dan dijual seharga Rp225.000. Persentase keuntungan yang diperoleh adalah ....',
          options: ['20%', '22%', '25%', '30%'],
          correctAnswerIndex: 2,
          explanation: 'Untung = 225.000 - 180.000 = 45.000. Persentase = (45.000 / 180.000) x 100% = 25%.',
        ),
        Question(
          id: 'post_2',
          text: 'Sebuah toko memberikan diskon 30% pada barang seharga Rp720.000. Harga setelah diskon adalah...',
          options: ['Rp480.000', 'Rp490.000', 'Rp500.000', 'Rp504.000'],
          correctAnswerIndex: 3,
          explanation: 'Diskon = 30% x 720.000 = 216.000. Harga Akhir = 720.000 - 216.000 = 504.000.',
        ),
        Question(
          id: 'post_3',
          text: 'Tabungan sebesar Rp2.400.000 memperoleh bunga tunggal 6% per tahun. Besar bunga yang diterima dalam 1 tahun adalah ....',
          options: ['Rp120.000', 'Rp134.000', 'Rp144.000', 'Rp156.000'],
          correctAnswerIndex: 2,
          explanation: 'Bunga = 2.400.000 x 6% = 144.000.',
        ),
        Question(
          id: 'post_4',
          text: 'Sebuah barang dijual seharga Rp414.000 dan mengalami kerugian 9%. Harga pembelian barang tersebut adalah ....',
          options: ['Rp430.000', 'Rp440.000', 'Rp450.000', 'Rp455.000'],
          correctAnswerIndex: 3,
          explanation: 'HJ = 91% x HB. 414.000 = 0,91 x HB. HB = 414.000 / 0,91 = 455.000.',
        ),
        Question(
          id: 'post_5',
          text: 'Suatu barang mengalami kenaikan 15% kemudian turun 10%. Jika harga awal Rp400.000, maka harga akhirnya adalah...',
          options: ['Rp410.000', 'Rp412.000', 'Rp414.000', 'Rp420.000'],
          correctAnswerIndex: 2,
          explanation: 'Kenaikan: 15% x 400rb = 60rb (Total 460rb). Penurunan: 10% x 460rb = 46rb. Harga Akhir = 460rb - 46rb = 414rb.',
        ),
      ];
}
