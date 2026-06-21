import 'package:flutter/material.dart';

void main() {
  runApp(const TripSnapApp());
}

class TripSnapApp extends StatelessWidget {
  const TripSnapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TripSnap Travel App',
      theme: ThemeData(
        primaryColor: const Color(0xFF1D4ED8),
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

// ==========================================
// 1. HALAMAN LOGIN
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _handleLogin() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Email dan Password tidak boleh kosong!';
      });
    } else {
      setState(() {
        _errorMessage = '';
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen1()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/logo_tripsnap.png',
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Selamat Datang Kembali',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Masukkan akun anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 8),
                  _buildInputField(controller: _emailController, icon: Icons.email_outlined, hintText: 'Email atau No. HP'),
                  const SizedBox(height: 16),
                  _buildInputField(controller: _passwordController, icon: Icons.lock_outline, hintText: 'Password', obscureText: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Lupa Password?', style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D4ED8),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Masuk', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required IconData icon, required String hintText, bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}

// ==========================================
// 2. HALAMAN ONBOARDING
// ==========================================
class BaseOnboardingScreen extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String subtitle;
  final VoidCallback onNext;

  const BaseOnboardingScreen({
    super.key,
    required this.backgroundImage,
    required this.title,
    required this.subtitle,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.3)),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 220,
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const CircleAvatar(backgroundColor: Color(0xFF1D4ED8), radius: 24, child: Icon(Icons.arrow_forward, color: Colors.white)),
                    onPressed: onNext,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseOnboardingScreen(
      backgroundImage: 'https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=1200',
      title: 'Selamat Datang di TripSnap!',
      subtitle: 'Temukan tempat wisata lokal terbaik: mulai dari pantai, gunung, hingga kuliner khas daerah.',
      onNext: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OnboardingScreen2())),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseOnboardingScreen(
      backgroundImage: 'https://images.pexels.com/photos/3278215/pexels-photo-3278215.jpeg?auto=compress&cs=tinysrgb&w=1200',
      title: 'Abadikan Setiap Momen',
      subtitle: 'Potret keindahan pemandangan dengan kamera sekelilingmu. Simpan memori bermakna dari setiap perjalanan.',
      onNext: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OnboardingScreen3())),
    );
  }
}

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseOnboardingScreen(
      backgroundImage: 'https://images.pexels.com/photos/1007427/pexels-photo-1007427.jpeg?auto=compress&cs=tinysrgb&w=1200',
      title: 'Rencanakan Perjalananmu',
      subtitle: 'Cari rekomendasi wisata, lihat panduan lokasi, dan simpan favorit untuk petualangan berikutnya.',
      onNext: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainNavigation())),
    );
  }
}

