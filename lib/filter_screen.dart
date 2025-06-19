import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const FilterScreen({required this.products});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late List<Map<String, dynamic>> filteredProducts;
  String? selectedCategory;
  double minPrice = 0.0;
  double maxPrice = 500.0;
  String? selectedQuality;

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(widget.products);
    print('FilterScreen init: Initial products count = ${filteredProducts.length}');
  }

  void _applyFilters() {
    setState(() {
      filteredProducts = widget.products.where((product) {
        final matchesCategory = selectedCategory == null || product['category'] == selectedCategory;
        final matchesPrice = product['price'] >= minPrice && product['price'] <= maxPrice;
        final matchesQuality = selectedQuality == null || (product['quality'] ?? 'Medium') == selectedQuality;
        print('Filtering ${product['name']}: Category=$matchesCategory, Price=$matchesPrice, Quality=$matchesQuality');
        return matchesCategory && matchesPrice && matchesQuality;
      }).toList();
      print('FilterScreen: Filtered products count = ${filteredProducts.length}, Names = ${filteredProducts.map((p) => p['name']).join(', ')}');
    });
  }

  void _saveAndReturn() {
    _applyFilters();
    print('FilterScreen: Returning filtered products count = ${filteredProducts.length}');
    Navigator.pop(context, filteredProducts.isNotEmpty ? filteredProducts : widget.products); // Fallback to all products if empty
  }

  void _resetFilters() {
    setState(() {
      selectedCategory = null;
      minPrice = 0.0;
      maxPrice = 500.0;
      selectedQuality = null;
      filteredProducts = List.from(widget.products);
      print('FilterScreen: Reset to initial products count = ${filteredProducts.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[700],
        actions: [
          TextButton(
            onPressed: _saveAndReturn,
            child: Text('Apply', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category', style: TextStyle(color: Colors.white, fontSize: 18)),
              DropdownButton<String>(
                value: selectedCategory,
                hint: Text('All Categories', style: TextStyle(color: Colors.white70)),
                items: ['All', 'Shoes', 'Clothes', 'Watches']
                    .map((category) => DropdownMenuItem(
                  value: category == 'All' ? null : category,
                  child: Text(category, style: TextStyle(color: Colors.white)),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                dropdownColor: Colors.grey[800],
                style: TextStyle(color: Colors.white),
                underline: Container(color: Colors.white70, height: 1),
              ),
              SizedBox(height: 20),
              Text('Price Range', style: TextStyle(color: Colors.white, fontSize: 18)),
              RangeSlider(
                values: RangeValues(minPrice, maxPrice),
                min: 0.0,
                max: 500.0,
                divisions: 50,
                labels: RangeLabels(
                  '\$${minPrice.toStringAsFixed(2)}',
                  '\$${maxPrice.toStringAsFixed(2)}',
                ),
                onChanged: (values) {
                  setState(() {
                    minPrice = values.start;
                    maxPrice = values.end;
                  });
                },
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
              ),
              SizedBox(height: 20),
              Text('Quality', style: TextStyle(color: Colors.white, fontSize: 18)),
              DropdownButton<String>(
                value: selectedQuality,
                hint: Text('Select Quality', style: TextStyle(color: Colors.white70)),
                items: ['All', 'Low', 'Medium', 'High']
                    .map((quality) => DropdownMenuItem(
                  value: quality == 'All' ? null : quality,
                  child: Text(quality, style: TextStyle(color: Colors.white)),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedQuality = value;
                  });
                },
                dropdownColor: Colors.grey[800],
                style: TextStyle(color: Colors.white),
                underline: Container(color: Colors.white70, height: 1),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _resetFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    child: Text('Reset', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: _saveAndReturn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    child: Text('Apply Filters', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}