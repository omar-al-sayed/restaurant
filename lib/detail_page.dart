import 'package:flutter/material.dart';
import 'receipt_page.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> selectedItem;

  DetailPage(this.selectedItem);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedSize = 'Regular';
  Set<String> removedIngredients = {};
  Set<String> selectedExtras = {};

  double calculateTotalPrice() {
    double basePrice = widget.selectedItem['price'];
    double sizePriceAdjustment = selectedSize == 'Large' ? 2.00 : 0.00;
    double totalPrice = basePrice + sizePriceAdjustment;

    // Add extra charge for selected extras
    for (String extra in selectedExtras) {
      totalPrice += 1.50;
    }

    return totalPrice;
  }

  List<String> getRemoveIngredientsOptions() {
    // Dynamically return removeIngredientsOptions based on the chosen item
    switch (widget.selectedItem['name']) {
      case 'Burger':
        return ['Pickles', 'Onions', 'Tomatoes'];
      case 'Pizza':
        return ['Olives', 'Mushrooms', 'Peppers'];
      case 'Salad':
        return ['Croutons', 'Cheese', 'Dressing'];
      default:
        return [];
    }
  }

  List<String> getExtraOptions() {
    // Dynamically return extraOptions based on the chosen item
    switch (widget.selectedItem['name']) {
      case 'Burger':
        return ['Cheddar Cheese', 'Bacon', 'Avocado'];
      case 'Pizza':
        return ['Extra Cheese', 'Pepperoni', 'Sausage'];
      case 'Salad':
        return ['Grilled Chicken', 'Shrimp', 'Feta Cheese'];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> removeIngredientsOptions = getRemoveIngredientsOptions();
    List<String> extraOptions = getExtraOptions();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedItem['name']),
      ),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio(
                  value: 'Large',
                  groupValue: selectedSize,
                  onChanged: (value) {
                    setState(() {

                      selectedSize = value.toString();
                    });
                  },
                ),
                Text('Large Size'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 'Regular',
                  groupValue: selectedSize,
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value.toString();
                    });
                  },
                ),
                Text('Regular Size'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Remove Ingredients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            buildCheckboxList(removeIngredientsOptions, removedIngredients),
            SizedBox(height: 20),
            Text(
              'Extra',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            buildCheckboxList(extraOptions, selectedExtras),
            SizedBox(height: 20),
            Text(
              'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to receipt page with order details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptPage(
                      selectedItem: widget.selectedItem,
                      selectedSize: selectedSize,
                      removedIngredients: removedIngredients,
                      selectedExtras: selectedExtras,
                    ),
                  ),
                );
              },
              child: Text('View Receipt'),)
          ],
        ),
      ),
    );
  }

  Widget buildCheckboxList(List<String> options, Set<String> selectedSet) {
    return Column(
      children: options.map((option) {
        return Row(
          children: [
            Checkbox(
              value: selectedSet.contains(option),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    selectedSet.add(option);
                  } else {
                    selectedSet.remove(option);
                  }
                });
              },
            ),
            Text(option),
          ],
        );
      }).toList(),
    );
  }
}