// ==========================================
// 3. MAIN NAVIGATION
// ==========================================
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(), // Sekarang menggunakan Tabs Bar di dalamnya
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  // 🛠️ IMPLEMENTASI TUGAS: SHEET:BOTTOM (Pengganti Dialog)
  void _showAddTripBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 20),
            const Text(
              'TripSnap Cam',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fitur kamera petualangan baru akan segera hadir untuk mengabadikan momen travelmu!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF1D4ED8),
                child: Icon(Icons.camera_alt, color: Colors.white),
              ),
              title: const Text('Ambil Foto Baru', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF1D4ED8).withValues(alpha: 0.1),
                child: const Icon(Icons.photo_library, color: Color(0xFF1D4ED8)),
              ),
              title: const Text('Pilih dari Galeri', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTripBottomSheet, // Memanggil Bottom Sheet baru
        backgroundColor: const Color(0xFF1D4ED8),
        elevation: 6,
        shape: const CircleBorder(),
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero, 
        height: 65, 
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF1D4ED8),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedFontSize: 11,   
          unselectedFontSize: 11, 
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 22), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.explore_outlined, size: 22), label: 'Explore'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none, size: 22), label: 'Notif'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 22), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. HOME SCREEN
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheetContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      
      // 🛠️ IMPLEMENTASI TUGAS: NAVIGATION DRAWER (Menu Samping)
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF1D4ED8)),
              accountName: const Text('Aliefff', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              accountEmail: const Text('aliefff@tripsnap.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'A',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF1D4ED8)),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_outline, color: Colors.black87),
              title: const Text('Destinasi Tersimpan'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.black87),
              title: const Text('Riwayat Perjalanan'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.black87),
              title: const Text('Pusat Bantuan'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Keluar Akun', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: const Text('TripSnap', style: TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87), // Menampilkan tombol hamburger drawer otomatis
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hi, Aliefff', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Yuk jelajahi dunia!', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const CircleAvatar(radius: 20, backgroundColor: Color(0xFFE2E8F0)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Cari destinasi...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => _showFilterBottomSheet(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D4ED8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Tempat Baru'),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDestinationCard(context, 'Sipiso-piso', 'Merek, Sumatera Utara', 'assets/sipiso-piso.jpg'),
                  _buildDestinationCard(context, 'Danau Toba', 'Samosir, Sumatera Utara', 'assets/danautoba.jpg'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Populer Wisata'),
            const SizedBox(height: 12),
            _buildWideDestinationCard(context, 'Sipiso-piso Waterfall', 'Tongging', 'assets/sipiso-piso.jpg'),
            const SizedBox(height: 12),
            _buildWideDestinationCard(context, 'Bukit Holbung', 'Samosir', 'assets/danautoba.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const Text('Lihat selengkapnya >', style: TextStyle(color: Color(0xFF1D4ED8), fontSize: 12)),
      ],
    );
  }

  Widget _buildDestinationCard(BuildContext context, String title, String location, String imgUrl) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(title: title, imageUrl: imgUrl))),
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: AssetImage(imgUrl), fit: BoxFit.cover),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 12),
                const SizedBox(width: 4),
                Expanded(child: Text(location, style: const TextStyle(color: Colors.white70, fontSize: 10), overflow: TextOverflow.ellipsis)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWideDestinationCard(BuildContext context, String title, String location, String imgUrl) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(title: title, imageUrl: imgUrl))),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(image: AssetImage(imgUrl), fit: BoxFit.cover),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 12),
                const SizedBox(width: 4),
                Text(location, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 5. EXPLORE SCREEN (Menerapkan Tabs Bar)
// ==========================================
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🛠️ IMPLEMENTASI TUGAS: TABS BAR (Kategori Destinasi)
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jelajahi Wisata', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 1,
          bottom: const TabBar(
            labelColor: Color(0xFF1D4ED8),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF1D4ED8),
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Alam', icon: Icon(Icons.landscape)),
              Tab(text: 'Budaya', icon: Icon(Icons.gavel)),
              Tab(text: 'Kuliner', icon: Icon(Icons.restaurant)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Daftar Wisata Alam (Pantai, Gunung, Air Terjun)')),
            Center(child: Text('Daftar Wisata Budaya, Situs Bersejarah & Edukasi')),
            Center(child: Text('Daftar Kuliner Khas Daerah Terbaik')),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// HALAMAN NOTIFIKASI
// ==========================================
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifikasi', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.white, elevation: 1),
      body: const Center(child: Text('Belum ada notifikasi baru masuk')),
    );
  }
}

// ==========================================
// HALAMAN FILTER BOTTOM SHEET
// ==========================================
class FilterBottomSheetContent extends StatefulWidget {
  const FilterBottomSheetContent({super.key});
  @override
  State<FilterBottomSheetContent> createState() => _FilterBottomSheetContentState();
}

