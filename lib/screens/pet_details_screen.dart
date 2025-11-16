import 'package:flutter/material.dart';
import 'dart:ui';

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
            flexibleSpace: FlexibleSpaceBar(
              title: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: Colors.black.withOpacity(0.25),
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
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.35),
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

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        final cs = Theme.of(context).colorScheme;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: cs.primaryContainer,
                            content: Row(
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.pinkAccent,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Thank you! Your request for ${pet.name} has been sent 💕",
                                    style: TextStyle(
                                      color: cs.onPrimaryContainer,
                                    ),
                                  ),
                                ),
                              ],
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

void _showHeartsPopup(BuildContext context, String petName) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Adopted',
    barrierColor: Colors.black54,
    pageBuilder: (context, anim1, anim2) {
      return const SizedBox.shrink();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final scale = Curves.easeOutBack.transform(animation.value);
      final opacity = animation.value;

      return Opacity(
        opacity: opacity,
        child: Center(
          child: Transform.scale(
            scale: scale,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    spacing: 8,
                    children: const [
                      Icon(Icons.favorite, color: Colors.pinkAccent, size: 40),
                      Icon(Icons.favorite, color: Colors.redAccent, size: 32),
                      Icon(Icons.favorite, color: Colors.pink, size: 28),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Yay! $petName is one step closer to a home 💕',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We\'ll share your interest with the shelter.',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
