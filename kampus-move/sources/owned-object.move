module kampus::owned_objects {
    use std::string::String;
    // NOTE: Menambahkan impor untuk modul `transfer` dan `tx_context` dari Sui.
    // Ini diperlukan agar kita bisa memanggil fungsi-fungsi di dalamnya.
    use sui::transfer;
    use sui::tx_context;
    
    // Struct mahasiswa yang dimiliki oleh address tertentu
    public struct KartuMahasiswa has key, store {
        id: UID,
        nama: String,
        nim: u32,
        jurusan: String,
        tahun_masuk: u16,
    }
    
    // Fungsi untuk membuat kartu mahasiswa (owned object)
    public fun daftar_mahasiswa(
        nama: String,
        nim: u32,
        jurusan: String,
        tahun_masuk: u16,
        ctx: &mut TxContext
    ) {
        let kartu = KartuMahasiswa {
            id: object::new(ctx),
            nama,
            nim,
            jurusan,
            tahun_masuk,
        };
        
        // Transfer ke sender (mahasiswa yang mendaftar)
        // NOTE: Kode ini sekarang valid karena modul `transfer` dan `tx_context` sudah diimpor.
        transfer::transfer(kartu, tx_context::sender(ctx));
    }
    
    // Mahasiswa bisa update data sendiri
    public fun update_nama(kartu: &mut KartuMahasiswa, nama_baru: String) {
        kartu.nama = nama_baru;
    }
    
    // Fungsi untuk transfer kartu ke orang lain
    // NOTE: Tipe `address` adalah tipe bawaan Move, jadi tidak perlu diimpor.
    public fun transfer_kartu(kartu: KartuMahasiswa, penerima: address) {
        // NOTE: Kode ini sekarang valid karena modul `transfer` sudah diimpor.
        transfer::transfer(kartu, penerima);
    }
}