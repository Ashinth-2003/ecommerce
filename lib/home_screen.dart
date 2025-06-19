import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'cart_screen.dart';
import 'favorites_screen.dart';
import 'filter_screen.dart'; // Import FilterScreen
import 'search_screen.dart'; // Import SearchScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> allProducts = [
    {'name': 'Sports Shoe', 'price': 125.00, 'image': 'assets/images/shoe1.png', 'category': 'Shoes', 'quality': 'Medium'},
    {'name': 'Formal Shoe', 'price': 130.00, 'image': 'assets/images/shoe2.png', 'category': 'Shoes', 'quality': 'High'},
    {'name': 'Casual Shoe', 'price': 150.00, 'image': 'assets/images/shoe3.jpg', 'category': 'Shoes', 'quality': 'Low'},
    {'name': 'Sneakers', 'price': 115.00, 'image': 'assets/images/shoe4.png', 'category': 'Shoes', 'quality': 'Medium'},
    {'name': 'Trendy Jacket', 'price': 89.99, 'image': 'assets/images/trendyjacket.jpg', 'category': 'Clothes', 'quality': 'High'},
    {'name': 'Casual Shirt', 'price': 45.00, 'image': 'assets/images/casualshirt.jpg', 'category': 'Clothes', 'quality': 'Low'},
    {'name': 'Smart Watch', 'price': 199.99, 'image': 'assets/images/smartwatch.jpg', 'category': 'Watches', 'quality': 'High'},
    {'name': 'Casual Watch', 'price': 79.99, 'image': 'assets/images/casualwatch.jpg', 'category': 'Watches', 'quality': 'Medium'},
  ];
  List<Map<String, dynamic>> displayedProducts = []; // Will hold filtered or tab-filtered products
  final List<String> slideImages = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
    'assets/images/banner4.png',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    displayedProducts = List.from(allProducts); // Initialize with all products
    print('HomeScreen init: Initial displayedProducts count = ${displayedProducts.length}');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> getFilteredProducts(String category) {
    if (category == 'All') return displayedProducts; // Use displayedProducts to reflect filters
    return displayedProducts.where((product) => product['category'] == category).toList();
  }

  void _navigateToFilter() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(products: allProducts),
        fullscreenDialog: true,
      ),
    ).then((value) {
      print('HomeScreen: Received value type = ${value.runtimeType}');
      if (value != null && value is List<Map<String, dynamic>>) {
        print('HomeScreen: Received filtered products count = ${value.length}, Names = ${value.map((p) => p['name']).join(', ')}');
        setState(() {
          displayedProducts = value;
          print('HomeScreen: Updated displayedProducts count = ${displayedProducts.length}');
        });
      } else {
        print('HomeScreen: No valid data returned, reverting to all products');
        setState(() {
          displayedProducts = List.from(allProducts);
        });
      }
    });
  }

  void _navigateToSearch() {
    Navigator.pushNamed(context, '/search').then((value) {
      if (value != null && value is List<Map<String, dynamic>>) {
        print('HomeScreen: Received search results count = ${value.length}');
        setState(() {
          displayedProducts = value;
          print('HomeScreen: Updated displayedProducts count after search = ${displayedProducts.length}');
        });
      } else {
        print('HomeScreen: No valid search data returned');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trendy Store', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[350]!, Colors.grey[300]!, Colors.grey[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: _navigateToSearch),
          IconButton(icon: Icon(Icons.filter_list), onPressed: _navigateToFilter),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () => Navigator.pushNamed(context, '/cart')),
          IconButton(icon: Icon(Icons.favorite), onPressed: () => Navigator.pushNamed(context, '/favorites')),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blue,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black54,
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Shoes'),
            Tab(text: 'Clothes'),
            Tab(text: 'Watches'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.black87),
              title: Text('Profile', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black87),
              title: Text('Settings', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.black87),
              title: Text('About', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: slideImages.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ).animate().fadeIn(duration: 500.ms).slideY(duration: 500.ms, begin: -1.0, end: 0.0);
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('Products', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black))
                  .animate()
                  .slideX(duration: 600.ms, begin: -1.0, end: 0.0)
                  .fadeIn(duration: 600.ms),
              SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // All tab
                    NotificationListener<ScrollNotification>(
                      onNotification: (_) => true,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: getFilteredProducts('All').length,
                        itemBuilder: (context, index) {
                          final product = getFilteredProducts('All')[index];
                          return Card(
                            color: Colors.white.withOpacity(0.9),
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      product['image'],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        product['name'],
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '\$${product['price'].toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.blue, fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.shopping_cart, color: Colors.green),
                                            onPressed: () {
                                              CartScreen.cartItems.add(product);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('${product['name']} added to cart!')),
                                              );
                                            },
                                            tooltip: 'Add to Cart',
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.favorite_border, color: Colors.red),
                                            onPressed: () {
                                              if (!FavoritesScreen.favorites.contains(product)) {
                                                FavoritesScreen.favorites.add(product);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('${product['name']} added to favorites!')),
                                                );
                                              }
                                            },
                                            tooltip: 'Add to Favorites',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .scale(duration: 500.ms, begin: Offset(0.9, 0.9), end: Offset(1.0, 1.0))
                              .fadeIn(duration: 500.ms);
                        },
                      ),
                    ),
                    // Shoes tab
                    NotificationListener<ScrollNotification>(
                      onNotification: (_) => true,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: getFilteredProducts('Shoes').length,
                        itemBuilder: (context, index) {
                          final product = getFilteredProducts('Shoes')[index];
                          return Card(
                            color: Colors.white.withOpacity(0.9),
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      product['image'],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        product['name'],
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '\$${product['price'].toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.blue, fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.shopping_cart, color: Colors.green),
                                            onPressed: () {
                                              CartScreen.cartItems.add(product);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('${product['name']} added to cart!')),
                                              );
                                            },
                                            tooltip: 'Add to Cart',
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.favorite_border, color: Colors.red),
                                            onPressed: () {
                                              if (!FavoritesScreen.favorites.contains(product)) {
                                                FavoritesScreen.favorites.add(product);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('${product['name']} added to favorites!')),
                                                );
                                              }
                                            },
                                            tooltip: 'Add to Favorites',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .scale(duration: 500.ms, begin: Offset(0.9, 0.9), end: Offset(1.0, 1.0))
                              .fadeIn(duration: 500.ms);
                        },
                      ),
                    ),
                    // Clothes tab
                    NotificationListener<ScrollNotification>(
                      onNotification: (_) => true,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: getFilteredProducts('Clothes').length,
                        itemBuilder: (context, index) {
                          final product = getFilteredProducts('Clothes')[index];
                          return Card(
                            color: Colors.white.withOpacity(0.9),
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      product['image'],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        product['name'],
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '\$${product['price'].toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.blue, fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.shopping_cart, color: Colors.green),
                                            onPressed: () {
                                              CartScreen.cartItems.add(product);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('${product['name']} added to cart!')),
                                              );
                                            },
                                            tooltip: 'Add to Cart',
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.favorite_border, color: Colors.red),
                                            onPressed: () {
                                              if (!FavoritesScreen.favorites.contains(product)) {
                                                FavoritesScreen.favorites.add(product);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('${product['name']} added to favorites!')),
                                                );
                                              }
                                            },
                                            tooltip: 'Add to Favorites',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .scale(duration: 500.ms, begin: Offset(0.9, 0.9), end: Offset(1.0, 1.0))
                              .fadeIn(duration: 500.ms);
                        },
                      ),
                    ),
                    // Watches tab
                    NotificationListener<ScrollNotification>(
                      onNotification: (_) => true,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: getFilteredProducts('Watches').length,
                        itemBuilder: (context, index) {
                          final product = getFilteredProducts('Watches')[index];
                          return Card(
                            color: Colors.white.withOpacity(0.9),
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      product['image'],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        product['name'],
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '\$${product['price'].toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.blue, fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.shopping_cart, color: Colors.green),
                                            onPressed: () {
                                              CartScreen.cartItems.add(product);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('${product['name']} added to cart!')),
                                              );
                                            },
                                            tooltip: 'Add to Cart',
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.favorite_border, color: Colors.red),
                                            onPressed: () {
                                              if (!FavoritesScreen.favorites.contains(product)) {
                                                FavoritesScreen.favorites.add(product);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('${product['name']} added to favorites!')),
                                                );
                                              }
                                            },
                                            tooltip: 'Add to Favorites',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .scale(duration: 500.ms, begin: Offset(0.9, 0.9), end: Offset(1.0, 1.0))
                              .fadeIn(duration: 500.ms);
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