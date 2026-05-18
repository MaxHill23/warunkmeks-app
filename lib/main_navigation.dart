import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/history_page.dart'; 
import 'pages/deposit_page.dart';
import 'pages/informasi_page.dart';
// Memastikan import mengarah ke file yang benar

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const HistoryPage(),
    const DepositPage(),
    const InformasiPage(),
    // Fallback widget used here to avoid compile error when InformasiPage
    // class is not defined in pages/informasi_page.dart
    const SizedBox.shrink(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF1F2235), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF161829), 
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF4361EE), 
          unselectedItemColor: Colors.grey,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/image/ic_home.png', width: 22, height: 22, color: Colors.grey),
              activeIcon: Image.asset('assets/image/ic_home.png', width: 22, height: 22, color: const Color(0xFF4361EE)),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/image/ic_transaksi.png', width: 22, height: 22, color: Colors.grey),
              activeIcon: Image.asset('assets/image/ic_transaksi.png', width: 22, height: 22, color: const Color(0xFF4361EE)),
              label: 'Transaksi',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/image/ic_deposit.png', width: 22, height: 22, color: Colors.grey),
              activeIcon: Image.asset('assets/image/ic_deposit.png', width: 22, height: 22, color: const Color(0xFF4361EE)),
              label: 'Deposit',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/image/ic_informasi.png', width: 22, height: 22, color: Colors.grey),
              activeIcon: Image.asset('assets/image/ic_informasi.png', width: 22, height: 22, color: const Color(0xFF4361EE)),
              label: 'Informasi',
            ),
          ],
        ),
      ),
    );
  }
}