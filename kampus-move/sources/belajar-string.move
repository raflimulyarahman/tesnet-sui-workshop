module kampus::belajar_string {
    // Import sui::... dihapus karena sudah otomatis
    use std::string::String;

    // 'public' ditambahkan kembali untuk Move 2024
    public struct Mahasiswa has key {
        id: UID,
        nama: String,
    }

    public fun buat_mahasiswa(nama: String, ctx: &mut TxContext): Mahasiswa {
        Mahasiswa {
            id: object::new(ctx),
            nama,
        }
    }

    public fun ubah_nama(mahasiswa: &mut Mahasiswa, nama_baru: String) {
        mahasiswa.nama = nama_baru;
    }

    public fun get_nama(mahasiswa: &Mahasiswa): String {
        mahasiswa.nama
    }
}