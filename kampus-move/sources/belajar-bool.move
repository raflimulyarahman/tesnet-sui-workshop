module kampus::belajar_boolean {
    // Import sui::... dihapus karena sudah otomatis
    use std::string::String;

    // 'public' ditambahkan kembali untuk Move 2024
    public struct StatusMahasiswa has key {
        id: UID,
        nama: String,
        aktif: bool,
        lulus: bool,
    }

    public fun buat_status(nama: String, ctx: &mut TxContext): StatusMahasiswa {
        StatusMahasiswa {
            id: object::new(ctx),
            nama,
            aktif: true,
            lulus: false,
        }
    }

    public fun set_lulus(status: &mut StatusMahasiswa) {
        status.lulus = true;
    }

    public fun nonaktifkan(status: &mut StatusMahasiswa) {
        status.aktif = false;
    }

    public fun bisa_wisuda(status: &StatusMahasiswa): bool {
        status.aktif && status.lulus
    }
}