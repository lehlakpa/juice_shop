import 'dart:typed_data';

import 'package:coffee_shop/providers/Products_provider.dart';
import 'package:coffee_shop/screens/productlist_screens.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  XFile? selectedImage;
  Uint8List? selectedImageBytes;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    final Uint8List bytes = await image.readAsBytes();

    if (!mounted) return;

    setState(() {
      selectedImage = image;
      selectedImageBytes = bytes;
    });
  }

  Future<void> addProduct() async {
    // Image validation
    if (selectedImage == null) {
      showMessage("Please select an image");
      return;
    }

    // Title validation
    if (titleController.text.trim().isEmpty) {
      showMessage("Please enter a title");
      return;
    }

    // Description validation
    if (descriptionController.text.trim().isEmpty) {
      showMessage("Please enter description");
      return;
    }

    // Price validation
    if (priceController.text.trim().isEmpty) {
      showMessage("Please enter price");
      return;
    }

    final double? price = double.tryParse(priceController.text.trim());

    if (price == null) {
      showMessage("Please enter a valid price");
      return;
    }

    final provider = context.read<ProductProvider>();

    final success = await provider.addProduct(
      image: selectedImage!,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      price: price,
    );

    if (!mounted) return;

    if (success) {
      showMessage("Product added successfully");

      // Clear fields
      titleController.clear();
      descriptionController.clear();
      priceController.clear();

      setState(() {
        selectedImage = null;
        selectedImageBytes = null;
      });
    } else {
      showMessage(provider.error ?? "Something went wrong");
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // watch is important here so UI rebuilds when loading changes
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ================= IMAGE =================
            GestureDetector(
              onTap: provider.isLoading ? null : pickImage,

              child: Container(
                width: double.infinity,
                height: 220,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),

                child: selectedImageBytes == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined, size: 50),

                          SizedBox(height: 10),

                          Text("Select Product Image"),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16),

                        child: Image.memory(
                          selectedImageBytes!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // ================= TITLE =================
            TextField(
              controller: titleController,

              enabled: !provider.isLoading,

              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // ================= DESCRIPTION =================
            TextField(
              controller: descriptionController,

              enabled: !provider.isLoading,

              maxLines: 4,

              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            // ================= PRICE =================
            TextField(
              controller: priceController,

              enabled: !provider.isLoading,

              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: const InputDecoration(
                labelText: "Price",
                prefixText: "Rs. ",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductListScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Text("Next"),
              ),
            ),
            // ================= ADD BUTTON =================
            SizedBox(
              height: 50,

              child: ElevatedButton(
                onPressed: provider.isLoading ? null : addProduct,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                child: provider.isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,

                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Add Product",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
