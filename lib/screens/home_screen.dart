import 'package:flutter/material.dart';

class DrinkItem {
  final String title;
  final double price;
  final String imagePath;
  final Color topBackgroundColor;
  final Color bottomBackgroundColor;
  final Color buttonColor;
  final Color textColor;
  final double rating;

  DrinkItem({
    required this.title,
    required this.price,
    required this.imagePath,
    required this.topBackgroundColor,
    required this.bottomBackgroundColor,
    required this.buttonColor,
    this.textColor = Colors.black,
    this.rating = 5.0,
  });
}

final List<DrinkItem> drinks = [
  // 🍓 STRAWBERRY
  DrinkItem(
    title: 'Strawberry',
    price: 10,
    imagePath: 'assets/images/staberry_image.png',

    // Dark red background
    topBackgroundColor: const Color(0xFF5A2528),

    // Pink/red bottom card
    bottomBackgroundColor: const Color(0xFFC9575B),

    // Light pink button
    buttonColor: const Color(0xFFEFA1A3),

    textColor: Colors.black,
    rating: 4.0,
  ),

  // 🍫 CHOCOLATE
  DrinkItem(
    title: 'Chocolate',
    price: 15,
    imagePath: 'assets/images/choclate_image.png',

    // Cream / beige top
    topBackgroundColor: const Color(0xFFC3AD94),

    // Warm cream/yellow bottom card
    bottomBackgroundColor: const Color(0xFFFFD487),

    // Orange button
    buttonColor: const Color(0xFFF39A55),

    textColor: Colors.black,
    rating: 5.0,
  ),

  // 🥭 MANGO
  DrinkItem(
    title: 'Mango',
    price: 20,
    imagePath: 'assets/images/mango_juice.png',

    // Bright yellow top
    topBackgroundColor: const Color(0xFFFFD447),

    // Deep orange bottom card
    bottomBackgroundColor: const Color(0xFFEF9500),

    // Yellow button
    buttonColor: const Color(0xFFFFC928),

    textColor: Colors.black,
    rating: 5.0,
  ),

  // 🍉 WATERMELON
  DrinkItem(
    title: 'Watermelon',
    price: 18,
    imagePath: 'assets/images/watermilan_juice.png',

    // Deep watermelon red
    topBackgroundColor: const Color(0xFF6E292D),

    // Watermelon pink/red
    bottomBackgroundColor: const Color(0xFFE85D68),

    // Light pink button
    buttonColor: const Color(0xFFF5A0A5),

    textColor: Colors.black,
    rating: 4.5,
  ),

  // ❤️ POMEGRANATE
  DrinkItem(
    title: 'Pomegranate',
    price: 18,
    imagePath: 'assets/images/pomgranate_juice.png',

    // Deep ruby red
    topBackgroundColor: const Color(0xFF5B171E),

    // Ruby/pomegranate red
    bottomBackgroundColor: const Color(0xFFC72F45),

    // Light red button
    buttonColor: const Color(0xFFE97983),

    textColor: Colors.black,
    rating: 4.5,
  ),

  // 🍎 APPLE
  DrinkItem(
    title: 'Apple',
    price: 16,
    imagePath: 'assets/images/apple_juice.png',

    // Dark warm brown/red
    topBackgroundColor: const Color(0xFF7A3B2E),

    // Golden orange
    bottomBackgroundColor: const Color(0xFFE5A33A),

    // Light golden button
    buttonColor: const Color(0xFFF5C45A),

    textColor: Colors.black,
    rating: 4.5,
  ),

  // 🍋 LEMON TEA
  DrinkItem(
    title: 'Lemon Tea',
    price: 12,
    imagePath: 'assets/images/lemoan_tea.png',

    // Warm dark tea background
    topBackgroundColor: const Color(0xFF5A3A24),

    // Amber/orange bottom
    bottomBackgroundColor: const Color(0xFFD98B2B),

    // Golden button
    buttonColor: const Color(0xFFF3B83F),

    textColor: Colors.black,
    rating: 4.5,
  ),
];

// final List<DrinkItem> drinks = [
//   DrinkItem(
//     title: 'Strawberry',
//     price: 10,
//     imagePath: 'assets/images/staberry_image.png',
//     topBackgroundColor: const Color(0xFF5A2A2A),
//     bottomBackgroundColor: const Color(0xFFBC4A4D),
//     buttonColor: const Color(0xFFEEA1A3),
//     textColor: Colors.black,
//     rating: 4.0,
//   ),
//   DrinkItem(
//     title: 'Chocolate',
//     price: 15,
//     imagePath: 'assets/images/lemoan_tea.png',
//     topBackgroundColor: const Color(0xFFD4AC8D),
//     bottomBackgroundColor: const Color(0xFFF7CF8B),
//     buttonColor: const Color(0xFFEF9853),
//     textColor: Colors.black,
//     rating: 5.0,
//   ),
//   DrinkItem(
//     title: 'Mango',
//     price: 20,
//     imagePath: 'assets/images/pomgranate_juice.png',
//     topBackgroundColor: const Color(0xFFFFC83B),
//     bottomBackgroundColor: const Color(0xFFE59400),
//     buttonColor: const Color(0xFFFFC83B),
//     textColor: Colors.black,
//     rating: 5.0,
//   ),
// ];

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
                        itemCount: drinks.length,
                        itemBuilder: (context, index) {
                          final item = drinks[index];
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

// ==========================================
// MENU CARD WIDGET
// ==========================================
class DrinkMenuCard extends StatelessWidget {
  final DrinkItem item;

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

// ==========================================
// DETAIL SCREEN
// ==========================================
class DetailScreen extends StatefulWidget {
  final DrinkItem item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: item.topBackgroundColor,
      body: Stack(
        children: [
          // Bottom Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.48,
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 90.0,
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
              ),
              decoration: BoxDecoration(
                color: item.bottomBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Title & Heart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.title} Shakes',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: item.textColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFC02A30),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Rating Stars
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < item.rating.toInt()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 20,
                          );
                        }),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${item.rating.toInt()}/5',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Price
                  Text(
                    'Price \$${item.price.toInt()}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: item.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Quantity Selector
                  Row(
                    children: [
                      _QuantityButton(
                        icon: Icons.remove,
                        onTap: () {
                          if (quantity > 1) setState(() => quantity--);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          quantity.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: item.textColor,
                          ),
                        ),
                      ),
                      _QuantityButton(
                        icon: Icons.add,
                        onTap: () => setState(() => quantity++),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Order Button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: item.buttonColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Order Now',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: item.textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Image Overlapping
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            bottom:
                MediaQuery.of(context).size.height *
                0.38, // Push the image further down into the bottom sheet
            left: 20,
            right: 20,
            child: Image.asset(
              item.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.fastfood, size: 120, color: Colors.white),
            ),
          ),

          // Top Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }
}
