  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
  import '../../../di/Providers.dart';
  import '../../../utils/Extension.dart';
import '../../custom_components/InputTextView.dart';
  import '../../themes/AppColors.dart';
  import '../../../data/Constants.dart';
import '../dashboard/Dashboard.dart';

  class Login extends ConsumerStatefulWidget {
    @override
    _LoginState createState() => _LoginState();
  }

  class _LoginState extends ConsumerState<Login> {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Logger log = Logger();

    bool isDataInserted = false; // Untuk memastikan insert hanya sekali

    Future<void> initializeData() async {
      // Fungsi untuk insert data jika belum ada
      if (!isDataInserted) {
        final loginViewModel = ref.read(loginViewModelProvider.notifier);
        try {
          final initialUsers = Constants.getListUser(); // Ambil list user dari Constants
          await loginViewModel.insertUsers(initialUsers); // Insert ke ViewModel
          isDataInserted = true; // Tandai data sudah di-insert
          log.d("Data awal berhasil diinsert.");
        } catch (e) {
          log.e("Error saat insert data awal: $e");
        }
      }
    }

    // Fungsi login yang akan dipanggil ketika user menekan tombol login
    // Future<void> onLogin(String email, String password) async {
    //   final loginViewModel = ref.read(loginViewModelProvider.notifier); // Ambil viewmodel dari Riverpod
    //
    //   // Cek inputan
    //   if (email.isEmpty || password.isEmpty) {
    //     log.e("Email atau password kosong.");
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Email atau password tidak boleh kosong')),
    //     );
    //     return;
    //   }
    //
    //   try {
    //     // Tampilkan loading
    //     await loginViewModel.loginUser(email, password);
    //
    //     // ref.read(loginViewModelProvider.notifier).loginUser(email, password);
    //
    //     final loginState = ref.watch(loginViewModelProvider); // Mengamati perubahan state
    //     if (loginState is AsyncLoading) {
    //       // Tampilkan loading jika statusnya loading
    //       return;
    //     }
    //
    //     if (loginState is AsyncData) {
    //       // Jika login berhasil dan ada data pengguna
    //       final users = loginState.value;
    //       if (users!.isNotEmpty) {
    //         log.d("Login berhasil untuk user: ${users.first.email}");
    //         // Navigator.pushReplacementNamed(context, '/home'); // Ganti '/home' dengan route yang sesuai
    //       } else {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           const SnackBar(content: Text('Login gagal: User tidak ditemukan')),
    //         );
    //       }
    //     } else if (loginState is AsyncError) {
    //       // Jika terjadi error saat login
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('Terjadi kesalahan. Cek kredensial anda.')),
    //       );
    //     }
    //   } catch (e) {
    //     log.e("Login error: $e");
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Terjadi kesalahan. Coba lagi nanti.')),
    //     );
    //   }
    // }

    Future<void> onLogin(String email, String password) async {
      // Cek input email dan password
      if (email.isEmpty || password.isEmpty) {
        log.e("Email atau password kosong.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email atau password tidak boleh kosong')),
        );
        return;
      }

      try {
        // Tampilkan loading saat proses login
        await ref.read(loginViewModelProvider.notifier).loginUser(email, password);

        // Ambil state login terbaru
        final loginState = ref.watch(loginViewModelProvider);

        // Cek status login
        if (loginState is AsyncLoading) {
          // Jangan lakukan apa-apa selama loading
          return;
        }

        if (loginState is AsyncData) {
          // Jika login berhasil dan data ada
          final users = loginState.value;
          if (users != null && users.isNotEmpty) {
            log.d("Login berhasil untuk user: ${users.first.email}");

            // Generate Token
            String token = Extension.generateToken(128); // Menggunakan panjang token 32 karakter

            // Menyimpan token ke SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(Constants.TOKEN_KEY, token);

            // Cek apakah token sudah berhasil disimpan
            final savedToken = prefs.getString(Constants.TOKEN_KEY);
            if (savedToken != null && savedToken.isNotEmpty) {
              log.d("Token berhasil disimpan: $savedToken");

              // Tampilkan SnackBar jika login berhasil
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login berhasil!')),
              );

              // Navigasi ke halaman Dashboard
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gagal menyimpan token.')),
              );
            }

          } else {
            // Tampilkan SnackBar jika user tidak ditemukan
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login gagal: User tidak ditemukan')),
            );
          }
        } else if (loginState is AsyncError) {
          // Tampilkan SnackBar jika terjadi error saat login
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Terjadi kesalahan: ${loginState.error}')),
          );
        }
      } catch (e) {
        log.e("Login error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Terjadi kesalahan. Coba lagi nanti.')),
        );
      }
    }


    @override
    void initState() {
      super.initState();
      initializeData();
    }

    @override
    Widget build(BuildContext context) {
      final loginState = ref.watch(loginViewModelProvider); // Mengamati perubahan state

      return Scaffold(
        body: Stack(
          children: [
            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/userhub_logo.png',
                    width: 131,
                    height: 131,
                  ),
                  const SizedBox(height: 40),
                  // Email Input
                  InputTextView(
                    title: 'Email',
                    inputType: InputType.EMAIL,
                    controller: emailController,
                  ),
                  const SizedBox(height: 10),
                  // Password Input
                  InputTextView(
                    title: 'Password',
                    inputType: InputType.PASSWORD,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 30),
                  // Login Button
                  ElevatedButton(
                    onPressed: loginState is AsyncLoading
                        ? null // Disable button while loading
                        : () {
                      String email = emailController.text.trim();
                      String password = passwordController.text.trim();
                      onLogin(email, password); // Panggil fungsi login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.socialist,
                      foregroundColor: AppColors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: loginState is AsyncLoading
                        ? const CircularProgressIndicator(
                      color: AppColors.white,
                    )
                        : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.login),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Footer Text
                  const Text(
                    '© 2024 NewsNexus',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.leadbelcher,
                    ),
                  ),
                ],
              ),
            ),
            // Loading Indicator
            if (loginState is AsyncLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.socialist,
                  ),
                ),
              ),
          ],
        ),
      );
    }
  }
