# Dokumentasi Implementasi Sistem Audio & Musik 🎵

Sistem audio untuk simulasi BGM (Background Music) dan SFX (Sound Effects) menggunakan `audioplayers` sudah berhasil diterapkan secara seragam pada seluruh layar permainan dan interaksi UI Anda!

## Ringkasan Perubahan

### 1. **AudioController Tersentralisasi** (`lib/core/utils/audio_controller.dart`)
   - Menggunakan Single-Instance (`Singleton`) agar tidak ada lagih BGM yang tumpang tindih.
   - Mengatur fitur *Fade In* & *Fade Out* BGM yang smooth dalam durasi 500ms agar pergantian musik terasa profesional.
   - Punya sistem SFX yang mandiri (`playSfx`) untuk memastikan "Button Click" dapat tumpang tindih dengan sukses tanpa mematikan BGM.

### 2. **Home Screen**
   - Transisi *Home Screen* kini akan segera memutar lagu `main_bgm.mp3`.
   - Mengubah layar menjadi `StatefulWidget` agar eksekusinya tepat dan tidak berulang setiap di-*refresh*.
   - Setiap navigasi utama (Simulasi, Evaluasi, Mini Game Lompat Katak / Mario Math, dsb.) memiliki interaksi transisi suara klik (`button_click.mp3`).

### 3. **Quiz Screen (Pre-Test / Evaluasi)**
   - Saat mahasiswa memulai sesi kuis evaluasi, sistem menerapkan ***Audio Ducking*** (mengecilkan volume). Ia akan langsung memutar instrumen `test_bgm.mp3` dengan target volume rendah (`0.2`).
   - Apapun hasil kuis ketika keluar (kembali ke Menu), ia segera kembali memutar `main_bgm.mp3` versi normal.
   - Mengklik pilihan jawaban (A, B, C, D) sekarang merespon menggunakan suara klik tombol.

### 4. **Visual Novel & Layar Materi Dasar**
   - Selaras dengan permohonan Anda: Visual Novel tidak merubah BGM khusus, melainkan mewarisi alunan musik `main_bgm.mp3` dari layar sebelumnya.
   - Menambahkan SFX `button_click.mp3` untuk ketukan ketika mengganti dialog halaman maupun memilih strategi interaktif dalam VN `vn_dialogue_overlay.dart`.

### 5. **Frog Jump & Platformer Mini-Game**
   - Memasuki gerbang ini akan memutar tema musik sesuai konteks: *Lompat Katak* → `frog_bgm.mp3` dan *Mario Math* → `mario_bgm.mp3`.
   - Mengubah mekanisme Dialog Bawaan seperti menekan tombol **"LANJUTKAN PETUALANGAN", "ULANGI",** maupun "MENU UTAMA" dari masing-masing sesi mini game menjadi sinkron merespon dengan bunyi klik.
   - Keluar dari menu Mini-Game juga me-*restore* `main_bgm.mp3`.

---

> [!TIP]
> Saya telah memastikan package assetsnya `assets/sounds/` dieksekusi dengan baik di `pubspec.yaml`. Jika setelah *hot-reload* Anda masih belum mendengarnya, jalankan `flutter clean` dan *restart* atau lakukan *rebuild* aplikasi.

Silakan ujicoba keseluruhan *experience* pada aplikasi game ini! Jika ada volume atau transisi suara tertentu yang perlu disesuaikan (*missal: fade diperlambat*), mohon beritahu saya.
