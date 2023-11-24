import 'package:flutter/material.dart';
import 'detail_page.dart';
class Restaurant extends StatefulWidget {
  const Restaurant({Key? key}) : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Burger', 'price': 8.99, 'image': 'assets/burger.jpg'},
    {'name': 'Pizza', 'price': 12.99, 'image': 'assets/pizza.jpg'},
    {'name': 'Salad', 'price': 6.99, 'image': 'assets/salad.jpg'},
  ];


  String selectedItem = 'Burger';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: selectedItem,
              items: menuItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item['name'],
                  child: Text(item['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Find the selected item's details
                var selectedMenuItem = menuItems.firstWhere(
                      (item) => item['name'] == selectedItem,
                  orElse: () => {'name': '', 'price': 0, 'image': ''},
                );

                // Navigate to another page with detailed information
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(selectedMenuItem),
                  ),
                );
              },
              child: Text('View Details'),
            ),
            SizedBox(height: 20),
            Expanded(
              //list view
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text('\$${item['price']}'),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(item['image']),
                      ),
                      onTap: () {
                        setState(() {
                          selectedItem = item['name'];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}