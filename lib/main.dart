import 'package:coffee_shop/providers/products_provider.dart';
import 'package:coffee_shop/providers/drinks_provider.dart';

import 'package:coffee_shop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrinksProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'juice_shop',
      home: HomeScreen(),
    );
  }
}
