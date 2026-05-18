import 'package:flutter/material.dart';
import '../transaction_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

// Mengubah menjadi StatefulWidget agar bisa me-refresh data secara live
class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> historyList = [];

  // Fungsi untuk mengambil data terbaru dari TransactionService
  void _loadTransactions() {
    setState(() {
      historyList = TransactionService().getTransactions();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    // Trik rahasia: Setiap kali user membuka halaman ini, load data terbaru
    _loadTransactions();

    return Scaffold(
      backgroundColor: const Color(0xFF131422),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131422),
        elevation: 0,
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: historyList.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final transaction = historyList[index];
                return _buildHistoryCard(transaction);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_toggle_off_rounded, size: 72, color: Colors.grey.shade700),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Transaksi',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Transaksi yang kamu lakukan akan muncul di sini.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> data) {
    final status = data['status'];
    
    Color statusColor;
    Color statusBg;
    if (status == 'Berhasil') {
      statusColor = const Color(0xFF00E676);
      statusBg = const Color(0xFF00E676).withValues(alpha: 0.1);
    } else if (status == 'Menunggu Pembayaran') {
      statusColor = Colors.orangeAccent;
      statusBg = Colors.orangeAccent.withValues(alpha: 0.1);
    } else {
      statusColor = Colors.redAccent;
      statusBg = Colors.redAccent.withValues(alpha: 0.1);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF23263D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data['invoiceId'],
                style: const TextStyle(color: Colors.grey, fontSize: 11, fontFamily: 'monospace'),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(color: Color(0xFF23263D), thickness: 1),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  data['logo'],
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => const Icon(Icons.gamepad, size: 40, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['gameName'],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data['nominal'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Text(
                data['harga'],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              data['date'],
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}