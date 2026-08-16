import 'package:coffee_shop/modals/product_model.dart';
import 'package:coffee_shop/providers/drinks_provider.dart';
import 'package:coffee_shop/providers/products_provider.dart';
import 'package:coffee_shop/screens/about_us_screen.dart';
import 'package:coffee_shop/screens/add_product_screen.dart';
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
  final List<String> categories = ['All', 'Juice', 'Tea', 'Shake'];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProductProvider>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff8c3332), Color(0xff1e0909)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search drinks...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onChanged: (query) {
                    context.read<DrinksProvider>().searchDrinks(query);
                  },
                )
              : const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  if (_isSearching) {
                    _isSearching = false;
                    _searchController.clear();
                    context.read<DrinksProvider>().clearSearch();
                  } else {
                    _isSearching = true;
                  }
                });
              },
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xFF5A2A2A),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFF8B4B4B)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.coffee, size: 40, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Coffee Shop',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AddProductScreen()),
                  );
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.white),
                title: const Text(
                  'Cart',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Can navigate to Cart screen if implemented
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Colors.white),
                title: const Text(
                  'About Us',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!_isSearching) ...[
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
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
                                context.read<DrinksProvider>().filterByCategory(
                                  categories[index],
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
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
                        child: StreamBuilder<List<ProductsModel>>(
                          stream: provider.fetchProducts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  'Error: ${snapshot.error}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No products found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }

                            final allProducts = snapshot.data!;
                            final selectedCategory = categories[selectedCategoryIndex];
                            
                            final products = selectedCategory == 'All' 
                                ? allProducts 
                                : allProducts.where((p) => p.type.toLowerCase() == selectedCategory.toLowerCase()).toList();

                            if (products.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No products in this category',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final item = products[index];
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
      ),
    );
  }
}

class DrinkMenuCard extends StatelessWidget {
  final ProductsModel item;

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
            child: Hero(
              tag: 'drink_${item.title}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  item.imageUrl,
                  width: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.fastfood, size: 60, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
