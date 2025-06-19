import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();

  // Static cart items list
  static List<Map<String, dynamic>> cartItems = [];
}

class _CartScreenState extends State<CartScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final product = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (product != null && !CartScreen.cartItems.contains(product)) {
      setState(() {
        CartScreen.cartItems.add(product);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.white)),
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
        child: CartScreen.cartItems.isEmpty
            ? Center(
          child: Text(
            'Your cart is empty',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
            : ListView.builder(
          itemCount: CartScreen.cartItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset(CartScreen.cartItems[index]['image'], width: 50, height: 50),
              title: Text(CartScreen.cartItems[index]['name'], style: TextStyle(color: Colors.white)),
              subtitle: Text('\$${CartScreen.cartItems[index]['price']}', style: TextStyle(color: Colors.blue)),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () {
                  setState(() {
                    CartScreen.cartItems.removeAt(index);
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