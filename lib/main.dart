import 'package:ecommerce/search_screen.dart';
import 'package:flutter/material.dart';
import 'filter_screen.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart'; // Import your existing file
import 'forgot_password_screen.dart'; // Import your existing file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe Store',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/cart': (context) => CartScreen(),
        '/favorites': (context) => FavoritesScreen(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
        '/about': (context) => AboutScreen(),
        '/register': (context) => RegisterScreen(), // Map to your existing RegisterScreen
        '/forgot_password': (context) => ForgotPasswordScreen(),
        '/search': (context) => SearchScreen(),
        '/filter': (context) => FilterScreen(products: []),// Map to your existing ForgotPasswordScreen
        // Add other routes like /search, /filter if needed
      },
    );
  }
}

// Placeholder screens (keep these if you have separate implementations elsewhere)
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: Text('Profile Page')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Page')),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Center(child: Text('About Page')),
    );
  }
}