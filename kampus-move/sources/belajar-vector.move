module kampus::belajar_vector {
    use std::string::String;

    public struct DaftarMahasiswa has key {
        id: UID,
        nama_mahasiswa: vector<String>,
        nim_mahasiswa: vector<u32>,
    }

    public fun buat_daftar_kosong(ctx: &mut TxContext): DaftarMahasiswa {
        DaftarMahasiswa {
            id: object::new(ctx),
            nama_mahasiswa: vector::empty<String>(),
            nim_mahasiswa: vector::empty<u32>(),
        }
    }

    public fun tambah_mahasiswa(
        daftar: &mut DaftarMahasiswa,
        nama: String,
        nim: u32
    ) {
        vector::push_back(&mut daftar.nama_mahasiswa, nama);
        vector::push_back(&mut daftar.nim_mahasiswa, nim);
    }

    public fun jumlah_mahasiswa(daftar: &DaftarMahasiswa): u64 {
        vector::length(&daftar.nama_mahasiswa)
    }

    // NOTE:
    // ##################################################################
    // # PERMASALAHAN & PERUBAHAN ADA DI FUNGSI INI
    // ##################################################################
    //
    // MASALAH:
    // 1. `vector::borrow` hanya "meminjam" data dan mengembalikan sebuah referensi (`&`),
    //    bukan nilai aslinya.
    // 2. Tipe `String` tidak memiliki kemampuan `copy`. Artinya, nilainya tidak bisa
    //    diduplikasi atau disalin dengan mudah, tidak seperti `u32`.
    // 3. Menulis `*vector::borrow(...)` pada variabel `nama` (`&String`) akan menyebabkan
    //    error. Tanda `*` mencoba mengambil nilai asli, yang dianggap sebagai upaya
    //    memindahkan (move) data keluar dari vector, dan itu dilarang.
    //
    // SOLUSI:
    // Fungsi ini diubah agar mengembalikan referensi ke String (`&String`), bukan mencoba
    // menyalin nilainya. Ini adalah cara yang paling umum dan benar di Move.
    //
    public fun get_mahasis_ke(daftar: &DaftarMahasiswa, index: u64): (&String, u32) {
        // `nama` sekarang menjadi sebuah referensi, jadi tanda `*` dihilangkan.
        let nama = vector::borrow(&daftar.nama_mahasiswa, index);

        // `nim` tetap disalin nilainya menggunakan `*` karena `u32` bisa di-copy.
        let nim = *vector::borrow(&daftar.nim_mahasiswa, index);
        
        (nama, nim)
    }

    public fun apakah_kosong(daftar: &DaftarMahasiswa): bool {
        vector::is_empty(&daftar.nama_mahasiswa)
    }
}