import 'package:flutter/material.dart';

import '../controllers/theme_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile card
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
                  SizedBox(height: 12),
                  Text(
                    'Guest',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  SizedBox(height: 6),
                  Text('Welcome to PawPals!'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Dark mode switch
          SwitchListTile(
            title: const Text('Dark mode'),
            secondary: const Icon(Icons.dark_mode_outlined),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (v) => ThemeController.i.toggle(v),
          ),
        ],
      ),
    );
  }
}
