import 'package:flutter/material.dart';
import '../models/pet.dart';

class FavoritesController extends ChangeNotifier {
  FavoritesController._();

  static final FavoritesController i = FavoritesController._();

  int get count => pets.where((p) => p.isFavorite).length;

  void refresh() => notifyListeners();
}
