import 'dart:convert';
import 'dart:ui';
// import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/modals/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= CLOUDINARY =================
  final String cloudName = dotenv.env["CLOUD_NAME"]!;
  final String uploadPreset = 'flutter_coffee_test';

  // ================= STATE =================

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _error;

  String? get error => _error;

  // ================= PRODUCTS =================

  final List<ProductsModel> _products = [];

  List<ProductsModel> get products => _products;

  // ================= CLOUDINARY UPLOAD =================

  Future<String> uploadImageToCloudinary(XFile image) async {
    final Uri url = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', url);

    request.fields['upload_preset'] = uploadPreset;

    final Uint8List bytes = await image.readAsBytes();

    request.files.add(
      http.MultipartFile.fromBytes('file', bytes, filename: image.name),
    );

    final response = await request.send();

    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(responseBody);

      return data['secure_url'];
    }

    throw Exception('Cloudinary upload failed: $responseBody');
  }

  // ================= ADD PRODUCT =================

  Future<bool> addProduct({
    required XFile image,
    required String title,
    required String description,
    required double price,
    Color topBackgroundColor = const Color(0xff8c3332),
    Color bottomBackgroundColor = const Color(0xFFFFFFFF),
    Color buttonColor = const Color(0xff8c3332),
    Color textColor = const Color(0xFF000000),
    double rating = 5.0,
    String type = '',
  }) async {
    try {
      // Start loading
      _isLoading = true;
      _error = null;

      notifyListeners();

      // 1. Upload image to Cloudinary
      final String imageUrl = await uploadImageToCloudinary(image);

      // 2. Create product model
      final ProductsModel product = ProductsModel(
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
        topBackgroundColor: topBackgroundColor,
        bottomBackgroundColor: bottomBackgroundColor,
        buttonColor: buttonColor,
        textColor: textColor,
        rating: rating,
        type: type,
      );

      // 3. Save product to Firestore
      await _firestore.collection('products').add(product.toMap());

      return true;
    } catch (e) {
      _error = e.toString();

      debugPrint('Add Product Error: $_error');

      return false;
    } finally {
      // Stop loading
      _isLoading = false;

      notifyListeners();
    }
  }

  Stream<List<ProductsModel>> fetchProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductsModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
