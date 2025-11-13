import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:share_plus/share_plus.dart';

import '../models/pet.dart';
import '../widgets/info_chip.dart';

class PetDetailsScreen extends StatelessWidget {
  const PetDetailsScreen({super.key, required this.pet});

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.black),
                onPressed: () {
                  Share.share(
                    '🐾 Meet ${pet.name}!\n'
                    'Breed: ${pet.breed}\n'
                    'Age: ${pet.age}\n'
                    'Gender: ${pet.gender}\n'
                    'Distance: ${pet.distanceKm.toStringAsFixed(1)} km away\n\n'
                    'Photo: ${pet.imageUrl}\n'
                    'Adopt your new best friend today ❤️',
                    subject: 'Adopt ${pet.name}',
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.25),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: Text(
                      pet.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'pet_${pet.id}',
                    child: Image.network(
                      pet.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        color: cs.surfaceContainerHighest,
                        alignment: Alignment.center,
                        child: const Icon(Icons.pets, size: 64),
                      ),
                    ),
                  ),
                  // Gradient overlay bottom
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.35),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top chips
                  Row(
                    children: [
                      InfoChip(label: pet.breed, icon: Icons.badge),
                      const SizedBox(width: 8),
                      InfoChip(label: pet.age, icon: Icons.cake),
                      const SizedBox(width: 8),
                      InfoChip(label: pet.gender, icon: Icons.wc),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // About section
                  Text(
                    'About ${pet.name}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Gentle and curious, great with families and enjoys playtime. '
                    'Vaccinated and ready for a forever home. Likes sunbeams, cuddles, '
                    'and chasing squeaky toys. House-trained and social with other pets.',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),

                  // Location row
                  Row(
                    children: [
                      const Icon(Icons.place),
                      const SizedBox(width: 8),
                      Text('${pet.distanceKm.toStringAsFixed(1)} km away'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // CTA button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Thanks! We'll contact you about adopting ${pet.name}.",
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.volunteer_activism),
                      label: const Text('Adopt me'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
