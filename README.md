### Tugas 8

1. **Perbedaan Navigator:** `Navigator.push()` menambahkan halaman baru, `Navigator.pushReplacement()` mengganti halaman saat ini, sedangkan `Navigator.pop()` menutup route teratas. Pada aplikasi ini, kartu Tambah Pengalaman menggunakan `push()`, sedangkan opsi Home pada drawer mengembalikan pengguna ke halaman utama.

2. **Struktur halaman:** `Scaffold` menjadi kerangka halaman, `AppBar` menampilkan judul, dan `Drawer` menyediakan navigasi. Penggunaan tema warna yang konsisten membantu menjaga tampilan antarlayar.

3. **Layout formulir:** Formulir menggunakan `Column` untuk menyusun input secara vertikal, `SizedBox` untuk mengatur jarak, dan `SingleChildScrollView` agar seluruh input serta tombol tetap dapat dijangkau pada layar kecil.

4. **Validasi formulir:** `GlobalKey<FormState>` memungkinkan akses ke state formulir, sedangkan `validator` memeriksa setiap input ketika `validate()` dijalankan. Contohnya, nama kegiatan yang hanya berisi spasi ditolak. Jenis input yang sesuai saja belum cukup karena data pengguna tetap harus diperiksa sebelum diproses.

### Progres Tugas 8

Menambahkan formulir pengalaman, navigasi melalui kartu dan drawer, validasi input, dialog ringkasan, serta preview pengalaman secara langsung.

### Penggunaan AI

ChatGPT digunakan sebagai referensi untuk memahami konsep navigasi, formulir, dan validasi. Implementasi dan pengujian dilakukan secara mandiri, dengan memeriksa kembali contoh kode serta menyesuaikannya terhadap struktur proyek.