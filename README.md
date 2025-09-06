Workshop Smart Contract Sui MoveSelamat datang di repositori Workshop Smart Contract Sui Move! Repositori ini berisi kumpulan kode dari hasil pembelajaran dan praktik pengembangan smart contract di blockchain Sui, mulai dari konsep paling dasar hingga proyek-proyek yang lebih kompleks.Saat ini, repositori ini mencakup dua proyek utama:Sistem Informasi Kampus: Sebuah modul komprehensif yang mengelola data mahasiswa, nilai, dan registrasi menggunakan pola desain umum di Sui.Token KAMPUS (Fungible Token): Implementasi standar untuk membuat, me-mint, dan membakar (burn) token fungible di jaringan Sui.🚀 Proyek Utama

  1. Sistem Informasi Kampus (sistem_kampus_lengkap)Ini adalah modul Move yang mensimulasikan sistem informasi akademik sederhana. Modul ini mendemonstrasikan berbagai konsep inti Sui dalam satu paket yang terintegrasi.Konsep yang Dipelajari:Structs & Tipe Data: Penggunaan tipe data dasar (u64, String, bool, address) dan vector.Owned Objects: MahasiswaProfile dan NilaiMataKuliah dimiliki secara eksklusif oleh alamat mahasiswa.Shared Object: KampusRegistry adalah objek yang dapat diakses dan dibaca oleh siapa saja di jaringan.Capability Pattern: AdminCap bertindak sebagai "kunci" yang memberikan hak akses administratif untuk fungsi-fungsi kritis seperti mendaftarkan mahasiswa baru.Events: Menggunakan events untuk memberitahu aplikasi off-chain tentang aktivitas penting seperti pendaftaran mahasiswa atau penambahan nilai.Fungsi & Logika: Implementasi fungsi dengan validasi input, kontrol akses, dan logika kondisional.
  2. Token KAMPUS (kampus_token)Proyek ini berisi implementasi smart contract untuk token fungible bernama KAMPUS_COIN. Ini adalah contoh standar yang mengikuti pola managed dari Sui, di mana token dapat dibuat (mint) dan dihancurkan (burn) oleh pemegang TreasuryCap.Fitur:init: Membuat metadata koin (nama, simbol, desimal) dan TreasuryCap saat pertama kali di-deploy.mint: Fungsi untuk membuat suplai koin baru. Hanya bisa dipanggil oleh pemegang TreasuryCap.burn: Fungsi untuk menghancurkan koin. Hanya bisa dipanggil oleh pemegang TreasuryCap.🛠️ Cara MenggunakanPrasyaratPastikan Anda telah menginstal Sui CLI di sistem Anda. Ikuti panduan instalasi resmi di Sui Docs jika belum.InstalasiClone repositori ini:git clone [https://github.com/raflimulyarahman/tesnet-sui-workshop.git](https://github.com/raflimulyarahman/tesnet-sui-workshop.git)
Masuk ke direktori utama:cd tesnet-sui-workshop
Build & DeployKarena terdapat beberapa proyek di dalam repositori ini, Anda perlu masuk ke direktori masing-masing sebelum menjalankan perintah build atau publish.Untuk Sistem Kampus:cd sistem_kampus_lengkap
sui move build

# Untuk deploy, jalankan:
# sui client publish --gas-budget 100000000
Untuk Token KAMPUS:cd ../kampus_token
sui move build

# Untuk deploy, jalankan:
# sui client publish --gas-budget 100000000

💻 Contoh Interaksi (CLI)Setelah Anda men-deploy paket kampus_token, Anda bisa berinteraksi dengannya melalui sui client call.Contoh: Me-mint KAMPUS_COINCari ID TreasuryCap Anda:Setelah publish, TreasuryCap akan menjadi milik Anda. Cari ID-nya dengan perintah:sui client objects
Cari objek dengan tipe yang mengandung ::campus_coin::TreasuryCap. Salin ID-nya.Jalankan Perintah mint:Gunakan template di bawah ini. Ganti PACKAGE_ID, TREASURY_CAP_ID, JUMLAH, dan ALAMAT_PENERIMA.sui client call `
  --package <PACKAGE_ID> `
  --module campus_coin `
  --function mint `
  --args <TREASURY_CAP_ID> <JUMLAH> <ALAMAT_PENERIMA> `
  --gas-budget 10000000
Contoh Nyata:sui client call `
  --package 0x964afb4a7fec19a570bcd6a051399f4e9ddb8e81a32ab03b48247533a49b3246 `
  --module campus_coin `
  --function mint `
  --args 0x497115abc2003448c267a96715bbb2c5223aa81e7fe126b559c17f4088efcc3d 1000 0x7e3a9c7d19c1186b2a0c4f4a332a6e5b00654321 `
  --gas-budget 10000000
  
🌟 KontribusiKontribusi, isu, dan permintaan fitur sangat diterima. Jangan ragu untuk membuka issue atau pull request jika Anda menemukan masalah atau memiliki ide untuk perbaikan.
