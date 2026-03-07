import '../models/story_node.dart';

class StoryData {
  static Map<String, StoryNode> getEpisode1() {
    return {
      'start': StoryNode(
        id: 'start',
        speakerName: 'Bimo',
        dialogue:
            'Laras! Lihat ini! Aku punya ide bisnis yang jenius untuk liburan ini!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'laras_respond',
      ),
      'laras_respond': StoryNode(
        id: 'laras_respond',
        speakerName: 'Laras',
        dialogue:
            'Wah, ide apa itu, Bim? Kalau urusan bisnis, kita harus hitung-hitungannya yang bener, lho.',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'bimo_idea',
      ),
      'bimo_idea': StoryNode(
        id: 'bimo_idea',
        speakerName: 'Bimo',
        dialogue:
            'Tenang saja! Aku mau jualan Es Lemon Segar di depan warung. Pasti laku keras!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'laras_cost',
      ),
      'laras_cost': StoryNode(
        id: 'laras_cost',
        speakerName: 'Laras',
        dialogue:
            'Hmmm, es lemon segar memang enak kalau cuaca panas begini. Tapi, Bim... Berapa modal yang kamu butuhkan untuk membuat satu gelas es lemon?',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_bingung.png',
        characterLeftId: 'laras_serius(explaining).png',
        nextNodeId: 'bimo_list',
      ),
      'bimo_list': StoryNode(
        id: 'bimo_list',
        speakerName: 'Bimo',
        dialogue:
            'Satu bungkus bubuk lemon harganya Rp1.500, terus gula dan es batu Rp1.000, sama gelas plastiknya Rp500. Jadi, totalnya... eh, berapa ya?',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'interaksi_1',
      ),
      'interaksi_1': StoryNode(
        id: 'interaksi_1',
        speakerName: 'Bantu Bimo Menghitung!',
        dialogue:
            'Harga Bubuk Lemon (Rp1.500) + Gula & Es (Rp1.000) + Gelas Plastik (Rp500) = ?',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_bingung.png',
        characterLeftId: 'laras_serius(explaining).png',
        interactionType: InteractionType.miniCalculator,
        interactionData: {'correctAnswer': 3000},
        choices: [
          Choice(text: 'Rp2.500', nextNodeId: 'wrong_calc_low'),
          Choice(text: 'Rp3.000', nextNodeId: 'right_calc'),
          Choice(text: 'Rp3.500', nextNodeId: 'wrong_calc_high'),
        ],
      ),
      'wrong_calc_low': StoryNode(
        id: 'wrong_calc_low',
        speakerName: 'Bimo',
        dialogue: 'Aduh, sepertinya kurang teliti, Bim...',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_sedih.png',
        characterLeftId: 'laras_khawatir.png',
        nextNodeId: 'interaksi_1',
      ),
      'wrong_calc_high': StoryNode(
        id: 'wrong_calc_high',
        speakerName: 'Bimo',
        dialogue: 'Waduh, kebanyakan, Laras pasti marah...',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_sedih.png',
        characterLeftId: 'laras_khawatir.png',
        nextNodeId: 'interaksi_1',
      ),
      'right_calc': StoryNode(
        id: 'right_calc',
        speakerName: 'Bimo',
        dialogue:
            'Benar! Modalnya Rp3.000! Hebat! Jadi, Modal untuk satu gelas es lemon adalah Rp3.000. Ini namanya Harga Beli (HB), Laras!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_bangga(puas).png',
        characterLeftId: 'laras_bangga.png',
        nextNodeId: 'laras_satisfied',
      ),
      'laras_satisfied': StoryNode(
        id: 'laras_satisfied',
        speakerName: 'Laras',
        dialogue:
            'Pintar, Bimo! Itu langkah pertama. Sekarang langkah kedua yang paling penting. Berapa Harga Jual (HJ) yang akan kamu tetapkan?',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'bimo_price_idea',
      ),
      'bimo_price_idea': StoryNode(
        id: 'bimo_price_idea',
        speakerName: 'Bimo',
        dialogue: 'Aku mau jual Rp5.000 per gelas! Jadi aku dapat uang banyak!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'laras_suggest_caution',
      ),
      'laras_suggest_caution': StoryNode(
        id: 'laras_suggest_caution',
        speakerName: 'Laras',
        dialogue:
            'Tunggu, Bim. Kamu harus pikirkan juga pelanggannya. Kalau Rp5.000, apakah anak-anak sekolah sanggup membelinya?',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'bimo_rethink',
      ),
      'bimo_rethink': StoryNode(
        id: 'bimo_rethink',
        speakerName: 'Bimo',
        dialogue:
            'Hmmm... iya juga ya. Kalau terlalu mahal, nanti es aku tidak laku. Oke! Aku ganti! Aku jual Rp10.000 saja, biar untungnya besar!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'laras_panic',
      ),
      'laras_panic': StoryNode(
        id: 'laras_panic',
        speakerName: 'Laras',
        dialogue:
            'Aduuuuh, Bimo! Itu namanya bunuh diri! Orang-orang pasti beli es di warung lain!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_kaget.png',
        characterLeftId: 'laras_khawatir.png',
        nextNodeId: 'interaksi_2',
      ),
      'interaksi_2': StoryNode(
        id: 'interaksi_2',
        speakerName: 'Memberi Saran Bimo',
        dialogue: 'Pilih strategi harga untuk Bimo!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        interactionType: InteractionType.strategyCards,
        choices: [
          Choice(
            text: 'Ikuti saran Laras: Rp4.000',
            nextNodeId: 'strategy_laras',
          ),
          Choice(
            text: 'Ide Bimo: Rp5.000 + Jelly',
            nextNodeId: 'strategy_jelly',
          ),
          Choice(
            text: 'Ide Bimo: Rp10.000 Es Raksasa',
            nextNodeId: 'strategy_giant',
          ),
        ],
      ),
      'strategy_laras': StoryNode(
        id: 'strategy_laras',
        speakerName: 'Bimo',
        dialogue:
            'Oke, Laras. Kita coba Rp4.000. Untung sedikit tapi laku banyak!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_bangga(puas).png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'final_lesson',
      ),
      'strategy_jelly': StoryNode(
        id: 'strategy_jelly',
        speakerName: 'Bimo',
        dialogue:
            'Wow! Topping jelly! Pasti anak-anak suka! Kita jual Rp5.000 dengan topping!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'final_lesson',
      ),
      'strategy_giant': StoryNode(
        id: 'strategy_giant',
        speakerName: 'Bimo',
        dialogue: 'Es Raksasa! Kita jual Rp10.000!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'final_lesson',
      ),
      'final_lesson': StoryNode(
        id: 'final_lesson',
        speakerName: 'Laras',
        dialogue:
            'Apapun pilihanmu, ingat prinsip utamanya, Bim... Harga Jual (HJ) harus selalu lebih besar dari Harga Beli (HB) agar kita tidak bangkrut!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'final_bimo',
      ),
      'final_bimo': StoryNode(
        id: 'final_bimo',
        speakerName: 'Bimo',
        dialogue: 'Siap, Bos Laras! Bisnis Es Lemon Bimo siap dimulai!',
        backgroundId: 'bg_warung.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: null,
      ),
    };
  }

