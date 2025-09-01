module kampus::capabilities_pattern {
    use std::string::String;
    // NOTE: Menambahkan impor yang diperlukan dari Sui framework.
    // Ini adalah satu-satunya perubahan teknis pada kode Anda.
    
    // NOTE: Struct AdminCap ini adalah "Capability". Ia bertindak seperti sebuah
    // kunci atau tiket akses. Siapa pun yang memegang objek ini dianggap sebagai Admin.
    public struct AdminCap has key, store {
        id: UID,
    }
    
    // NOTE: Ini adalah capability lain untuk Dosen. Memiliki objek ini
    // memberikan hak akses sebagai dosen untuk mata kuliah tertentu.
    public struct DosenCap has key, store {
        id: UID,
        mata_kuliah: String,
    }
    
    // Struct untuk sistem nilai (Shared Object)
    public struct SistemNilai has key {
        id: UID,
        total_mahasiswa: u64,
    }
    
    // Struct untuk nilai mahasiswa (Owned Object)
    public struct NilaiMahasiswa has key, store {
        id: UID,
        nim: u32,
        mata_kuliah: String,
        nilai: u8,
        dosen_pemberi: address,
    }
    
    // NOTE: `init` adalah fungsi spesial yang hanya berjalan sekali saat modul di-deploy.
    // Ini adalah tempat yang sempurna untuk mengatur state awal, seperti membuat
    // AdminCap pertama dan membagikan objek utama (SistemNilai).
    fun init(ctx: &mut TxContext) {
        // Buat admin capability
        let admin_cap = AdminCap {
            id: object::new(ctx),
        };
        
        // Buat sistem nilai
        let sistem = SistemNilai {
            id: object::new(ctx),
            total_mahasiswa: 0,
        };
        
        // Transfer admin cap ke deployer (pemilik kontrak)
        transfer::transfer(admin_cap, tx_context::sender(ctx));
        
        // Share sistem nilai agar bisa diakses semua orang
        transfer::share_object(sistem);
    }
    
    // NOTE: Ini adalah inti dari Capability Pattern.
    // Dengan mensyaratkan parameter `_: &AdminCap`, fungsi ini secara efektif
    // terkunci. Hanya transaksi yang bisa memberikan referensi ke objek `AdminCap`
    // yang bisa memanggil fungsi ini. `_:` menandakan kita hanya butuh "bukti kepemilikan",
    // bukan datanya.
    public fun buat_dosen_cap(
        _: &AdminCap, // Admin capability sebagai "kunci" otorisasi
        mata_kuliah: String,
        dosen_address: address,
        ctx: &mut TxContext
    ) {
        let dosen_cap = DosenCap {
            id: object::new(ctx),
            mata_kuliah,
        };
        
        transfer::transfer(dosen_cap, dosen_address);
    }
    
    // NOTE: Pola yang sama diterapkan di sini. Hanya mereka yang memiliki
    // `DosenCap` yang bisa memanggil fungsi ini. Selain sebagai kunci,
    // capability ini juga membawa data (`dosen_cap.mata_kuliah`) yang berguna.
    public fun beri_nilai(
        dosen_cap: &DosenCap,
        sistem: &mut SistemNilai,
        nim: u32,
        nilai: u8,
        mahasiswa_address: address,
        ctx: &mut TxContext
    ) {
        // Validasi nilai
        assert!(nilai <= 100, 1);
        
        let nilai_obj = NilaiMahasiswa {
            id: object::new(ctx),
            nim,
            mata_kuliah: dosen_cap.mata_kuliah, // Menggunakan data dari capability
            nilai,
            dosen_pemberi: tx_context::sender(ctx),
        };
        
        // Update shared object
        sistem.total_mahasiswa = sistem.total_mahasiswa + 1;
        
        // Transfer objek nilai ke mahasiswa
        transfer::transfer(nilai_obj, mahasiswa_address);
    }
}