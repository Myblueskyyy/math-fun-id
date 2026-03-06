import '../models/story_node.dart';

class StoryData {
  static Map<String, StoryNode> getEpisode1() {
    return {
      'start': StoryNode(
        id: 'start',
        speakerName: 'Bimo',
        dialogue: 'Halo! Selamat datang di Warung Bimo. Hari ini ramai sekali!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'char_bimo.png',
        nextNodeId: 'customer_comes',
      ),
      'customer_comes': StoryNode(
        id: 'customer_comes',
        speakerName: 'Bimo',
        dialogue:
            'Ada pelanggan mau beli beras. Modal awal beras ini Rp10.000 per kilo.',
        backgroundId: 'bg_warung.png',
        characterRightId: 'char_bimo.png',
        nextNodeId: 'question',
      ),
      'question': StoryNode(
        id: 'question',
        speakerName: 'Bimo',
        dialogue:
            'Jika harga modal beras Rp10.000, berapa harga jual yang pas agar kita bisa untung dan membayar listrik warung?',
        backgroundId: 'bg_warung.png',
        characterRightId: 'char_bimo.png',
        choices: [
          Choice(text: 'Rp 10.000', nextNodeId: 'ans_10k'),
          Choice(text: 'Rp 15.000', nextNodeId: 'ans_15k'),
          Choice(text: 'Rp 8.000', nextNodeId: 'ans_8k'),
        ],
      ),
      'ans_10k': StoryNode(
        id: 'ans_10k',
        speakerName: 'Bimo',
        dialogue:
            'Waduh, kalau jualnya sama dengan modal, kita tidak dapat untung sama sekali (Rp0). Nanti tidak bisa bayar listrik dong.',
        backgroundId: 'bg_warung.png',
        characterRightId: 'char_bimo.png',
        nextNodeId: 'question', // Loop back
      ),
      'ans_8k': StoryNode(
        id: 'ans_8k',
        speakerName: 'Bimo',
        dialogue:
            'Kalau jualnya Rp8.000, kita malah rugi Rp2.000 tiap kilonya! Bisa bangkrut warung ini.',
        backgroundId: 'bg_warung.png',
        characterRightId: 'char_bimo.png',
        nextNodeId: 'question', // Loop back
      ),
      'ans_15k': StoryNode(
        id: 'ans_15k',
        speakerName: 'Bimo',
        dialogue:
            'Betul sekali! Dengan harga jual lebih tinggi dari modal, kita dapat untung Rp5.000 untuk bayar kebutuhan warung.',
        backgroundId: 'bg_warung.png',
        characterRightId: 'char_bimo.png',
        nextNodeId: 'end',
      ),
      'end': StoryNode(
        id: 'end',
        speakerName: 'Bimo',
        dialogue:
            'Terima kasih sudah membantuku mencari harga jual yang tepat!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'char_bimo.png',
        nextNodeId: null, // End of story
      ),
    };
  }

  static Map<String, StoryNode> getEpisode2() {
    return {
      'start': StoryNode(
        id: 'start',
        speakerName: 'Laras',
        dialogue: 'Fiuh... Panen mangga tahun ini cukup melelahkan.',
        backgroundId: 'bg_kebun.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'explain',
      ),
      'explain': StoryNode(
        id: 'explain',
        speakerName: 'Laras',
        dialogue:
            'Modal perawatan mangga ini Rp50.000. Sayangnya karena musim hujan, sebagian mangga busuk.',
        backgroundId: 'bg_kebun.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'question',
      ),
      'question': StoryNode(
        id: 'question',
        speakerName: 'Laras',
        dialogue:
            'Setelah semua buah yang bagus terjual, total pendapatan kita cuma Rp45.000. Apakah kita untung atau rugi?',
        backgroundId: 'bg_kebun.png',
        characterLeftId: 'char_laras.png',
        choices: [
          Choice(text: 'Keuntungan sebesar Rp 5.000', nextNodeId: 'ans_untung'),
          Choice(text: 'Kerugian sebesar Rp 5.000', nextNodeId: 'ans_rugi'),
        ],
      ),
      'ans_untung': StoryNode(
        id: 'ans_untung',
        speakerName: 'Laras',
        dialogue:
            'Coba dihitung lagi. Pendapatan kita (Rp45.000) lebih kecil dari modal (Rp50.000). Jadi tidak untung.',
        backgroundId: 'bg_kebun.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'question', // Loop back
      ),
      'ans_rugi': StoryNode(
        id: 'ans_rugi',
        speakerName: 'Laras',
        dialogue:
            'Tepat sekali. Karena pendapatan lebih kecil dari pengeluaran modal, kita mengalami kerugian Rp5.000. Semoga musim depan cuaca lebih bersahabat.',
        backgroundId: 'bg_kebun.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'end',
      ),
      'end': StoryNode(
        id: 'end',
        speakerName: 'Laras',
        dialogue:
            'Terima kasih atas bantuannya! Setidaknya kita jadi tahu status keuangan panen kali ini.',
        backgroundId: 'bg_kebun.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: null, // End of story
      ),
    };
  }