  static Map<String, StoryNode> getEpisode2() {
    return {
      'start': StoryNode(
        id: 'start',
        speakerName: 'Laras',
        dialogue:
            'Aduh, Bimo... Sepertinya panen mangga kali ini tidak semanis bayanganku.',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_semangat.png',
        nextNodeId: 'bimo_confused',
      ),
      'bimo_confused': StoryNode(
        id: 'bimo_confused',
        speakerName: 'Bimo',
        dialogue:
            'Lho, kenapa Laras? Pohonnya kan berbuah lebat sekali! Harusnya kita bisa kaya raya!',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_bingung.png',
        nextNodeId: 'laras_problem',
      ),
      'laras_problem': StoryNode(
        id: 'laras_problem',
        speakerName: 'Laras',
        dialogue:
            'Semalam hujan deras sekali. Lihat, banyak mangga yang jatuh dan memar. Kalau sudah begini, harganya pasti jatuh atau malah tidak laku sama sekali.',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_sedih.png',
        nextNodeId: 'bimo_cost_check',
      ),
      'bimo_cost_check': StoryNode(
        id: 'bimo_cost_check',
        speakerName: 'Bimo',
        dialogue:
            'Waduh... Tapi kan kita sudah keluar uang banyak untuk pupuk dan biaya petik kemarin?',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_sedih.png',
        nextNodeId: 'laras_cost_explain',
      ),
      'laras_cost_explain': StoryNode(
        id: 'laras_cost_explain',
        speakerName: 'Laras',
        dialogue:
            'Betul. Total Harga Beli (Modal) yang kita keluarkan adalah Rp100.000. Kita harus hitung total Harga Jual (Pendapatan) hari ini untuk tahu nasib kita.',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_sedih.png',
        nextNodeId: 'interaksi_3',
      ),
      'interaksi_3': StoryNode(
        id: 'interaksi_3',
        speakerName: 'Laporan Penjualan',
        dialogue: 'Bantu Bimo menghitung total pendapatan!',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_sedih.png',
        interactionType: InteractionType.reportTable,
        interactionData: {
          'rows': [
            {'item': 'Mangga Bagus', 'qty': '8 kg', 'price': 'Rp 10.000/kg'},
            {'item': 'Mangga Memar', 'qty': '2 kg', 'price': 'Rp 5.000/kg'},
          ],
        },
        choices: [
          Choice(text: 'Rp85.000', nextNodeId: 'wrong_report_1'),
          Choice(text: 'Rp90.000', nextNodeId: 'right_report'),
          Choice(text: 'Rp100.000', nextNodeId: 'wrong_report_2'),
        ],
      ),
      'wrong_report_1': StoryNode(
        id: 'wrong_report_1',
        speakerName: 'Laras',
        dialogue: 'Coba hitung lagi, jumlah mangga memarnya belum pas!',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_serius(explaining).png',
        characterRightId: 'bimo_bingung.png',
        nextNodeId: 'interaksi_3',
      ),
      'wrong_report_2': StoryNode(
        id: 'wrong_report_2',
        speakerName: 'Bimo',
        dialogue: 'Wah, kamu terlalu optimis, banyak mangga yang rusak tadi.',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_sedih.png',
        nextNodeId: 'interaksi_3',
      ),
      'right_report': StoryNode(
        id: 'right_report',
        speakerName: 'Bimo',
        dialogue: 'Yap! Total pendapatan kita cuma Rp90.000.',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_sedih.png',
        nextNodeId: 'laras_sad',
      ),
      'laras_sad': StoryNode(
        id: 'laras_sad',
        speakerName: 'Laras',
        dialogue:
            'Bimo, coba lihat... Modal kita tadi Rp100.000, tapi uang yang kita dapatkan cuma Rp90.000.',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_sedih.png',
        nextNodeId: 'bimo_shock',
      ),
      'bimo_shock': StoryNode(
        id: 'bimo_shock',
        speakerName: 'Bimo',
        dialogue:
            'Hah?! Berarti uang kita malah berkurang Rp10.000 dari modal awal? Ini namanya apa, Laras?',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_kaget.png',
        nextNodeId: 'interaksi_4',
      ),
      'interaksi_4': StoryNode(
        id: 'interaksi_4',
        speakerName: 'Status Bisnis',
        dialogue: 'Pilih status bisnis Laras & Bimo!',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_sedih.png',
        interactionType: InteractionType.statusCards,
        choices: [
          Choice(text: 'UNTUNG', nextNodeId: 'wrong_status'),
          Choice(text: 'RUGI', nextNodeId: 'right_status'),
        ],
      ),
      'wrong_status': StoryNode(
        id: 'wrong_status',
        speakerName: 'Bimo',
        dialogue: 'Bukan, Bim! Uang kita kan berkurang, bukan bertambah!',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_sedih.png',
        characterRightId: 'bimo_sedih.png',
        nextNodeId: 'interaksi_4',
      ),
      'right_status': StoryNode(
        id: 'right_status',
        speakerName: 'Laras',
        dialogue: 'Tepat sekali. Kita mengalami Rugi sebesar Rp10.000.',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_serius(explaining).png',
        characterRightId: 'bimo_sedih.png',
        nextNodeId: 'final_comfort',
      ),
      'final_comfort': StoryNode(
        id: 'final_comfort',
        speakerName: 'Bimo',
        dialogue:
            'Jangan sedih, Laras! Namanya juga bisnis, kadang ada badai hujan. Besok kita coba lagi dengan perlindungan plastik untuk buahnya!',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_ramah(neutral).png',
        characterRightId: 'bimo_semangat.png',
        nextNodeId: 'final_lesson',
      ),
      'final_lesson': StoryNode(
        id: 'final_lesson',
        speakerName: 'Laras',
        dialogue:
            'Kamu benar, Bimo. Yang penting sekarang kita paham: kalau Harga Jual lebih kecil dari Modal, itu namanya Rugi.',
        backgroundId: 'bg_taman.png',
        characterLeftId: 'laras_ramah(neutral).png',
        characterRightId: 'bimo_bangga(puas).png',
        nextNodeId: null,
      ),
    };
  }

