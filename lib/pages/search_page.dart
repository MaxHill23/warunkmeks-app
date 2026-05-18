import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  
  // Daftar semua game untuk fitur pencarian
  final List<Map<String, String>> allGames = [
    {'name': 'Mobile Legends', 'image': 'assets/image/logo_ml.png'},
    {'name': 'Free Fire', 'image': 'assets/image/logo_ff.png'},
    {'name': 'PUBG Mobile', 'image': 'assets/image/logo_pubg.png'},
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

  List<Map<String, String>> filteredGames = [];

  @override
  void initState() {
    super.initState();
    // Di awal, tampilkan semua game dulu sebelum diketik
    filteredGames = allGames;
  }

  void _filterGames(String query) {
    setState(() {
      filteredGames = allGames
          .where((game) => game['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Cari Game',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Kolom teks input pencarian yang mirip 100% dengan Figma kamu (Search Bar)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1C2E),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF23263D)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterGames,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'Cari Top Up Game...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Menampilkan Hasil Pencarian Game yang bisa di-scroll
            Expanded(
              child: filteredGames.isEmpty
                  ? const Center(
                      child: Text(
                        'Game tidak ditemukan...',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredGames.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1C2E),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFF23263D)),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                filteredGames[index]['image']!,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              filteredGames[index]['name']!,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                            onTap: () {
                              print('Membuka game: ${filteredGames[index]['name']}');
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}