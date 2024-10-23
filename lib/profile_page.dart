import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<UserProfile>(
        future: _getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Tidak ada data pengguna.'));
          } else {
            UserProfile userProfile = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, size: 100, color: Colors.blueAccent),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                'Nama: ${userProfile.fullName}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Email: ${userProfile.email}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Alamat : Sidorejo puwoharjo kabupaten banyuwwangi',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Nomer Tpl : 085704717410',
                                style: TextStyle(fontSize: 20),
                              ),
                            ])),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Konfirmasi penghapusan akun
                        bool? confirm =
                            await _showDeleteConfirmationDialog(context);
                        if (confirm == true) {
                          await _deleteAccount();
                          exit(0);
                        }
                      },
                      child: const Text('Hapus Akun',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<UserProfile> _getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? 'Tidak ada email';
    String fullName = prefs.getString('fullName') ?? 'Tidak ada nama';

    return UserProfile(fullName: fullName, email: email);
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Akun'),
          content: const Text('Apakah Anda yakin ingin menghapus akun ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Menutup dialog dan mengembalikan nilai false
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(true); // Menutup dialog dan mengembalikan nilai true
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua data pengguna
  }
}

class UserProfile {
  final String fullName;
  final String email;

  UserProfile({required this.fullName, required this.email});
}
