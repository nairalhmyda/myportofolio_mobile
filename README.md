# MyPortfolio Mobile
MyPortfolio Mobile adalah aplikasi Flutter untuk menampilkan profil dan daftar proyek yang pernah saya kerjakan. Pengunjung dapat membuka kartu proyek untuk melihat deskripsi dan teknologi yang digunakan.

## Fitur
-Tiga kartu profil berisi NPM, nama, dan kelas PBP.
-Tiga kartu menu dengan warna berbeda dan SnackBar yang menampilkan nama tombol.
-Lihat Proyek membuka halaman Daftar Proyek, dengan kartu yang bisa dibuka dan ditutup untuk melihat detail.
-Tambah Proyek dan Logout menampilkan SnackBar. Kalau belum ada form atau login sungguhan, jangan ditulis seolah-olah sudah ada.

## Cara Menjalankan
Siapkan Flutter SDK dan Google Chrome. Clone repositori ini, lalu buka terminal di folder yang berisi pubspec.yaml dan jalankan perintah berikut.

flutter pub get
flutter run -d chrome

## Pengujian
Jalankan perintah berikut.

flutter analyze
flutter test

flutter analyze memeriksa kode, sedangkan flutter test menjalankan dua tes widget. Tes pertama memeriksa apakah kartu profil dan menu tampil di beranda. Tes kedua memeriksa apakah tombol Lihat Proyek membuka halaman Daftar Proyek.

## Struktur Proyek

lib/main.dart menyiapkan aplikasi, tema, dan halaman awal.

lib/menu.dart menyusun beranda dan mengatur navigasi menu.

lib/models/item_homepage.dart menyimpan model data kartu menu.

lib/widgets/ berisi InfoCard dan ItemCard.

lib/screens/project_list_page.dart menampilkan daftar dan detail proyek.

test/widget_test.dart berisi tes beranda dan navigasi.

## Progress Mingguan
Tutorial 08 — Menyiapkan proyek Flutter, memisahkan main.dart dan menu.dart, serta membuat kartu profil dan menu dasar.

Tugas 7 — Mengganti identitas contoh, memberi warna berbeda pada setiap kartu menu, menambahkan halaman daftar proyek, memisahkan model dan widget, serta menulis tes widget.

# Refleksi

## Tugas 7

1. Widget tree. Widget tree adalah susunan widget yang memiliki hubungan induk dan anak. Di halaman daftar proyek, Scaffold menampung AppBar dan ListView. Di dalam ListView, setiap Card membungkus satu ExpansionTile.

2. Widget yang digunakan. MyApp membangun MaterialApp, MyHomePage menampilkan beranda, dan ProjectListPage menampilkan daftar proyek. Scaffold menjadi kerangka halaman dan AppBar menampilkan judul. Row menyusun widget secara mendatar, Column secara vertikal, Center menengahkan isi, dan GridView menyusun tombol dalam kisi. Padding memberi jarak di sekeliling isi, SizedBox memberi spasi, dan Container membungkus isi. InfoCard menampilkan identitas, ItemCard menampilkan tombol menu, Card dan Material menjadi permukaan kartu, sedangkan Text dan Icon menampilkan tulisan dan ikon. InkWell menangani ketukan dan SnackBar memberi umpan balik. ListView menampilkan daftar yang bisa digulir, ExpansionTile membuka atau menutup detail, dan ListTile menampilkan deskripsi serta teknologi proyek.

3. MaterialApp. MaterialApp menjadi dasar aplikasi karena mengatur tema bersama, menentukan halaman awal lewat home, dan menyediakan navigasi antarlayar.

4. StatelessWidget dan StatefulWidget. StatelessWidget cocok untuk bagian yang tidak perlu mengelola state lokal, seperti InfoCard. StatefulWidget cocok untuk bagian yang perlu menyimpan perubahan, misalnya pilihan filter yang bisa diubah pengguna. Widget stateless tetap bisa merespons ketukan melalui callback.

5. BuildContext. BuildContext menunjukkan posisi widget dalam widget tree. Di metode build, posisi ini membantu Flutter menemukan komponen yang dibutuhkan. Misalnya, Navigator.of(context) menemukan navigator untuk membuka halaman daftar proyek.

6. Hot reload dan hot restart. Hot reload memperbarui tampilan tanpa menghapus state dan tidak menjalankan ulang main() atau initState(). Hot restart memulai ulang aplikasi Flutter dan mereset state, sehingga cocok untuk mengecek perubahan pada inisialisasi. Kalau kode native seperti Kotlin berubah, aplikasi perlu dihentikan dan dijalankan lagi.

## Penggunaan AI
Saya menggunakan ChatGPT sebagai referensi untuk memahami instruksi tugas, melihat contoh tes widget, dan menelusuri beberapa error. Saya menerapkan perubahan pada proyek dan menjalankan pengujian sendiri.