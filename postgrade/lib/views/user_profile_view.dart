import 'package:flutter/material.dart';
import 'package:postgrade/styles/custom_app_bar.dart';
import 'package:postgrade/styles/custom_bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String email;
  final String profileImageUrl;

  const ProfilePage({
    super.key,
    this.userName = 'User Name',
    this.email = 'user@example.com',
    this.profileImageUrl =
        'https://via.placeholder.com/150', // Placeholder image
  });

  final CustomBottomNavBar _bottomNavBar = const CustomBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: true,
        context: context,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              const SizedBox(height: 16),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Implement profile edit or logout functionality
                },
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}