  static Map<String, StoryNode> getEpisode3() {
    return {
      'start': StoryNode(
        id: 'start',
        speakerName: 'Bimo',
        dialogue:
            'Laras! Lihat! Toko itu sedang mengadakan Flash Sale! Semua tas sekolah diskon besar-besaran!',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'laras_caution',
      ),
      'laras_caution': StoryNode(
        id: 'laras_caution',
        speakerName: 'Laras',
        dialogue:
            'Wah, pas sekali! Tas lamaku memang sudah mulai rusak. Tapi ingat ya, Bimo, jangan asal beli karena warnanya bagus. Kita harus hitung harga aslinya dulu!',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'bimo_astronot',
      ),
      'bimo_astronot': StoryNode(
        id: 'bimo_astronot',
        speakerName: 'Bimo',
        dialogue:
            'Tenang, ahli matematika! Lihat tas astronot itu, harganya Rp200.000. Tapi ada tulisan DISKON 25% yang besar sekali!',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        interactionType: InteractionType.imageDisplay,
        interactionData: {'image': 'tas_astronout.png'},
        nextNodeId: 'laras_explain_diskon',
      ),
      'laras_explain_diskon': StoryNode(
        id: 'laras_explain_diskon',
        speakerName: 'Laras',
        dialogue:
            'Bimo, Diskon itu artinya potongan harga. Semakin besar persentasenya, semakin murah harga yang harus kita bayar.',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'interaksi_5',
      ),
      'interaksi_5': StoryNode(
        id: 'interaksi_5',
        speakerName: 'Hitung Potongan Harga',
        dialogue:
            'Kalau diskonnya 25% dari Rp200.000, berapa potongan harganya?',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        choices: [
          Choice(text: 'Rp25.000', nextNodeId: 'wrong_diskon_1'),
          Choice(text: 'Rp50.000', nextNodeId: 'right_diskon'),
          Choice(text: 'Rp75.000', nextNodeId: 'wrong_diskon_2'),
        ],
      ),
      'wrong_diskon_1': StoryNode(
        id: 'wrong_diskon_1',
        speakerName: 'Laras',
        dialogue: 'Hmm, itu kalau diskonnya cuma 12,5%, coba lagi!',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'interaksi_5',
      ),
      'wrong_diskon_2': StoryNode(
        id: 'wrong_diskon_2',
        speakerName: 'Bimo',
        dialogue: 'Wah, kegedean! Nanti penjualnya yang rugi, hehe.',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'interaksi_5',
      ),
      'right_diskon': StoryNode(
        id: 'right_diskon',
        speakerName: 'Bimo',
        dialogue:
            'Betul! Jadi kita dapat potongan Rp50.000! Sekarang, berapa uang yang harus kamu kasih ke kasir?',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'bimo_calc_final',
      ),
      'bimo_calc_final': StoryNode(
        id: 'bimo_calc_final',
        speakerName: 'Bimo',
        dialogue:
            'Gampang! Harga Asli dikurangi Potongan Harga, kan? Rp200.000 - Rp50.000 = Rp150.000!',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'laras_compare',
      ),
      'laras_compare': StoryNode(
        id: 'laras_compare',
        speakerName: 'Laras',
        dialogue:
            'Tepat! Tapi tunggu sebentar... Tas ini harganya Rp180.000 tapi diskonnya 50%. Mana yang lebih murah, Bimo?',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'interaksi_6',
      ),
      'interaksi_6': StoryNode(
        id: 'interaksi_6',
        speakerName: 'Tantangan Perbandingan',
        dialogue: 'Mana tas yang lebih murah?',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        interactionType: InteractionType.compareChallenge,
        interactionData: {
          'item1': {
            'name': 'Tas Astronot',
            'image': 'tas_astronout.png',
            'price': 'Rp 200k',
            'diskon': '25%',
            'final': 'Rp 150.000',
          },
          'item2': {
            'name': 'Tas Merah Muda',
            'image': 'tas_astronout_pink.png',
            'price': 'Rp 180k',
            'diskon': '50%',
            'final': '?',
          },
        },
        choices: [
          Choice(text: 'Tas Astronot', nextNodeId: 'wrong_compare'),
          Choice(text: 'Tas Merah Muda (Rp90rb)', nextNodeId: 'right_compare'),
        ],
      ),
      'wrong_compare': StoryNode(
        id: 'wrong_compare',
        speakerName: 'Laras',
        dialogue:
            'Ingat, 50% itu artinya setengah harga! Jadi Rp180.000 jadi Rp90.000. Jauh lebih murah kan?',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'right_compare',
      ),
      'right_compare': StoryNode(
        id: 'right_compare',
        speakerName: 'Bimo',
        dialogue:
            'Wah! Tas Merah Muda jauh lebih murah! Belanja saat diskon memang seru ya, Laras! Kita bisa menghemat banyak uang!',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'final_lesson',
      ),
      'final_lesson': StoryNode(
        id: 'final_lesson',
        speakerName: 'Laras',
        dialogue:
            'Betul! Tapi ingat, Bimo, belanja saat diskon hanya untung kalau kita memang butuh barangnya. Kalau tidak butuh, itu namanya tetap boros!',
        backgroundId: 'bg_mall.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: null,
      ),
    };
  }

