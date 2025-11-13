import 'package:flutter/material.dart';

import '../models/pet.dart';
import 'pet_card.dart';

class PetsGrid extends StatelessWidget {
  const PetsGrid({super.key, required this.pets});

  final List<Pet> pets;

  @override
  Widget build(BuildContext context) {
    if (pets.isEmpty) {
      return const SizedBox();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.78,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: pets.length,
      itemBuilder: (context, i) => PetCard(pet: pets[i]),
    );
  }
}
