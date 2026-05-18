import 'package:flutter/material.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}


class _DepositPageState extends State<DepositPage> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedMethod;
  String? _selectedPreset;

  // Daftar nominal instan (Preset)
  final List<String> _presets = [
    'Rp 10.000',
    'Rp 20.000',
    'Rp 50.000',
    'Rp 100.000',
    'Rp 200.000',
    'Rp 500.000',
  ];

  // Daftar metode pembayaran deposit
  final List<Map<String, String>> _paymentMethods = [
    {'name': 'Scan QRIS', 'desc': 'Otomatis • Biaya Rp 0', 'icon': 'qr_code_2_rounded'},
    {'name': 'Bank BCA', 'desc': 'Transfer Manual • Biaya Rp 0', 'icon': 'account_balance_rounded'},
    {'name': 'Bank Mandiri', 'desc': 'Transfer Manual • Biaya Rp 0', 'icon': 'account_balance_rounded'},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131422), // Warna latar belakang dark theme konsisten
      appBar: AppBar(
        backgroundColor: const Color(0xFF131422),
        elevation: 0,
        title: const Text(
          'Isi Saldo / Deposit',
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
            // 1. INPUT JUGA NOMINAL MANUAL
            const Text(
              'Masukkan Nominal Deposit',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                prefixText: 'Rp ',
                prefixStyle: const TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),
                hintText: '0',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF1A1C2E),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF23263D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF4361EE)),
                ),
              ),
              onChanged: (value) {
                if (_selectedPreset != null) {
                  setState(() {
                    _selectedPreset = null;
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            // 2. PILIHAN NOMINAL INSTAN (PRESET GRID)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _presets.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.3,
              ),
              itemBuilder: (context, index) {
                final preset = _presets[index];
                final isSelected = _selectedPreset == preset;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPreset = preset;
                      // Bersihkan angka format Rp untuk dimasukkan ke controller text murni
                      _amountController.text = preset.replaceAll('Rp ', '').replaceAll('.', '');
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF4361EE).withValues(alpha: 0.15) : const Color(0xFF1A1C2E),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF4361EE) : const Color(0xFF23263D),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        preset,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF4361EE) : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 28),

            // 3. PILIHAN METODE PEMBAYARAN
            const Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                final method = _paymentMethods[index];
                final isSelected = _selectedMethod == method['name'];
                
                IconData iconData = Icons.account_balance_rounded;
                if (method['icon'] == 'qr_code_2_rounded') {
                  iconData = Icons.qr_code_2_rounded;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1C2E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF4361EE) : const Color(0xFF23263D),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131422),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(iconData, color: const Color(0xFF4361EE), size: 24),
                    ),
                    title: Text(
                      method['name']!,
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      method['desc']!,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    trailing: Icon(
                      isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                      color: isSelected ? const Color(0xFF4361EE) : Colors.grey,
                      size: 20,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedMethod = method['name'];
                      });
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // 4. TOMBOL PROSES DEPOSIT
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4361EE),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                onPressed: () {
                  if (_amountController.text.isEmpty || _selectedMethod == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Harap masukkan nominal dan pilih metode pembayaran!'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }
                  
                  // Tampilkan dialog konfirmasi sukses/proses deposit
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: const Color(0xFF1A1C2E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      title: const Text('Deposit Diproses', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      content: Text(
                        'Permintaan deposit sebesar Rp ${_amountController.text} via $_selectedMethod berhasil dibuat. Silakan selesaikan pembayaran.',
                        style: const TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Opsional: bersihkan form setelahnya
                            setState(() {
                              _amountController.clear();
                              _selectedMethod = null;
                              _selectedPreset = null;
                            });
                          },
                          child: const Text('OK', style: TextStyle(color: Color(0xFF4361EE), fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'Konfirmasi Deposit',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}