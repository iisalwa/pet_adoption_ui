import 'package:flutter/material.dart';

import '../models/pet.dart';
import '../controllers/favorites_controller.dart';
import '../screens/pet_details_screen.dart';

import 'info_chip.dart';
import 'gender_dot.dart';

class PetCard extends StatefulWidget {
  const PetCard({super.key, required this.pet});

  final Pet pet;

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  @override
  Widget build(BuildContext context) {
    final pet = widget.pet;
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PetDetailsScreen(pet: pet)),
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + Favorite Button
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 11,
                    child: Hero(
                      tag: 'pet_${pet.id}',
                      child: Image.network(
                        pet.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (c, w, p) {
                          if (p == null) return w;
                          return const SizedBox(
                            height: 140,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (c, e, s) => Container(
                          color: cs.surfaceContainerHighest,
                          alignment: Alignment.center,
                          child: const Icon(Icons.pets, size: 40),
                        ),
                      ),
                    ),
                  ),

                  // Favorite toggle
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          setState(() => pet.isFavorite = !pet.isFavorite);
                          FavoritesController.i.refresh();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            pet.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: pet.isFavorite ? Colors.red : cs.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Info section
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + gender + type
                  Row(
                    children: [
                      Text(
                        pet.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GenderDot(gender: pet.gender),
                      const Spacer(),
                      Icon(
                        pet.type == PetType.dog
                            ? Icons.pets
                            : Icons.pets_outlined,
                        size: 16,
                        color: cs.primary,
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Breed
                  Text(
                    pet.breed,
                    style: TextStyle(color: cs.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Age + distance
                  Row(
                    children: [
                      InfoChip(label: pet.age, icon: Icons.cake),
                      const SizedBox(width: 6),
                      InfoChip(
                        label: '${pet.distanceKm.toStringAsFixed(1)} km',
                        icon: Icons.place,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
