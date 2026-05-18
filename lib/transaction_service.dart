class TransactionService {
  // Pattern Singleton agar data terpusat di satu tempat yang sama
  static final TransactionService _instance = TransactionService._internal();
  factory TransactionService() => _instance;
  TransactionService._internal();

  // Tempat menyimpan daftar transaksi asli secara lokal
  final List<Map<String, dynamic>> _transactions = [
    // Kita kasih 1 data dummy awal buat pancingan
    {
      'gameName': 'Valorant',
      'logo': 'assets/image/logo_valorant.png',
      'invoiceId': 'WM-20260518-4412',
      'nominal': '125 Points',
      'harga': 'Rp 15.000,-',
      'status': 'Menunggu Pembayaran',
      'date': '18 Mei 2026, 19:05',
    },
  ];

  // Fungsi untuk mengambil semua data transaksi
  List<Map<String, dynamic>> getTransactions() {
    return _transactions;
  }

  // Fungsi untuk menambah transaksi baru di urutan paling atas
  void addTransaction(Map<String, dynamic> tx) {
    _transactions.insert(0, tx);
  }
}