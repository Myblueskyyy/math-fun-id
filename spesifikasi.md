# Dokumen Kebutuhan dan Spesifikasi
## Pengembangan Media Pembelajaran Matematika Interaktif Berbasis Smartphone

---

### 1. Deskripsi Proyek
[cite_start]Proyek ini adalah pengembangan media pembelajaran matematika interaktif berbasis *smartphone*[cite: 1]. [cite_start]Aplikasi ini dirancang sebagai upaya untuk menumbuhkan kemampuan literasi numerasi siswa di tingkat SMP[cite: 2]. [cite_start]Materi utama yang dibahas dalam aplikasi ini adalah Aritmatika Sosial[cite: 3].

### 2. Tujuan Pembelajaran
Setelah menggunakan aplikasi ini, siswa diharapkan mampu:
* [cite_start]Memahami konsep harga beli dan harga jual[cite: 16].
* [cite_start]Menghitung keuntungan dan kerugian beserta persentasenya[cite: 17].
* [cite_start]Menghitung besar diskon dan harga setelah diskon[cite: 18].
* [cite_start]Menghitung besar pajak dan harga setelah pajak[cite: 19].
* [cite_start]Menyelesaikan masalah kontekstual yang berkaitan dengan aritmatika sosial[cite: 20].

### 3. Spesifikasi Teknologi
Berdasarkan permintaan awal, aplikasi dan website pendukung yang digunakan meliputi:
* [cite_start]**Kodular**: Platform utama untuk merancang dan membangun aplikasi Android[cite: 4].
* [cite_start]**Canva**: Digunakan untuk desain antarmuka (UI) dan aset grafis[cite: 4].
* [cite_start]**Capcut**: Digunakan untuk pengeditan video atau animasi materi[cite: 4].
* [cite_start]**Pro Profs**: Digunakan sebagai pendukung pembuatan kuis/evaluasi[cite: 4].
*(Catatan Developer: Teknologi ini dapat disesuaikan menggunakan framework modern seperti Flutter atau React Native jika disetujui oleh klien untuk performa yang lebih baik).*

### 4. Kebutuhan Fungsional (Arsitektur Halaman)
Aplikasi Android ini harus memuat langkah-langkah perancangan dengan struktur halaman sebagai berikut:

#### 4.1. Halaman Awal (Splash Screen)
* [cite_start]Berisi sampul aplikasi yang ditampilkan sebelum pengguna masuk ke menu utama[cite: 6].

#### 4.2. Menu Utama
* Merupakan pusat navigasi aplikasi.
* [cite_start]Meliputi bagian pendahuluan yang menjelaskan tujuan belajar menggunakan aplikasi tersebut[cite: 7].

#### 4.3. Menu Simulasi (Pre-Test)
* [cite_start]Menampilkan soal *pre-test* dalam format pilihan ganda[cite: 8]. [cite_start](Terdiri dari 5 soal [cite: 22-47]).
* Sistem harus merekam jawaban siswa.
* [cite_start]Terdapat skor nilai di akhir yang muncul setelah siswa selesai mengerjakan soal[cite: 8].
* [cite_start]Skor tersebut harus disertakan dengan pembahasan lengkapnya atau kunci jawabannya[cite: 8].

#### 4.4. Menu Materi
* [cite_start]Berisi materi aritmatika sosial yang terbagi menjadi sub-topik: Jual-Beli, Untung Rugi, Diskon, dan Pajak[cite: 9].
* [cite_start]Terdapat contoh soal yang disajikan pada tiap materi[cite: 10].
* [cite_start]Jawaban harus disediakan untuk setiap contoh soal yang diberikan[cite: 10].
* **Rumus Utama yang Ditampilkan:**
  * [cite_start]Untung: $Untung=Harga~Jual-Harga~Beli$[cite: 192]. [cite_start]Persentase $Untung=\frac{Untung}{Harga~Beli}\times100\%$[cite: 194].
  * [cite_start]Rugi: $Rugi=Harga~Beli-Harga~Jual$[cite: 209]. [cite_start]Persentase $Rugi=\frac{Rugi}{Harga~Beli}\times100\%$[cite: 209].
  * [cite_start]Diskon: $Diskon=Persentase\times Harga~Awal$[cite: 223].
  * [cite_start]Pajak: $Pajak=Persentase\times Harga~Barang$[cite: 239].

#### 4.5. Menu Evaluasi (Post-Test)
* [cite_start]Menampilkan soal *post-test* (evaluasi) dalam format pilihan ganda[cite: 11]. [cite_start](Terdiri dari 5 soal [cite: 97-122]).
* [cite_start]Terdapat skor nilai di akhir yang muncul setelah siswa selesai mengerjakan soal[cite: 11].
* [cite_start]Skor disertakan dengan pembahasan lengkapnya atau kunci jawabannya[cite: 11].

#### 4.6. Kesimpulan (Feedback Form)
* [cite_start]Halaman terakhir yang berisikan formulir atau kolom teks[cite: 12].
* [cite_start]Berfungsi untuk mengumpulkan kesan, pesan, dan kendala dari siswa selama belajar aritmatika menggunakan aplikasi tersebut[cite: 12].

---
*Dokumen ini dibuat sebagai pedoman utama pengembangan (blueprint) agar aplikasi yang dihasilkan sesuai dengan batasan dan spesifikasi yang diminta klien.*