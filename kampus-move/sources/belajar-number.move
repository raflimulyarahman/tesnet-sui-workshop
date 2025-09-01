module kampus::belajar_number {
    // Import sui::... dihapus karena sudah otomatis

    // 'public' ditambahkan kembali untuk Move 2024
    public struct DataMahasiswa has key {
        id: UID,
        nim: u32,
        umur: u8,
        total_sks: u64,
    }

    public fun buat_data_mahasiswa(
        nim: u32,
        umur: u8,
        ctx: &mut TxContext
    ): DataMahasiswa {
        DataMahasiswa {
            id: object::new(ctx),
            nim,
            umur,
            total_sks: 0,
        }
    }

    public fun tambah_sks(data: &mut DataMahasiswa, sks: u64) {
        data.total_sks = data.total_sks + sks;
    }

    public fun tambah_umur(data: &mut DataMahasiswa) {
        data.umur = data.umur + 1;
    }
}