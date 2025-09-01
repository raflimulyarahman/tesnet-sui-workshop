module kampus::data_mahasiswa_lengkap {
    // Import sui::... dihapus karena sudah otomatis
    use std::string::String;

    // 'public' ditambahkan kembali untuk Move 2024
    public struct Mahasiswa has key {
        id: UID,
        nama: String,
        nim: u32,
        jurusan: String,
        umur: u8,
        total_sks: u64,
        aktif: bool,
        lulus: bool,
    }

    public fun daftar_mahasiswa(
        nama: String,
        nim: u32,
        jurusan: String,
        umur: u8,
        ctx: &mut TxContext
    ): Mahasiswa {
        Mahasiswa {
            id: object::new(ctx),
            nama,
            nim,
            jurusan,
            umur,
            total_sks: 0,
            aktif: true,
            lulus: false,
        }
    }

    public fun ambil_mata_kuliah(mhs: &mut Mahasiswa, sks: u64) {
        mhs.total_sks = mhs.total_sks + sks;
    }

    public fun set_lulus(mhs: &mut Mahasiswa) {
        if (mhs.total_sks >= 144) {
            mhs.lulus = true;
        }
    }

    public fun get_info(mhs: &Mahasiswa): (String, u32, u64, bool) {
        (mhs.nama, mhs.nim, mhs.total_sks, mhs.lulus)
    }
}