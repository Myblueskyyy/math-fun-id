# Implementasi Audio & BGM (Background Music)

## Deskripsi
Rencana ini bertujuan untuk mengintegrasikan file audio yang ada di folder `assets/sounds/` ke dalam aplikasi menggunakan package `audioplayers`. Kita akan membuat sebuah AudioController terpusat yang mengatur pemutaran efek suara (SFX) dan pemutaran BGM secara mulus (smooth) menggunakan efek **fade-in** dan **fade-out**. Selain itu, volume BGM akan diturunkan (ducking) saat berada di layar kuis (Pre-Test / Post-Test) agar pengguna bisa lebih fokus.

## User Review Required
> [!IMPORTANT]
> Harap tinjau rencana integrasi ini. Sistem fading BGM dan ducking volume akan diatur oleh satu controller tunggal agar lebih efisien dan terpusat. Package yang digunakan adalah `audioplayers` yang baru saja ditambahkan ke `pubspec.yaml`.
> 
> Saat ini, saya berasumsi:
> - `main_bgm.mp3` dimainkan di HomeScreen dan menu lainnya.
> - `test_bgm.mp3` dimainkan di QuizScreen dengan volume yang lebih kecil (mis. 20-30%) selama "sesi menjawab".
> - `frog_bgm.mp3` dimainkan di FrogJumpScreen.
> - `mario_bgm.mp3` dimainkan di PlatformerScreen.
> - Suara SFX diletakkan saat lompat, jatuh, menjawab benar/salah, dan evaluasi.
>
> Apakah pemetaan audio ini sudah sesuai dengan yang Anda inginkan?

## Proposed Changes

---
### Pengaturan Dependency & Aset

#### [MODIFY] pubspec.yaml
- Menambahkan `assets/sounds/` ke bagian `assets:` pada file `pubspec.yaml` agar file audio dapat diakses.

---
### Audio Controller

#### [NEW] lib/core/utils/audio_controller.dart
- Membuat class `AudioController` (Singleton) untuk mengatur dua tipe audio: `_bgmPlayer` (Background Music) dan `_sfxPlayer` (Sound Effects).
- Menyediakan metode `playBgm(String path, {double targetVolume})` yang melakukan **cross-fade** (mengecilkan BGM sebelumnya perlahan, lalu membesarkan BGM baru perlahan).
- Menyediakan metode `fadeBgmVolume(double volume)` untuk mengecilkan / membesarkan volume kapan saja (ducking).
- Menyediakan metode `playSfx(String path)` untuk efek suara.

---
### Integrasi Audio pada Layar & Game

#### [MODIFY] lib/main.dart
- Menambahkan inisialisasi `AudioController` (jika diperlukan) sebelum menjalankan runApp agar audio system siap digunakan.

#### [MODIFY] lib/features/home/home_screen.dart
- Memanggil `AudioController.instance.playBgm('main_bgm.mp3')` pada fungsi `initState()` atau didalam build screen jika diperlukan untuk memastikan BGM utama berputar di Home.

#### [MODIFY] lib/features/quiz/quiz_screen.dart
- Karena ini adalah sesi Pre-Test / Post-Test, pada `initState()`, panggil `AudioController.instance.playBgm('test_bgm.mp3', targetVolume: 0.2)` untuk memutar musik test dengan volume kecil (ducking).
- Ketika user memilih jawaban, bunyikan SFX `correct_answer.mp3` atau `wrong_answer.mp3`.
- Ketika widget dihancurkan (dispose) atau quiz selesai, kembalikan volume menjadi normal / ganti ke `main_bgm.mp3`.

#### [MODIFY] lib/features/frog_jump/presentation/frog_jump_screen.dart & frog_jump_game.dart
- Memutar `frog_bgm.mp3` saat memasuki screen. Memutar kembali `main_bgm.mp3` saat keluar (dispose).
- Menambahkan pemanggilan untuk SFX: `jump_frog.mp3`, `frog_fall_watersplash.mp3`, `stage_win.mp3`, dan `stage_lose.mp3`.

#### [MODIFY] lib/features/platformer/presentation/platformer_screen.dart & platformer_game.dart
- Memutar `mario_bgm.mp3` saat memasuki screen. Memutar kembali `main_bgm.mp3` saat keluar.
- Menambahkan pemanggilan SFX: `jump_mario.mp3` untuk lompat, serta SFX benar/salah saat kuis pop-up.

## Open Questions
> [!NOTE]
> 1. Apakah ada efek suara tertentu yang Ingin Anda berikan ke Splash Screen atau Visual Novel (jika terintegrasi)?
> 2. Untuk *quiz session*, apakah BGM `test_bgm.mp3` yang diputar, atau BGM terakhir yang ada namun volumenya sekadar dikecilkan? Sesuai asumsi di atas, saya akan menggunakan `test_bgm.mp3`.

## Verification Plan
### Automated Tests
- Menjalankan `flutter pub get` untuk memastikan asset and packages synced.

### Manual Verification
- Navigasi dari HomeScreen ke minigame, pastikan BGM berganti dengan sangat smooth (tidak terputus tiba-tiba, ada efek fade out 0.5 detik dan fade in 0.5 detik).
- Coba sesi Pre-test, amati apakah volume benar-benar terasa lebih kecil dibandingkan saat di menu Home.
- Dengarkan sfx saat katak melompat (`jump_frog.mp3`) dan jatuh (`frog_fall_watersplash.mp3`).
