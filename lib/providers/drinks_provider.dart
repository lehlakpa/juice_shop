import 'package:coffee_shop/modals/drinks_model.dart';
import 'package:flutter/material.dart';

class DrinksProvider extends ChangeNotifier {
  final List<DrinksModel> _drinks = [
    DrinksModel(
      title: 'Strawberry',
      price: 10,
      imagePath: 'assets/images/staberry_image.png',

      topBackgroundColor: const Color(0xFF5A2528),
      bottomBackgroundColor: const Color(0xFFC9575B),
      buttonColor: const Color(0xFFEFA1A3),

      textColor: Colors.black,
      rating: 4.0,
    ),

    DrinksModel(
      title: 'Watermelon',
      price: 18,
      imagePath: 'assets/images/watermilan_juice.png',
      topBackgroundColor: const Color(0xFF6E292D),
      bottomBackgroundColor: const Color(0xFFE85D68),
      buttonColor: const Color(0xFFF5A0A5),

      textColor: Colors.black,
      rating: 4.5,
    ),

    DrinksModel(
      title: 'Pomegranate',
      price: 18,
      imagePath: 'assets/images/pomgranate_juice.png',
      topBackgroundColor: const Color(0xFF5B171E),
      bottomBackgroundColor: const Color(0xFFC72F45),
      buttonColor: const Color(0xFFE97983),
      textColor: Colors.black,
      rating: 4.5,
    ),

    DrinksModel(
      title: 'Apple',
      price: 16,
      imagePath: 'assets/images/apple_juice.png',

      topBackgroundColor: const Color(0xFF7A3B2E),
      bottomBackgroundColor: const Color(0xFFE5A33A),
      buttonColor: const Color(0xFFF5C45A),
      textColor: Colors.black,
      rating: 4.5,
    ),

    DrinksModel(
      title: 'Lemon Tea',
      price: 12,
      imagePath: 'assets/images/lemoan_tea.png',

      topBackgroundColor: const Color(0xFF5A3A24),
      bottomBackgroundColor: const Color(0xFFD98B2B),
      buttonColor: const Color(0xFFF3B83F),
      textColor: Colors.black,
      rating: 4.5,
    ),
  ];

  List<DrinksModel> _filteredDrinks = [];

  final List<DrinksModel> _cart = [];
  String _searchQuery = "";

  //all drinks

  List<DrinksModel> get drinks {
    if (_searchQuery.isEmpty) {
      return List.unmodifiable(_drinks);
    }
    return List.unmodifiable(_filteredDrinks);
  }

  //cart add
  List<DrinksModel> get cart => List.unmodifiable(_cart);

  String get searchQuery => _searchQuery;

  int get cartCount => _cart.length;

  double get cartTotal {
    return _cart.fold(0, (total, drink) => total + drink.price);
  }

  void addToCart(DrinksModel drink) {
    _cart.add(drink);
    notifyListeners();
  }

  void removeFromCart(DrinksModel drink) {
    _cart.remove(drink);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //search
  void searchDrinks(String query) {
    _searchQuery = query.trim();
    if (_searchQuery.isEmpty) {
      _filteredDrinks = [];
    } else {
      _filteredDrinks = _drinks.where((drink) {
        return drink.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = "";
    _filteredDrinks = [];
    notifyListeners();
  }
}
