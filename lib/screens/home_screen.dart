import 'package:flutter/material.dart';

import '../models/pet.dart';
import '../widgets/pets_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _query = '';
  PetType? _filterType; // null = All
  bool _showFavoritesOnly = false;

  List<Pet> get _filteredPets {
    return pets.where((p) {
      final matchesType = _filterType == null || p.type == _filterType;
      final matchesQuery =
          _query.isEmpty ||
          p.name.toLowerCase().contains(_query) ||
          p.breed.toLowerCase().contains(_query);
      final matchesFav = !_showFavoritesOnly || p.isFavorite;

      return matchesType && matchesQuery && matchesFav;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PawPals'),
        actions: [
          Tooltip(
            message: _showFavoritesOnly ? 'Show all' : 'Show favorites',
            child: IconButton(
              onPressed: () =>
                  setState(() => _showFavoritesOnly = !_showFavoritesOnly),
              icon: Icon(
                _showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search pets or breeds…',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (v) =>
                    setState(() => _query = v.toLowerCase().trim()),
              ),
            ),
            const SizedBox(height: 8),

            // Filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: _filterType == null,
                    onSelected: (_) => setState(() => _filterType = null),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Dogs'),
                    selected: _filterType == PetType.dog,
                    onSelected: (_) =>
                        setState(() => _filterType = PetType.dog),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Cats'),
                    selected: _filterType == PetType.cat,
                    onSelected: (_) =>
                        setState(() => _filterType = PetType.cat),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Grid
            Expanded(child: PetsGrid(pets: _filteredPets)),
          ],
        ),
      ),
    );
  }
}
