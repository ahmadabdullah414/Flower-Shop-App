import 'package:flower/Authentication/signin.dart';
import 'package:flower/Listings/rating.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

class ListingPage extends StatefulWidget {
  const ListingPage({super.key});

  @override
  State<ListingPage> createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  List<Product> products = [
    Product(name: "Rose", price: 2.99, image: "assets/rose.jpg"),
    Product(name: "Tulip", price: 3.49, image: "assets/tulip.jpg"),
    Product(name: "Sunflower", price: 1.99, image: "assets/sunflower.jpg"),
    Product(name: "Daisy", price: 1.49, image: "assets/daisy.jpg"),
    Product(name: "Lily", price: 1.52, image: "assets/lily.jpg"),
    Product(name: "Aster", price: 3.49, image: "assets/aster.jpg"),
  ];

  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Product product) {
    setState(() {
      int index = cartItems.indexWhere((item) => item['name'] == product.name);
      if (index >= 0) {
        cartItems[index]['quantity']++;
      } else {
        cartItems.add({
          'name': product.name,
          'price': product.price,
          'image': product.image,
          'quantity': 1,
        });
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.name} added to cart!"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          cartItems: cartItems,
          onQuantityChange: (index, delta) {
            setState(() {
              cartItems[index]['quantity'] += delta;
              if (cartItems[index]['quantity'] <= 0) {
                cartItems.removeAt(index);
              }
            });
          },
        ),
      ),
    );
  }

  void openPopupMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(0, kToolbarHeight + 20, 0, 0),
      color: Colors.black, // Black background color
      items: [
        const PopupMenuItem<String>(
          value: 'list',
          child: Text(
            'List',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'rating',
          child: Text(
            'Ratings',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.amber),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'log out',
          child: Text(
            'Log Out',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.amber),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'list') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ListingPage()));
      } else if (value == 'rating') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Rating()));
      } else if (value == 'log out') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Signin()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          children: [
            IconButton(
              icon:
                  const Icon(Icons.menu, color: Colors.amber), // Hamburger icon
              onPressed: openPopupMenu,
            ),
            const Text(
              "Flowers List",
              style:
                  TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.amber),
            onPressed: navigateToCart,
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Europe Flowers',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 3 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.of(context).size.width > 600 ? 0.8 : 0.75,
                    ),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(context, product);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Asian Flowers',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 3 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.of(context).size.width > 600 ? 0.8 : 0.75,
                    ),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      final product = products[index + 2];
                      return _buildProductCard(context, product);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'African Flowers',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.amber),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 3 : 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio:
                          MediaQuery.of(context).size.width > 600 ? 0.8 : 0.75,
                    ),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      final product = products[index + 4];
                      return _buildProductCard(context, product);
                    },
                  ),
                ],
              ),
            ),
            const Text(
              'If 10 pieces are bought you get a free bucket',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.amber),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return SizedBox(
      height: MediaQuery.of(context).size.width > 600 ? 400 : 350,
      child: Card(
        color: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              product.name,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600 ? 20 : 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.image,
                height: MediaQuery.of(context).size.width > 600 ? 150 : 130,
                width: MediaQuery.of(context).size.width > 600 ? 150 : 130,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600 ? 20 : 16,
                fontWeight: FontWeight.w400,
                color: Colors.amber,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => addToCart(product),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              ),
              icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
              label: const Text(
                "Add to Cart",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final void Function(int index, int delta) onQuantityChange;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = cartItems.fold(
        0.0, (prev, item) => prev + (item['price'] * item['quantity']));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
        title: const Text("Cart",
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty!",
                style: TextStyle(color: Colors.amber, fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Column(
                        children: [
                          Card(
                            color: Colors.black54,
                            margin: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  item['image'],
                                  height:
                                      MediaQuery.of(context).size.width > 600
                                          ? 70
                                          : 50,
                                  width: MediaQuery.of(context).size.width > 600
                                      ? 70
                                      : 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                item['name'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                "\$${item['price'].toStringAsFixed(2)} x ${item['quantity']}",
                                style: TextStyle(color: Colors.amber),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.amber),
                                onPressed: () {
                                  cartItems.removeAt(index);
                                },
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.width > 600 ? 20 : 18,
                        color: Colors.amber),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Proceed to checkout or order functionality
                  },
                  child: const Text(
                    'Checkout',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
              ],
            ),
    );
  }
}
