import 'package:flutter/material.dart';
import 'dart:math';
import '../transaction_service.dart';

class InvoicePage extends StatefulWidget {
  final String gameName;
  final String gameImage;
  final String userId;
  final String zoneId;
  final String nominalItem;  // Pastikan ini String
  final String nominalHarga; // Pastikan ini String
  final String paymentMethod;

  const InvoicePage({
    super.key,
    required this.gameName,
    required this.gameImage,
    required this.userId,
    required this.zoneId,
    required this.nominalItem,  
    required this.nominalHarga, 
    required this.paymentMethod,
  });

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  late String invoiceId;
  bool _hasSaved = false;

  @override
  void initState() {
    super.initState();
    invoiceId = _generateInvoiceId();
    
    // Trigger simpan data ke service secara otomatis begitu halaman dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasSaved) {
        final now = DateTime.now();
        String formattedDate = "${now.day} Mei ${now.year}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

        TransactionService().addTransaction({
          'gameName': widget.gameName,
          'logo': widget.gameImage,
          'invoiceId': invoiceId,
          'nominal': widget.nominalItem,
          'harga': widget.nominalHarga,
          'status': widget.paymentMethod == 'Scan Qris' ? 'Menunggu Pembayaran' : 'Berhasil',
          'date': formattedDate,
        });
        
        _hasSaved = true;
      }
    });
  }

  String _generateInvoiceId() {
    final now = DateTime.now();
    final random = Random().nextInt(9000) + 1000;
    return "WM-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-$random";
  }

  @override
  Widget build(BuildContext context) {
    final isQris = widget.paymentMethod == 'Scan Qris';

    return Scaffold(
      backgroundColor: const Color(0xFF131422),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131422),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Transaksi',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isQris ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isQris ? Icons.hourglass_top_rounded : Icons.check_circle_rounded,
                size: 54,
                color: isQris ? Colors.orangeAccent : Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isQris ? 'Menunggu Pembayaran' : 'Transaksi Berhasil',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
                color: isQris ? Colors.orangeAccent : Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              invoiceId,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            if (isQris) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Pindai QRIS untuk Menyelesaikan Pembayaran',
                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Icon(Icons.qr_code_2_rounded, size: 180, color: Colors.black),
                    const SizedBox(height: 8),
                    Text(
                      'Batas Waktu: 15:00 Menit',
                      style: TextStyle(color: Colors.red.shade700, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1C2E),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF23263D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          widget.gameImage,
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => const Icon(Icons.gamepad, size: 45, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.gameName,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.nominalItem, 
                              style: const TextStyle(color: Colors.blueAccent, fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Divider(color: Color(0xFF23263D), thickness: 1),
                  ),

                  _buildInvoiceRow('User / Player ID', widget.userId),
                  if (widget.zoneId.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildInvoiceRow(
                      (widget.gameName == 'Mobile Legends' || widget.gameName == 'Magic Chess') ? 'Server ID' : 'Server / Zone',
                      widget.zoneId,
                    ),
                  ],
                  const SizedBox(height: 12),
                  _buildInvoiceRow('Metode Pembayaran', widget.paymentMethod),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Divider(color: Color(0xFF23263D), thickness: 1),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Bayar',
                        style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.nominalHarga, 
                        style: TextStyle(
                          color: isQris ? Colors.orangeAccent : Colors.greenAccent, 
                          fontSize: 14, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E54EA),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text(
                  'Kembali ke Beranda',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }
}