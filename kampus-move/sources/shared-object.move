module kampus::shared_objects {
    use std::string::String;
    
    // NOTE: Menambahkan impor untuk modul-modul penting dari Sui framework.
    // - `object` untuk membuat ID unik objek.
    // - `transfer` untuk membagikan objek (share_object).
    // - `tx_context` untuk mendapatkan informasi transaksi, seperti pengirim (sender).
    
    
    
    // Struct untuk registrasi kampus (shared object)
    public struct RegistrasiKampus has key {
        id: UID,
        nama_kampus: String,
        total_mahasiswa: u64,
        daftar_nim: vector<u32>,
        admin: address, // Alamat yang berhak memodifikasi data
    }
    
    // NOTE: Fungsi ini membuat objek dan langsung membagikannya.
    // Setelah `share_object` dipanggil, objek ini tidak lagi dimiliki oleh satu alamat,
    // melainkan "hidup" secara mandiri di jaringan dan bisa diakses oleh siapa saja.
    public fun buat_registrasi_kampus(
        nama_kampus: String,
        ctx: &mut TxContext
    ) {
        let registrasi = RegistrasiKampus {
            id: object::new(ctx),
            nama_kampus,
            total_mahasiswa: 0,
            daftar_nim: vector::empty<u32>(),
            admin: tx_context::sender(ctx), // Pengirim transaksi di-set sebagai admin
        };
        
        // Membagikan objek agar semua orang bisa berinteraksi dengannya.
        transfer::share_object(registrasi);
    }
    
    // NOTE: Ini adalah contoh fungsi "read-only" (hanya membaca).
    // Karena hanya membutuhkan referensi (&RegistrasiKampus), fungsi ini
    // bisa dipanggil oleh siapa saja untuk melihat data tanpa mengubahnya.
    public fun get_total_mahasiswa(registrasi: &RegistrasiKampus): u64 {
        registrasi.total_mahasiswa
    }
    
    // NOTE: Ini adalah contoh fungsi "write" (mengubah data) yang dilindungi.
    // Diperlukan referensi yang bisa diubah (&mut RegistrasiKampus).
    // Yang paling penting adalah adanya kontrol akses.
    public fun tambah_mahasiswa_ke_registrasi(
        registrasi: &mut RegistrasiKampus,
        nim: u32,
        ctx: &TxContext
    ) {
        // KONTROL AKSES: Ini adalah bagian krusial.
        // `assert!` memastikan bahwa alamat pengirim transaksi (`sender`) sama dengan
        // alamat `admin` yang tersimpan di dalam struct. Jika tidak sama,
        // transaksi akan gagal dengan kode error 0.
        assert!(registrasi.admin == tx_context::sender(ctx), 0);
        
        // Logika ini hanya akan berjalan jika `assert!` berhasil.
        registrasi.total_mahasiswa = registrasi.total_mahasiswa + 1;
        vector::push_back(&mut registrasi.daftar_nim, nim);
    }
}