class _FilterBottomSheetContentState extends State<FilterBottomSheetContent> {
  String _selectedCategory = 'Semua';
  final List<String> _categories = ['Semua', 'Alam', 'Danau', 'Air Terjun', 'Kuliner'];
  String _selectedSort = 'Terpopuler';
  bool _hasWifi = false;
  bool _hasParking = false;
  bool _isKidFriendly = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 20),
          const Text('Filter Destinasi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          const Text('Kategori Wisata', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _categories.map((category) {
              final isSelected = _selectedCategory == category;
              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                selectedColor: const Color(0xFF1D4ED8).withValues(alpha: 0.2),
                checkmarkColor: const Color(0xFF1D4ED8),
                labelStyle: TextStyle(color: isSelected ? const Color(0xFF1D4ED8) : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                onSelected: (bool selected) { setState(() { if (selected) _selectedCategory = category; }); },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text('Urutkan Berdasarkan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Terpopuler', style: TextStyle(fontSize: 13)),
                  value: 'Terpopuler', groupValue: _selectedSort, contentPadding: EdgeInsets.zero, activeColor: const Color(0xFF1D4ED8),
                  controlAffinity: ListTileControlAffinity.leading, onChanged: (value) { setState(() { _selectedSort = value!; }); },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Ulasan', style: TextStyle(fontSize: 13)),
                  value: 'Ulasan', groupValue: _selectedSort, contentPadding: EdgeInsets.zero, activeColor: const Color(0xFF1D4ED8),
                  controlAffinity: ListTileControlAffinity.leading, onChanged: (value) { setState(() { _selectedSort = value!; }); },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Fasilitas Area', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          CheckboxListTile(
            title: const Text('Akses Wi-Fi Gratis', style: TextStyle(fontSize: 14)), value: _hasWifi, dense: true, activeColor: const Color(0xFF1D4ED8), contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading, onChanged: (bool? value) { setState(() { _hasWifi = value!; }); },
          ),
          CheckboxListTile(
            title: const Text('Tempat Parkir Luas', style: TextStyle(fontSize: 14)), value: _hasParking, dense: true, activeColor: const Color(0xFF1D4ED8), contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading, onChanged: (bool? value) { setState(() { _hasParking = value!; }); },
          ),
          CheckboxListTile(
            title: const Text('Ramah Anak & Keluarga', style: TextStyle(fontSize: 14)), value: _isKidFriendly, dense: true, activeColor: const Color(0xFF1D4ED8), contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading, onChanged: (bool? value) { setState(() { _isKidFriendly = value!; }); },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1D4ED8), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('Terapkan Filter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// HALAMAN PROFILE SCREEN
// ==========================================
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  bool _smartNotification = true;
  String _selectedLanguage = 'Bahasa Indonesia';
  final List<String> _languages = ['Bahasa Indonesia', 'English', '日本語'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text('Pengaturan Akun', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)), backgroundColor: Colors.white, elevation: 1, centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(radius: 45, backgroundColor: Color(0xFF1D4ED8), child: Icon(Icons.person, size: 50, color: Colors.white)),
                  const SizedBox(height: 12),
                  const Text('Aliefff', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('aliefff@tripsnap.com', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Preferences', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.withValues(alpha: 0.2))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: const [Icon(Icons.language, color: Color(0xFF1D4ED8)), SizedBox(width: 12), Text('Bahasa Aplikasi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))]),
                  DropdownButton<String>(
                    value: _selectedLanguage, icon: const Icon(Icons.arrow_drop_down, color: Colors.grey), style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13), underline: Container(),
                    onChanged: (String? newValue) { setState(() { _selectedLanguage = newValue!; }); },
                    items: _languages.map<DropdownMenuItem<String>>((String value) { return DropdownMenuItem<String>(value: value, child: Text(value)); }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.withValues(alpha: 0.2))),
              child: SwitchListTile(
                title: const Text('Mode Gelap (Dark Mode)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)), secondary: const Icon(Icons.dark_mode, color: Color(0xFF1D4ED8)),
                value: _isDarkMode, activeThumbColor: const Color(0xFF1D4ED8), contentPadding: EdgeInsets.zero,
                onChanged: (bool value) { setState(() { _isDarkMode = value; }); },
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.withValues(alpha: 0.2))),
              child: SwitchListTile(
                title: const Text('Notifikasi Rekomendasi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)), secondary: const Icon(Icons.notifications_active, color: Color(0xFF1D4ED8)),
                value: _smartNotification, activeThumbColor: const Color(0xFF1D4ED8), contentPadding: EdgeInsets.zero,
                onChanged: (bool value) { setState(() { _smartNotification = value; }); },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// HALAMAN DETAIL WISATA
// ==========================================
class DetailScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  const DetailScreen({super.key, required this.title, required this.imageUrl});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300, pinned: true,
            leading: IconButton(icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18)), onPressed: () => Navigator.pop(context)),
            flexibleSpace: FlexibleSpaceBar(background: Image.asset(widget.imageUrl, fit: BoxFit.cover)),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -30),
              child: Container(
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Row(children: [Icon(Icons.location_on, color: Colors.grey, size: 16), SizedBox(width: 4), Expanded(child: Text('Tongging, Merek, Kabupaten Karo, Sumatera Utara', style: TextStyle(color: Colors.grey)))]),
                    const SizedBox(height: 16),
                    const Text('Air Terjun Sipiso-piso merupakan air terjun tertinggi dari tebing yang terletak di tepi Danau Toba. Air terjun ini memiliki ketinggian sekitar 120 meter.', style: TextStyle(color: Colors.black87, height: 1.5)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}