  static Map<String, StoryNode> getEpisode3() {
    return {
      'start': StoryNode(
        id: 'start',
        speakerName: 'Bimo',
        dialogue: 'Wah, ramai sekali Mall Pusat Diskon ini!',
        backgroundId: 'bg_mall.png',
        characterRightId: 'char_bimo.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'find_book',
      ),
      'find_book': StoryNode(
        id: 'find_book',
        speakerName: 'Laras',
        dialogue:
            'Iya! Lihat ini, ada buku tulis bagus seharga Rp20.000 dan tertulis "Diskon 25%".',
        backgroundId: 'bg_mall.png',
        characterRightId: 'char_bimo.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'question',
      ),
      'question': StoryNode(
        id: 'question',
        speakerName: 'Laras',
        dialogue:
            'Berapa jumlah uang yang harus kita bayar di kasir setelah di potong diskon 25%?',
        backgroundId: 'bg_mall.png',
        characterRightId: 'char_bimo.png',
        characterLeftId: 'char_laras.png',
        choices: [
          Choice(text: 'Rp 15.000', nextNodeId: 'ans_15k'),
          Choice(text: 'Rp 5.000', nextNodeId: 'ans_5k'),
          Choice(text: 'Rp 25.000', nextNodeId: 'ans_25k'),
        ],
      ),
      'ans_5k': StoryNode(
        id: 'ans_5k',
        speakerName: 'Bimo',
        dialogue:
            'Hmm... Rp 5.000 itu besaran diskonnya (25% dari 20.000). Kita harus membayar sisa harganya, bukan harga diskonnya.',
        backgroundId: 'bg_mall.png',
        characterRightId: 'char_bimo.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'question', // Loop back
      ),
      'ans_25k': StoryNode(
        id: 'ans_25k',
        speakerName: 'Bimo',
        dialogue:
            'Eh? Diskon itu artinya potongan harga, masa bayarnya jadi lebih mahal?',
        backgroundId: 'bg_mall.png',
        characterRightId: 'char_bimo.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'question', // Loop back
      ),
      'ans_15k': StoryNode(
        id: 'ans_15k',
        speakerName: 'Laras',
        dialogue:
            '100 untukmu! Diskon 25% * 20.000 = Rp5.000. Harga 20.000 dikurangi diskon 5.000 jadi Rp15.000.',
        backgroundId: 'bg_mall.png',
        characterRightId: 'char_bimo.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'end',
      ),
      'end': StoryNode(
        id: 'end',
        speakerName: 'Bimo',
        dialogue: 'Asyik, kita bisa menghemat Rp5.000 untuk jajan cilok!',
        backgroundId: 'bg_mall.png',
        characterRightId: 'char_bimo.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: null, // End of story
      ),
    };
  }

  static Map<String, StoryNode> getEpisode4() {
    return {
      'start': StoryNode(
        id: 'start',
        speakerName: 'Pelanggan',
        dialogue:
            'Mbak, minta bill-nya ya. Saya pesan makan dan minum total Rp100.000.',
        backgroundId: 'bg_cafe.png',
        nextNodeId: 'kasir_reply',
      ),
      'kasir_reply': StoryNode(
        id: 'kasir_reply',
        speakerName: 'Laras',
        dialogue:
            'Baik, total belanjanya Rp100.000. Tapi tunggu, di kafe kita harus menambahkan Pajak Pertambahan Nilai (PPN) 10%.',
        backgroundId: 'bg_cafe.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'question',
      ),
      'question': StoryNode(
        id: 'question',
        speakerName: 'Laras',
        dialogue:
            'Pajak tersebut akan disetorkan untuk membangun fasilitas kota. Jadi, berapa total yang harus saya tagih ke pelanggan?',
        backgroundId: 'bg_cafe.png',
        characterLeftId: 'char_laras.png',
        choices: [
          Choice(text: 'Rp 100.000', nextNodeId: 'ans_100k'),
          Choice(text: 'Rp 90.000', nextNodeId: 'ans_90k'),
          Choice(text: 'Rp 110.000', nextNodeId: 'ans_110k'),
        ],
      ),
      'ans_100k': StoryNode(
        id: 'ans_100k',
        speakerName: 'Laras',
        dialogue:
            'Itu baru harga makanannya saja. Kalau tidak memungut pajak 10%, kafe kita bisa ditegur petugas pajak, lho.',
        backgroundId: 'bg_cafe.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'question', // Loop back
      ),
      'ans_90k': StoryNode(
        id: 'ans_90k',
        speakerName: 'Laras',
        dialogue:
            'Lho, kalau pajaknya malah mengurangi harga, itu namanya diskon bukan PPN. Pajak sifatnya menambah jumlah bayar.',
        backgroundId: 'bg_cafe.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'question', // Loop back
      ),
      'ans_110k': StoryNode(
        id: 'ans_110k',
        speakerName: 'Laras',
        dialogue:
            'Tepat sekali! PPN 10% dari Rp100.000 adalah Rp10.000. Jadi total yang dibayar pelanggan adalah Rp110.000.',
        backgroundId: 'bg_cafe.png',
        characterLeftId: 'char_laras.png',
        nextNodeId: 'end',
      ),
      'end': StoryNode(
        id: 'end',
        speakerName: 'Pelanggan',
        dialogue: 'Ini uangnya Rp110.000, terima kasih!',
        backgroundId: 'bg_cafe.png',
        nextNodeId: null, // End of story
      ),
    };
  }
}
