import 'package:flutter/material.dart';

void main() {
  runApp(BeautyEcommerceApp());
}

class BeautyEcommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beauty E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          bodySmall: TextStyle(fontFamily: 'Poppins'),
          titleLarge: TextStyle(fontFamily: 'Poppins'),
          titleMedium: TextStyle(fontFamily: 'Poppins'),
          titleSmall: TextStyle(fontFamily: 'Poppins'),
          labelLarge: TextStyle(fontFamily: 'Poppins'),
          labelMedium: TextStyle(fontFamily: 'Poppins'),
          labelSmall: TextStyle(fontFamily: 'Poppins'),
        ),
        colorScheme: ColorScheme.light(
          primary: Color(0xFFB2C7E4), // Pastel Blue
          secondary: Color(0xFFFFFFFF), // White
        ),
        scaffoldBackgroundColor: Color(0xFFFFFFFF), // White
      ),
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatelessWidget {
  final List<Map<String, String>> products = [
    {"name": "Glow Tint", "image": "images/gambar1.png", "price": "Rp50.000"},
    {"name": "Cushion", "image": "images/gambar2.png", "price": "Rp200.000"},
    {"name": "Mascara", "image": "images/gambar3.png", "price": "Rp60.000"},
    {"name": "Blush Balm", "image": "images/gambar4.png", "price": "Rp55.000"},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beauty Products', style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Card(
              color: Theme.of(context).colorScheme.secondary,
              child: ListTile(
                leading: Image.asset(
                  products[index]['image']!,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error, color: Colors.red),
                ),
                title: Text(
                  products[index]['name']!,
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                subtitle: Text(
                  products[index]['price']!,
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailPage(product: products[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  final Map<String, String> product;

  ProductDetailPage({required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product['name']!, style: TextStyle(fontFamily: 'Poppins')),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.product['image']!,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, size: 100, color: Colors.red),
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.product['name']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
            ),
            SizedBox(height: 10),
            Text(
              'Price: ${widget.product['price']}',
              style: TextStyle(fontSize: 18, color: Colors.grey[700], fontFamily: 'Poppins'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                    ),
                    Text(
                      quantity.toString(),
                      style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(vertical: 12), // Add padding for better appearance
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Success!', style: TextStyle(fontFamily: 'Poppins')),
                        content: Text('Added to cart!', style: TextStyle(fontFamily: 'Poppins')),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('OK', style: TextStyle(fontFamily: 'Poppins')),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the content
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.white),
                      SizedBox(width: 10), // Add space between icon and text
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white, // Ensure the text is white
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
