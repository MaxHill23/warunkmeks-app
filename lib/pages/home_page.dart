import 'detail_topup_page.dart';
import 'package:flutter/material.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Menyesuaikan daftar nama file gambar asli yang ada di folder komputermu
  final List<Map<String, String>> popularGames = [
    {'name': 'Mobile Legends', 'image': 'assets/image/logo_ml.png'},
    {'name': 'Free Fire', 'image': 'assets/image/logo_ff.png'},
    {'name': 'PUBG Mobile', 'image': 'assets/image/logo_pubg.png'},
  ];

  final List<Map<String, String>> topupGames = [
    {'name': 'Magic Chess', 'image': 'assets/image/logo_mc.png'},
    {'name': 'Honor of Kings', 'image': 'assets/image/logo_hok.png'},
    {'name': 'Honkai Star Rail', 'image': 'assets/image/logo_honkai.png'},
    {'name': 'Genshin Impact', 'image': 'assets/image/logo_genshin.png'},
    {'name': 'FC Mobile', 'image': 'assets/image/logo_fcmobile.png'},
    {'name': 'Point Blank', 'image': 'assets/image/logo_pb.png'},
    {'name': 'Sausage Man', 'image': 'assets/image/logo_sausageman.png'},
    {'name': 'Super Sus', 'image': 'assets/image/logo_supersus.png'},
    {'name': 'Valorant', 'image': 'assets/image/logo_valorant.png'},
    {'name': 'Growtopia', 'image': 'assets/image/logo_growtopia.png'},
    {'name': 'Call of Duty', 'image': 'assets/image/logo_cod.png'},
    {'name': 'Arena of Valor', 'image': 'assets/image/logo_aov.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF131422),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/image/logo_warunkmeks.png',
              height: 25, // Ukuran tinggi logo agar pas dan rapi di AppBar
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Cadangan kalau gambarnya sempat tidak terbaca
                return const Text(
                  'WarunkMeks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                );
              },
            ),
            const Spacer(),
            // Ikon kaca pembesar untuk ke halaman search nanti
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2235),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                children: [
                  Text('🇮🇩 ', style: TextStyle(fontSize: 12)),
                  Text('IDR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
      // SingleChildScrollView membuat isi halaman bisa di-scroll ke bawah
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Promo Utama
            Container(
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/image/banner_promo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Judul Game Populer
            const Text(
              'Game Populer',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            const SizedBox(height: 12),

            // Grid Game Populer
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: popularGames.length,
              itemBuilder: (context, index) {
                return _buildGameCard(popularGames[index]['name']!, popularGames[index]['image']!);
              },
            ),
            const SizedBox(height: 24),

            // Judul Topup Games
            const Text(
              'Topup Games',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            const SizedBox(height: 12),

            // Grid Topup Games
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: topupGames.length,
              itemBuilder: (context, index) {
                return _buildGameCard(topupGames[index]['name']!, topupGames[index]['image']!);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Desain Kotak Cetakan Game agar persis seperti Figma
Widget _buildGameCard(String name, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailTopupPage(
              gameName: name,
              gameImage: imagePath,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1C2E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF23263D), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Membuat isi melebar penuh
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Menjadikan gambar full memenuhi box atas
                  filterQuality: FilterQuality.high, // <--- TAMBAHKAN INI
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.gamepad, size: 40, color: Colors.grey);
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: const BoxDecoration(
                color: Color(0xFF161829), // Background area teks biar rapi dan kontras
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(11),
                  bottomRight: Radius.circular(11),
                ),
              ),
              child: Text(
                name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}