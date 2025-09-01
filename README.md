Workshop Smart Contract Sui Move
Repositori ini berisi kumpulan smart contract yang ditulis dalam bahasa Move untuk blockchain Sui. Proyek ini merupakan hasil dari pembelajaran dan praktik selama mengikuti workshop, mencakup konsep-konsep dasar hingga pola desain tingkat lanjut di Sui.

Setiap file di dalam direktori sources dirancang untuk mendemonstrasikan fungsionalitas spesifik, mulai dari tipe data dasar hingga pola desain kompleks seperti owned objects, shared objects, dan capabilities.

📖 Isi Repositori
Berikut adalah penjelasan singkat untuk setiap modul smart contract yang ada di dalam repositori ini:

Konsep Dasar
belajar-string.move: Penggunaan dan manipulasi tipe data String.

belajar-number.move: Penggunaan tipe data numerik seperti u8, u32, dan u64.

belajar-bool.move: Implementasi logika menggunakan tipe data bool (boolean).

belajar-vector.move: Penggunaan vector sebagai tipe data list yang dinamis.

mahasiswa.move: Contoh struct yang menggabungkan berbagai tipe data dasar.

Pola Desain Objek Sui
owned-object.move: Implementasi Owned Object, di mana sebuah objek (misalnya KartuMahasiswa) dimiliki secara eksklusif oleh satu alamat.

shared-object.move: Implementasi Shared Object, di mana sebuah objek dapat diakses dan dimodifikasi oleh banyak alamat secara bersamaan, lengkap dengan kontrol akses.

capabilities-pattern.move: Contoh pola desain Capability, yaitu sebuah pola akses kontrol di mana kepemilikan sebuah objek "kunci" (AdminCap atau DosenCap) memberikan hak istimewa untuk menjalankan fungsi tertentu.

Implementasi Lanjutan
fungsi-lengkap.move: Modul kompleks yang menggabungkan berbagai konsep seperti konstanta untuk kode error, validasi input, kontrol akses, dan logika program yang lebih rumit.
