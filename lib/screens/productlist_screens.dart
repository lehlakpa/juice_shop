import 'package:coffee_shop/modals/product_model.dart';
import 'package:coffee_shop/providers/Products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProductProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),

      body: StreamBuilder<List<ProductsModel>>(
        stream: provider.fetchProducts(),

        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Empty
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,

            itemBuilder: (context, index) {
              final product = products[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 15),

                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),

                  // IMAGE
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),

                    child: Image.network(
                      product.imageUrl,

                      width: 70,
                      height: 70,

                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, size: 50);
                      },
                    ),
                  ),

                  // TITLE
                  title: Text(
                    product.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // DESCRIPTION + PRICE
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),

                      Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 5),

                      Text(
                        'Rs. ${product.price}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
