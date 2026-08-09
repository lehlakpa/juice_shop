import 'package:coffee_shop/modals/drinks_model.dart';
import 'package:coffee_shop/providers/drinks_provider.dart';
import 'package:coffee_shop/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;
  final List<String> categories = ['Shakes', 'Cocktail', 'Coffee', 'Tea'];

  @override
  Widget build(BuildContext context) {
    final drink = context.watch<DrinksProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFF5A2A2A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                categories[selectedCategoryIndex],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  children: [
                    // Vertical Tabs
                    SizedBox(
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(categories.length, (index) {
                          final isSelected = index == selectedCategoryIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF8B4B4B)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white70,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.white24,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    const SizedBox(width: 12),
                    // Item List
                    Expanded(
                      child: ListView.builder(
                        itemCount: drink.drinks.length,
                        itemBuilder: (context, index) {
                          final item = drink.drinks[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailScreen(item: item),
                                ),
                              );
                            },
                            child: DrinkMenuCard(item: item),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrinkMenuCard extends StatelessWidget {
  final DrinksModel item;

  const DrinkMenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          // Background Card Shape
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            left: 30,
            child: Container(
              padding: const EdgeInsets.only(right: 20, left: 70),
              decoration: const BoxDecoration(
                color: Color(0xFFFBE3E3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Price \$${item.price.toInt()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Floating Image
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                item.imagePath,
                width: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.fastfood, size: 60, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
