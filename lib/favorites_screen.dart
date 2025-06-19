import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();

  // Static favorites list
  static List<Map<String, dynamic>> favorites = [];
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // No arguments needed here, favorites are managed from HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: FavoritesScreen.favorites.isEmpty
            ? Center(
          child: Text(
            'No favorite items yet',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
            : ListView.builder(
          itemCount: FavoritesScreen.favorites.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset(FavoritesScreen.favorites[index]['image'], width: 50, height: 50),
              title: Text(FavoritesScreen.favorites[index]['name'], style: TextStyle(color: Colors.white)),
              subtitle: Text('\$${FavoritesScreen.favorites[index]['price']}', style: TextStyle(color: Colors.blue)),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () {
                  setState(() {
                    FavoritesScreen.favorites.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}