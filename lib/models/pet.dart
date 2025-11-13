enum PetType { dog, cat }

class Pet {
  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.gender,
    required this.distanceKm,
    required this.imageUrl,
    required this.type,
    this.isFavorite = false,
  });

  final int id;
  final String name;
  final String breed;
  final String age;
  final String gender;
  final double distanceKm;
  final String imageUrl;
  final PetType type;
  bool isFavorite;
}

// Mock data
final List<Pet> pets = [
  Pet(
    id: 1,
    name: 'Luna',
    breed: 'Arabian Mau',
    age: '2 yrs',
    gender: 'Female',
    distanceKm: 3.1,
    type: PetType.cat,
    imageUrl:
        'https://images.unsplash.com/photo-1596854372847-5d31d08f6b9b?q=80&w=1200&auto=format&fit=crop',
  ),
  Pet(
    id: 2,
    name: 'Max',
    breed: 'Saluki Mix',
    age: '1 yr',
    gender: 'Male',
    distanceKm: 5.2,
    type: PetType.dog,
    imageUrl:
        'https://images.unsplash.com/photo-1543466835-00a7907e9de1?q=80&w=1200&auto=format&fit=crop',
  ),
  Pet(
    id: 3,
    name: 'Mishmish',
    breed: 'Domestic Short Hair',
    age: '8 mo',
    gender: 'Female',
    distanceKm: 1.4,
    type: PetType.cat,
    imageUrl:
        'https://images.unsplash.com/photo-1555685812-4b943f1cb0eb?q=80&w=1200&auto=format&fit=crop',
  ),
  Pet(
    id: 4,
    name: 'Rocky',
    breed: 'German Shepherd',
    age: '3 yrs',
    gender: 'Male',
    distanceKm: 9.8,
    type: PetType.dog,
    imageUrl:
        'https://images.unsplash.com/photo-1561037404-61cd46aa615b?q=80&w=1200&auto=format&fit=crop',
  ),
  Pet(
    id: 5,
    name: 'Bella',
    breed: 'Husky',
    age: '2 yrs',
    gender: 'Female',
    distanceKm: 7.3,
    type: PetType.dog,
    imageUrl:
        'https://images.unsplash.com/photo-1517849845537-4d257902454a?q=80&w=1200&auto=format&fit=crop',
  ),
  Pet(
    id: 6,
    name: 'Oreo',
    breed: 'Tuxedo Cat',
    age: '10 mo',
    gender: 'Male',
    distanceKm: 2.6,
    type: PetType.cat,
    imageUrl:
        'https://images.unsplash.com/photo-1543852786-1cf6624b9987?q=80&w=1200&auto=format&fit=crop',
  ),
];
