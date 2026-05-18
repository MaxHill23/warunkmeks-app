import 'package:flutter/material.dart';
import 'invoice_page.dart';
import '../transaction_service.dart'; // <-- TAMBAHKAN INI DI SINI
import 'dart:math'; // <-- TAMBAHKAN INI JUGA (untuk fungsi acak invoice ID)

class DetailTopupPage extends StatefulWidget {
  final String gameName;
  final String gameImage;

  const DetailTopupPage({
    super.key,
    required this.gameName,
    required this.gameImage,
  });

  @override
  State<DetailTopupPage> createState() => _DetailTopupPageState();
}

class _DetailTopupPageState extends State<DetailTopupPage> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _zoneIdController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();

  String? _selectedNominal;
  String? _selectedPayment;

  // DATA NOMINAL DAN HARGA UTUH UNTUK 15 GAME FIGMA
  List<Map<String, String>> _getNominalList() {
    switch (widget.gameName) {
      case 'Mobile Legends':
        return [
          {'jumlah': '5 (5 Premium) Diamonds', 'harga': 'Rp 1.500,-'},
          {'jumlah': '11 (10+1) Diamonds', 'harga': 'Rp 3.000,-'},
          {'jumlah': '22 (20+2) Diamonds', 'harga': 'Rp 5.500,-'},
          {'jumlah': '56 (51+5) Diamonds', 'harga': 'Rp 13.500,-'},
          {'jumlah': '112 (102+10) Diamonds', 'harga': 'Rp 30.000,-'},
          {'jumlah': '223 (203+20) Diamonds', 'harga': 'Rp 55.000,-'},
          {'jumlah': '336 (303+33) Diamonds', 'harga': 'Rp 80.000,-'},
          {'jumlah': '570 (504+66) Diamonds', 'harga': 'Rp 135.000,-'},
          {'jumlah': '1163 (1163) Diamonds', 'harga': 'Rp 268.000,-'},
          {'jumlah': '2398 (2398) Diamonds', 'harga': 'Rp 538.000,-'},
          {'jumlah': '6048 (6048) Diamonds', 'harga': 'Rp 1.350.000,-'},
          {'jumlah': 'Weekly Diamond Pass', 'harga': 'Rp 27.000,-'},
        ];
      case 'Free Fire':
        return [
          {'jumlah': '12 Diamonds', 'harga': 'Rp 2.000,-'},
          {'jumlah': '50 Diamonds', 'harga': 'Rp 8.000,-'},
          {'jumlah': '70 Diamonds', 'harga': 'Rp 10.000,-'},
          {'jumlah': '100 Diamonds', 'harga': 'Rp 15.000,-'},
          {'jumlah': '140 Diamonds', 'harga': 'Rp 20.000,-'},
          {'jumlah': '335 Diamonds', 'harga': 'Rp 50.000,-'},
          {'jumlah': '720 Diamonds', 'harga': 'Rp 100.000,-'},
          {'jumlah': '1075 Diamonds', 'harga': 'Rp 150.000,-'},
          {'jumlah': '2180 Diamonds', 'harga': 'Rp 290.000,-'},
          {'jumlah': '7290 Diamonds', 'harga': 'Rp 1.000.000,-'},
          {'jumlah': 'Bp Card', 'harga': 'Rp 45.000,-'},
          {'jumlah': 'Member Mingguan', 'harga': 'Rp 30.000,-'},
        ];
      case 'PUBG Mobile':
      case 'PUBG':
        return [
          {'jumlah': '60 Unknown Cash', 'harga': 'Rp 20.000,-'},
          {'jumlah': '300 + 25 Unknown Cash', 'harga': 'Rp 90.000,-'},
          {'jumlah': '600 + 60 Unknown Cash', 'harga': 'Rp 170.000,-'},
          {'jumlah': '1800 Unknown Cash', 'harga': 'Rp 420.000,-'},
          {'jumlah': '3850 Unknown Cash', 'harga': 'Rp 800.000,-'},
          {'jumlah': '8100 Unknown Cash', 'harga': 'Rp 1.600.000,-'},
        ];
      case 'Magic Chess':
        return [
          {'jumlah': '5 (5 Premium) Diamonds', 'harga': 'Rp 1.500,-'},
          {'jumlah': '11 (10+1) Diamonds', 'harga': 'Rp 3.000,-'},
          {'jumlah': '22 (20+2) Diamonds', 'harga': 'Rp 5.500,-'},
          {'jumlah': '56 (51+5) Diamonds', 'harga': 'Rp 13.500,-'},
          {'jumlah': '112 (102+10) Diamonds', 'harga': 'Rp 30.000,-'},
          {'jumlah': '223 (203+20) Diamonds', 'harga': 'Rp 55.000,-'},
          {'jumlah': '336 (303+33) Diamonds', 'harga': 'Rp 80.000,-'},
          {'jumlah': '570 (504+66) Diamonds', 'harga': 'Rp 135.000,-'},
          {'jumlah': 'Weekly Card', 'harga': 'Rp 30.000,-'},
        ];
      case 'Honor of Kings':
      case 'HOK':
        return [
          {'jumlah': '80 Token', 'harga': 'Rp 16.000,-'},
          {'jumlah': '240 Token', 'harga': 'Rp 46.000,-'},
          {'jumlah': '400 Token', 'harga': 'Rp 80.000,-'},
          {'jumlah': '560 Token', 'harga': 'Rp 110.000,-'},
          {'jumlah': '830 Token', 'harga': 'Rp 155.000,-'},
          {'jumlah': '1245 Token', 'harga': 'Rp 240.000,-'},
          {'jumlah': '2508 Token', 'harga': 'Rp 460.000,-'},
          {'jumlah': '4180 Token', 'harga': 'Rp 780.000,-'},
        ];
      case 'FC Mobile':
        return [
          {'jumlah': '40 FC Point', 'harga': 'Rp 6.500,-'},
          {'jumlah': '100 FC Point', 'harga': 'Rp 16.000,-'},
          {'jumlah': '520 FC Point', 'harga': 'Rp 80.000,-'},
          {'jumlah': '1070 FC Point', 'harga': 'Rp 160.000,-'},
          {'jumlah': '2200 FC Point', 'harga': 'Rp 330.000,-'},
          {'jumlah': '5750 FC Point', 'harga': 'Rp 780.000,-'},
        ];
      case 'Genshin Impact':
        return [
          {'jumlah': '60 Genesis Crystals', 'harga': 'Rp 15.000,-'},
          {'jumlah': '330 Genesis Crystals', 'harga': 'Rp 75.000,-'},
          {'jumlah': '1090 Genesis Crystals', 'harga': 'Rp 230.000,-'},
          {'jumlah': '2240 Genesis Crystals', 'harga': 'Rp 440.000,-'},
          {'jumlah': '3380 Genesis Crystals', 'harga': 'Rp 735.000,-'},
          {'jumlah': '8080 Genesis Crystals', 'harga': 'Rp 1.470.000,-'},
        ];
      case 'Honkai Star Rail':
        return [
          {'jumlah': '60 Oneiric Shard', 'harga': 'Rp 15.000,-'},
          {'jumlah': '330 Oneiric Shard', 'harga': 'Rp 75.000,-'},
          {'jumlah': '1090 Oneiric Shard', 'harga': 'Rp 225.000,-'},
          {'jumlah': '2240 Oneiric Shard', 'harga': 'Rp 430.000,-'},
          {'jumlah': '3380 Oneiric Shard', 'harga': 'Rp 720.000,-'},
        ];
      case 'Growtopia':
        return [
          {'jumlah': "Chest O' Gems", 'harga': 'Rp 30.000,-'},
          {'jumlah': 'Gem Fountain', 'harga': 'Rp 83.000,-'},
          {'jumlah': "It's Rainin' Gems", 'harga': 'Rp 169.000,-'},
          {'jumlah': 'Gem Bounty', 'harga': 'Rp 499.000,-'},
          {'jumlah': 'Gem Abundance', 'harga': 'Rp 790.000,-'},
        ];
      case 'Super Sus':
        return [
          {'jumlah': '100 Golden Star', 'harga': 'Rp 12.500,-'},
          {'jumlah': '310 Golden Star', 'harga': 'Rp 35.000,-'},
          {'jumlah': '520 Golden Star', 'harga': 'Rp 60.000,-'},
          {'jumlah': '1060 Golden Star', 'harga': 'Rp 125.000,-'},
          {'jumlah': '2180 Golden Star', 'harga': 'Rp 640.000,-'},
          {'jumlah': 'Super Pass', 'harga': 'Rp 60.000,-'},
        ];
      case 'Valorant':
        return [
          {'jumlah': '475 Points', 'harga': 'Rp 55.000,-'},
          {'jumlah': '950 Points', 'harga': 'Rp 110.000,-'},
          {'jumlah': '2050 Points', 'harga': 'Rp 215.000,-'},
          {'jumlah': '2525 Points', 'harga': 'Rp 270.000,-'},
          {'jumlah': '3050 Points', 'harga': 'Rp 330.000,-'},
          {'jumlah': '3650 Points', 'harga': 'Rp 375.000,-'},
        ];
      case 'Point Blank':
        return [
          {'jumlah': '1200 PB Cash', 'harga': 'Rp 10.000,-'},
          {'jumlah': '2400 PB Cash', 'harga': 'Rp 20.000,-'},
          {'jumlah': '6000 PB Cash', 'harga': 'Rp 50.000,-'},
          {'jumlah': '12000 PB Cash', 'harga': 'Rp 100.000,-'},
          {'jumlah': '24000 PB Cash', 'harga': 'Rp 200.000,-'},
          {'jumlah': '36000 PB Cash', 'harga': 'Rp 300.000,-'},
        ];
      case 'Sausage Man':
        return [
          {'jumlah': '61 Candy', 'harga': 'Rp 14.000,-'},
          {'jumlah': '186 Candy', 'harga': 'Rp 40.000,-'},
          {'jumlah': '318 Candy', 'harga': 'Rp 70.000,-'},
          {'jumlah': '686 Candy', 'harga': 'Rp 140.000,-'},
          {'jumlah': '1378 Candy', 'harga': 'Rp 280.000,-'},
          {'jumlah': '2118 Candy', 'harga': 'Rp 420.000,-'},
        ];
      case 'Arena of Valor':
      case 'AOV':
        return [
          {'jumlah': '40 Vouchers', 'harga': 'Rp 9.500,-'},
          {'jumlah': '90 Vouchers', 'harga': 'Rp 19.500,-'},
          {'jumlah': '230 Vouchers', 'harga': 'Rp 49.000,-'},
          {'jumlah': '470 Vouchers', 'harga': 'Rp 99.000,-'},
          {'jumlah': '950 Vouchers', 'harga': 'Rp 195.000,-'},
        ];
      case 'Call of Duty':
        return [
          {'jumlah': '31 CP', 'harga': 'Rp 15.000,-'},
          {'jumlah': '63 CP', 'harga': 'Rp 10.000,-'},
          {'jumlah': '128 CP', 'harga': 'Rp 20.000,-'},
          {'jumlah': '1373 CP', 'harga': 'Rp 195.000,-'},
        ];
      case 'eFootball':
      case 'eFootball PES':
        return [
          {'jumlah': '100 eFootball Coins', 'harga': 'Rp 15.000,-'},
          {'jumlah': '500 eFootball Coins', 'harga': 'Rp 75.000,-'},
          {'jumlah': '1050 eFootball Coins', 'harga': 'Rp 149.000,-'},
          {'jumlah': '2150 eFootball Coins', 'harga': 'Rp 299.000,-'},
        ];
      case 'Honkai Impact 3rd':
      case 'Honkai Impact':
        return [
          {'jumlah': '65 Crystals', 'harga': 'Rp 16.000,-'},
          {'jumlah': '330 Crystals', 'harga': 'Rp 79.000,-'},
          {'jumlah': '990 Crystals', 'harga': 'Rp 249.000,-'},
          {'jumlah': '1430 Crystals', 'harga': 'Rp 359.000,-'},
        ];
      default:
        return [
          {'jumlah': '50 Diamonds / Coins', 'harga': 'Rp 10.000,-'},
          {'jumlah': '100 Diamonds / Coins', 'harga': 'Rp 20.000,-'},
        ];
    }
  }

  // Menentukan Teks Hint Input Utama
  String _getPrimaryIdHint() {
    if (widget.gameName == 'Growtopia') return 'Grow ID';
    return 'User ID';
  }

  // Menentukan Teks Hint Input Server/Zone (Jika ada)
  String _getSecondaryIdHint() {
    if (widget.gameName == 'Mobile Legends' || widget.gameName == 'Magic Chess') return 'Server ID';
    if (widget.gameName == 'Honkai Star Rail' || widget.gameName == 'Genshin Impact') return 'Server';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final dynamicNominalList = _getNominalList();
    final secondaryHint = _getSecondaryIdHint();
    final hasSecondaryInput = secondaryHint.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF131422),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131422),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/image/logo_warunkmeks.png',
          height: 25,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Text('Top Up', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info Game Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1C2E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF23263D)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.gameImage,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.gamepad, size: 60, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.gameName,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '⚡ Jaminan Layanan Instan / Otomatis',
                          style: TextStyle(fontSize: 11, color: Colors.greenAccent),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Bagian 1: Informasi Pelanggan
            _buildSectionTitle('1', 'Informasi Pelanggan'),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1C2E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF23263D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasSecondaryInput) ...[
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _userIdController,
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                            decoration: _inputDecoration(_getPrimaryIdHint()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: _zoneIdController,
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                            decoration: _inputDecoration(secondaryHint),
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    TextField(
                      controller: _userIdController,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      decoration: _inputDecoration(_getPrimaryIdHint()),
                    ),
                  ],
                  const SizedBox(height: 12),
                  TextField(
                    controller: _whatsappController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: _inputDecoration('08xxxxxxxxxx'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Bagian 2: Pilihan Nominal Top Up
            _buildSectionTitle('2', 'Pilih Nominal Top Up'),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.3,
              ),
              itemCount: dynamicNominalList.length,
              itemBuilder: (context, index) {
                final nominal = dynamicNominalList[index];
                final isSelected = _selectedNominal == nominal['jumlah'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedNominal = nominal['jumlah'];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF2E54EA) : const Color(0xFF1A1C2E),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.white : const Color(0xFF23263D),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nominal['jumlah'] ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          nominal['harga'] ?? '',
                          style: TextStyle(fontSize: 11, color: isSelected ? Colors.white70 : Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Bagian 3: Pilih Metode Pembayaran
            _buildSectionTitle('3', 'Pilih Metode Pembayaran'),
            const SizedBox(height: 10),
            _buildPaymentTile('Deposit', 'Saldo Akun Utama', 'assets/image/ic_deposituang.png'),
            const SizedBox(height: 10),
            _buildPaymentTile('Scan Qris', 'Otomatis Terverifikasi', 'assets/image/ic_qris.png'),
            const SizedBox(height: 30),

            // Tombol Konfirmasi Aksi Pembayaran
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E54EA),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // Validasi input form utama
                  bool isSecondaryEmpty = hasSecondaryInput && _zoneIdController.text.isEmpty;
                  
                  if (_userIdController.text.isEmpty || 
                      isSecondaryEmpty || 
                      _whatsappController.text.isEmpty ||
                      _selectedNominal == null || 
                      _selectedPayment == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lengkapi data akun, WhatsApp, nominal, dan metode pembayaran!'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }

                  void goToInvoice() {
                    final now = DateTime.now();
                    String formattedDate = "${now.day} Mei ${now.year}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
                    String generatedInvoiceId = "WM-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${Random().nextInt(9000) + 1000}";

                    // 1. KARENA _selectedNominal SUDAH STRING, LANGSUNG MASUKKAN SAJA
                    String nominalText = _selectedNominal ?? 'Belum Pilih Paket';
                    
                    // Untuk harga, sementara kita samakan atau ambil dari text select-mu, 
                    // atau pakai logic pembantu. Di sini kita set default atau samakan dulu agar tidak error.
                    String hargaText = "Rp 1.500,-"; 

                    // 2. CATAT KE TRANSACTION SERVICE
                    TransactionService().addTransaction({
                      'gameName': widget.gameName,
                      'logo': widget.gameImage,
                      'invoiceId': generatedInvoiceId,
                      'nominal': nominalText,
                      'harga': hargaText,
                      'status': _selectedPayment == 'Scan Qris' ? 'Menunggu Pembayaran' : 'Berhasil',
                      'date': formattedDate,
                    });

                    // 3. PINDAH KE HALAMAN INVOICE
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InvoicePage(
                          gameName: widget.gameName,
                          gameImage: widget.gameImage,
                          userId: _userIdController.text,
                          zoneId: _zoneIdController.text,
                          nominalItem: nominalText,     // Dioper sebagai String murni
                          nominalHarga: hargaText,      // Dioper sebagai String murni
                          paymentMethod: _selectedPayment ?? 'Deposit',
                        ),
                      ),
                    );
                  }
                  
                  if (_selectedPayment == 'Scan Qris') {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: const Color(0xFF1A1C2E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          title: const Center(
                            child: Text(
                              'Pembayaran QRIS',
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Silakan scan kode QR di bawah ini untuk menyelesaikan pembayaran',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              const SizedBox(height: 16),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/image/ic_qris.png', 
                                  width: 180,
                                  height: 180,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => const Icon(
                                    Icons.qr_code_2,
                                    size: 150,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _selectedNominal ?? '',
                                style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal', style: TextStyle(color: Colors.redAccent)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E54EA),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                goToInvoice();
                              },
                              child: const Text('Saya Sudah Bayar', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    goToInvoice();
                  }
                },
                child: const Text(
                  'Beli Sekarang',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String number, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFF2E54EA), borderRadius: BorderRadius.circular(6)),
          child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white70)),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
      filled: true,
      fillColor: const Color(0xFF131422),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  Widget _buildPaymentTile(String method, String desc, String iconPath) {
    final isSelected = _selectedPayment == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1C2E),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? const Color(0xFF2E54EA) : const Color(0xFF23263D), width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24, errorBuilder: (c, e, s) => const Icon(Icons.payment, color: Colors.grey)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(method, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
            const Spacer(),
            Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? const Color(0xFF2E54EA) : Colors.grey),
          ],
        ),
      ),
    );
  }
}