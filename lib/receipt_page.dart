import 'package:flutter/material.dart';
import 'package:restaurant/restaurant.dart';

class ReceiptPage extends StatelessWidget {
  final Map<String, dynamic> selectedItem;
  final String selectedSize;
  final Set<String> removedIngredients;
  final Set<String> selectedExtras;

  ReceiptPage({
    required this.selectedItem,
    required this.selectedSize,
    required this.removedIngredients,
    required this.selectedExtras,
  });

  double calculateTotalPrice() {
    double basePrice = selectedItem['price'];
    double sizePriceAdjustment = selectedSize == 'Large' ? 2.00 : 0.00;
    double totalPrice = basePrice + sizePriceAdjustment;

    // Add extra charge for selected extras
    for (String extra in selectedExtras) {
      // Adjust the extra charge according to your needs
      totalPrice += 1.50;
    }

    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item: ${selectedItem['name']}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Size: $selectedSize'),
            Text('Removed Ingredients: ${removedIngredients.join(', ')}'),
            Text('Selected Extras: ${selectedExtras.join(', ')}'),
            SizedBox(height: 20),
            Center(child: Image.asset(
              selectedItem['image'],
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            )),
            SizedBox(height: 20),
            Text(
              'Final Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(child :ElevatedButton(
              onPressed: () {
                // Navigate to the Restaurant page to start a new order
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Restaurant()),
                      (route) => false,
                );
              },
              child: Text('New Order'),
            ),)
          ],
        ),
      ),
    );
  }
}