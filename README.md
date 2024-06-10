## StaffSpot App

### Library yang Digunakan
1. **flutter_bloc**: Untuk manajemen state dengan menggunakan arsitektur BLoC.
2. **dio**: Untuk melakukan HTTP request ke API.
3. **lottie**: Untuk menampilkan animasi loading.
4. **flutter_svg**: Untuk menampilkan gambar dalam format SVG.
5. **auto_size_text**: Untuk membuat teks menjadi responsif terhadap ukuran layar.
6. **equatable**: Untuk membandingkan objek berdasarkan propertinya.

### Cara Menjalankan
1. Install aplikasi.
2. Buka aplikasi.
3. Setelah masuk dari halaman splash screen, Anda akan diarahkan ke halaman home yang berisi daftar karyawan.
4. Tarik layar ke bawah untuk me-refresh halaman.
5. Di pojok kanan bawah, tekan tombol untuk menambahkan data karyawan.
6. Isi data karyawan dan tekan tombol "Simpan" untuk menyimpan.

### Cara Build APK
Untuk mem-build APK dari aplikasi ini, Anda dapat mengikuti langkah-langkah berikut:
1. Buka terminal di direktori proyek.
2. Jalankan perintah `flutter build apk --split-per-abi` untuk mem-build APK untuk semua arsitektur perangkat.
3. Setelah proses build selesai, APK dapat ditemukan di direktori `build/app/outputs/flutter-apk/`.

Dengan mengikuti langkah-langkah di atas, Anda dapat menggunakan aplikasi StaffSpot dengan mudah dan mem-build APK untuk distribusi.