  static Map<String, StoryNode> getEpisode4() {
    return {
      'start': StoryNode(
        id: 'start',
        speakerName: 'Bimo',
        dialogue:
            'Ahhh... Es cokelat ini enak sekali, Laras! Kita berhak merayakan keberhasilan bisnis Es Lemon dan penjualan mangga kita!',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'laras_agree',
      ),
      'laras_agree': StoryNode(
        id: 'laras_agree',
        speakerName: 'Laras',
        dialogue:
            'Setuju, Bimo! Setelah semua kerja keras menghitung modal, untung, rugi, dan mencari diskon, sekarang saatnya kita menikmati hasilnya.',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_bangga.png',
        nextNodeId: 'bimo_receipt_confused',
      ),
      'bimo_receipt_confused': StoryNode(
        id: 'bimo_receipt_confused',
        speakerName: 'Bimo',
        dialogue:
            'Eh? Tunggu sebentar. Laras, coba lihat struk ini. Aku tadi pesan cokelat seharga Rp20.000 dan kamu pesan roti panggang seharga Rp30.000.',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'bimo_calc_total',
      ),
      'bimo_calc_total': StoryNode(
        id: 'bimo_calc_total',
        speakerName: 'Bimo',
        dialogue:
            'Harusnya totalnya Rp50.000, kan? Tapi kenapa di sini tertulis Rp55.000?',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        interactionType: InteractionType.strukDigital,
        interactionData: {
          'items': [
            {'name': 'Cokelat Dingin', 'price': 'Rp 20.000'},
            {'name': 'Roti Panggang', 'price': 'Rp 30.000'},
          ],
          'taxRate': '10%',
          'taxAmount': 'Rp 5.000',
          'total': 'Rp 55.000',
        },
        nextNodeId: 'interaksi_7',
      ),
      'interaksi_7': StoryNode(
        id: 'interaksi_7',
        speakerName: 'Mencari Biaya Tambahan',
        dialogue: 'Apa nama biaya tambahan 10% di struk ini?',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        choices: [
          Choice(text: 'Biaya Tip Pelayan', nextNodeId: 'wrong_tax_1'),
          Choice(text: 'Sumbangan untuk Kafe', nextNodeId: 'wrong_tax_2'),
          Choice(text: 'Pajak / PPN', nextNodeId: 'right_tax'),
        ],
      ),
      'wrong_tax_1': StoryNode(
        id: 'wrong_tax_1',
        speakerName: 'Laras',
        dialogue:
            'Bukan, kalau tip itu sukarela untuk pelayan, kalau ini wajib!',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'interaksi_7',
      ),
      'wrong_tax_2': StoryNode(
        id: 'wrong_tax_2',
        speakerName: 'Bimo',
        dialogue:
            'Hmm, bukan juga. Kafe sudah dapat untung dari harga makanan kita.',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'interaksi_7',
      ),
      'right_tax': StoryNode(
        id: 'right_tax',
        speakerName: 'Laras',
        dialogue:
            'Tepat! Pajak ini namanya PPN (Pajak Pertambahan Nilai). Kontribusi ini nantinya digunakan pemerintah untuk membangun jalan, sekolah, dan taman!',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_serius(explaining).png',
        nextNodeId: 'bimo_realization',
      ),
      'bimo_realization': StoryNode(
        id: 'bimo_realization',
        speakerName: 'Bimo',
        dialogue:
            'Ooh! Jadi taman kota indah yang kita lihat dari jendela itu... salah satunya dibangun pakai uang pajak ini?',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'laras_proud',
      ),
      'laras_proud': StoryNode(
        id: 'laras_proud',
        speakerName: 'Laras',
        dialogue:
            'Benar sekali! Jadi, saat kita membayar pajak, kita juga ikut membangun kota kita agar lebih bagus.',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'bimo_final_challenge',
      ),
      'bimo_final_challenge': StoryNode(
        id: 'bimo_final_challenge',
        speakerName: 'Bimo',
        dialogue:
            'Wah, kalau begitu aku tidak keberatan bayar lebih! Tapi Laras, bantu aku hitung satu hal lagi...',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'interaksi_8',
      ),
      'interaksi_8': StoryNode(
        id: 'interaksi_8',
        speakerName: 'Tantangan Akhir',
        dialogue:
            'Jika makan Rp100.000 dengan pajak 10%, berapa total yang harus dibayar?',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        choices: [
          Choice(text: 'Rp105.000', nextNodeId: 'wrong_final'),
          Choice(text: 'Rp110.000', nextNodeId: 'right_final'),
        ],
      ),
      'wrong_final': StoryNode(
        id: 'wrong_final',
        speakerName: 'Bimo',
        dialogue: 'Kurang sedikit lagi!',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'interaksi_8',
      ),
      'right_final': StoryNode(
        id: 'right_final',
        speakerName: 'Bimo',
        dialogue:
            'Siap! Aku harus sedia uang Rp110.000! Sekarang aku sudah jadi ahli ekonomi cilik!',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: 'final_farewell',
      ),
      'final_farewell': StoryNode(
        id: 'final_farewell',
        speakerName: 'Laras',
        dialogue:
            'Dan kamu yang di rumah juga hebat sudah membantu kami! Sampai jumpa di petualangan bisnis berikutnya!',
        backgroundId: 'bg_cafe.png',
        characterRightId: 'bimo_semangat.png',
        characterLeftId: 'laras_ramah(neutral).png',
        nextNodeId: null,
      ),
    };
  }
}
