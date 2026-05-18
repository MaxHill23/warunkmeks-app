import 'package:flutter/material.dart';

class InformasiPage extends StatelessWidget {
  const InformasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data list panduan / FAQ aplikasi
    final List<Map<String, String>> faqs = [
      {
        'question': 'Bagaimana cara melakukan top-up?',
        'answer': 'Pilih game di halaman Beranda, masukkan Player ID & Zone ID kamu, pilih nominal item yang diinginkan, pilih metode pembayaran, lalu klik Beli Sekarang.'
      },
      {
        'question': 'Berapa lama proses item masuk ke akun?',
        'answer': 'Untuk metode pembayaran otomatis (seperti QRIS), item akan masuk secara instan dalam 1-3 menit. Untuk transfer manual bank, memerlukan waktu verifikasi sekitar 5-10 menit.'
      },
      {
        'question': 'Bagaimana jika salah memasukkan Player ID?',
        'answer': 'Harap periksa kembali ID sebelum melakukan pembayaran. Transaksi yang sudah sukses diproses ke ID yang salah tidak dapat dibatalkan atau direfund.'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF131422), // Konsisten dengan background utama
      appBar: AppBar(
        backgroundColor: const Color(0xFF131422),
        elevation: 0,
        title: const Text(
          'Pusat Informasi',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Selamat Datang / Informasi Singkat
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4361EE), Color(0xFF2E54EA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Butuh Bantuan?',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Temukan panduan lengkap dan jawaban dari kendala transaksi kamu di aplikasi WarunkMeks.',
                    style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bagian Kontak Customer Service
            const Text(
              'Hubungi Layanan Pengguna',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildContactCard(
              icon: Icons.support_agent_rounded,
              title: 'WhatsApp Customer Service',
              subtitle: 'Respons cepat • Jam operasional 08:00 - 22:00',
              actionText: 'Chat Sekarang',
            ),
            const SizedBox(height: 24),

            // Bagian FAQ (Pertanyaan Populer)
            const Text(
              'Pertanyaan yang Sering Diajukan',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                final faq = faqs[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1C2E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF23263D)),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      iconColor: const Color(0xFF4361EE),
                      collapsedIconColor: Colors.grey,
                      title: Text(
                        faq['question']!,
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          child: Text(
                            faq['answer']!,
                            style: const TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String actionText,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF23263D)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF131422),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF00E676), size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 14),
        ],
      ),
    );
  }
}