import 'package:flutter/material.dart';

import '../models/pet.dart';
import '../widgets/pets_grid.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favs = pets.where((p) => p.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),

      body: favs.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'No favorites yet.\nTap the heart on a pet to add it here.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : PetsGrid(pets: favs),
    );
  }
}
