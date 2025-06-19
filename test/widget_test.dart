import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce/main.dart'; // Ensure this points to your main.dart

void main() {
  testWidgets('ShoeStoreApp HomeScreen renders correctly', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the AppBar title 'Shoe Store' is displayed.
    expect(find.text('Shoe Store'), findsOneWidget);

    // Verify that the 'Trending Now' section is displayed.
    expect(find.text('Trending Now'), findsOneWidget);

    // Verify that the first product 'Sneaker 1' is displayed.
    expect(find.text('Sneaker 1'), findsOneWidget);

    // Verify that the search icon button is present.
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Tap the search icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Verify that the SearchScreen is displayed by checking for 'Search' in the AppBar.
    expect(find.text('Search'), findsOneWidget);
  });
}