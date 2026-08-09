import 'package:coffee_shop/modals/drinks_model.dart';
import 'package:flutter/material.dart';

class DrinksProvider extends ChangeNotifier {
  final List<DrinksModel> _drinks = [
    DrinksModel(
      title: 'Strawberry',
      price: 10,
      imagePath: 'assets/images/staberry_image.png',
      type: 'Juice',
      description:
          'A refreshing blend of fresh strawberries, bursting with natural sweetness and a hint of tartness. Perfect for a sunny day treat.',
      topBackgroundColor: const Color(0xFF5A2528),
      bottomBackgroundColor: const Color(0xFFC9575B),
      buttonColor: const Color(0xFFEFA1A3),

      textColor: Colors.black,
      rating: 4.0,
    ),
    DrinksModel(
      title: 'Tea',
      price: 18,
      imagePath: 'assets/images/tea.png',
      type: 'Tea',
      description:
          'A classic warm brew crafted from premium tea leaves. Smooth, aromatic, and comforting — the perfect way to start or unwind your day.',
      topBackgroundColor: const Color(0xFF6E292D),
      bottomBackgroundColor: const Color(0xFFE85D68),
      buttonColor: const Color(0xFFF5A0A5),

      textColor: Colors.black,
      rating: 4.5,
    ),
    DrinksModel(
      title: 'Watermelon',
      price: 18,
      imagePath: 'assets/images/coffee.png',
      type: 'coffee',
      description:
          'A bold, rich coffee blend with a hint of watermelon sweetness. A unique fusion that delivers the perfect balance of energy and refreshment.',
      topBackgroundColor: const Color(0xFF6E292D),
      bottomBackgroundColor: const Color(0xFFE85D68),
      buttonColor: const Color(0xFFF5A0A5),

      textColor: Colors.black,
      rating: 4.5,
    ),

    DrinksModel(
      title: 'Watermelon',
      price: 18,
      imagePath: 'assets/images/watermilan_juice.png',
      type: 'Juice',
      description:
          'Ice-cold watermelon juice blended to perfection. Naturally hydrating, sweet, and loaded with vitamins for a revitalizing boost.',
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
      type: 'Juice',
      description:
          'Rich, ruby-red pomegranate juice packed with antioxidants. Deep and tangy with a naturally sweet finish — a true superfruit experience.',
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
      type: 'Juice',
      description:
          'Crisp and freshly pressed apple juice with a bright golden hue. Naturally sweet and smooth, delivering pure orchard goodness in every sip.',
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
      type: 'Tea',
      description:
          'A zesty and invigorating lemon tea with a warm, citrusy kick. The perfect blend of tangy lemon and smooth tea to brighten your mood.',
      topBackgroundColor: const Color(0xFF5A3A24),
      bottomBackgroundColor: const Color(0xFFD98B2B),
      buttonColor: const Color(0xFFF3B83F),
      textColor: Colors.black,
      rating: 4.5,
    ),
  ];

  String _searchQuery = "";
  String _selectedCategory = "All";

  //all drinks

  List<DrinksModel> get drinks {
    var result = _drinks;

    // Apply category filter
    if (_selectedCategory != 'All') {
      result = result
          .where((drink) => drink.type == _selectedCategory)
          .toList();
    }

    // Apply text search filter
    if (_searchQuery.isNotEmpty) {
      result = result.where((drink) {
        return drink.title.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return List.unmodifiable(result);
  }

  //search
  void searchDrinks(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = "";
    notifyListeners();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
