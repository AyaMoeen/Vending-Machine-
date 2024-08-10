// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/button_design.dart';
import 'package:project/payment.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Product> products = [
    Product(
        name: 'Orange Juice',
        price: 4.0,
        quantity: 1,
        imagePath: 'images/icon/orange.jpg'),
    Product(
        name: 'Mr Chips',
        price: 3.0,
        quantity: 1,
        imagePath: 'images/icon/chips.jpg'),
    Product(
        name: 'Milk Chocolate',
        price: 2.0,
        quantity: 1,
        imagePath: 'images/icon/milk.jpg'),
    // Add more products here
  ];

  bool selectAll = false;
  double totalAmount = 0.0;

  void updateTotalAmount() {
    totalAmount = products
        .where((product) => product.isSelected)
        .fold(0.0, (sum, product) => sum + (product.price * product.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Vending Machine',
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 150, 62, 7),
                fontSize: 20,
                decorationThickness: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: selectAll,
                  activeColor: Color.fromARGB(255, 150, 62, 7),
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      selectAll = value!;
                      for (var product in products) {
                        product.isSelected = selectAll;
                      }
                      updateTotalAmount();
                    });
                  },
                ),
                Text(
                  'All',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 28, 28, 28),
                      fontSize: 15,
                      decorationThickness: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  '\₪ ${totalAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 28, 28, 28),
                      fontSize: 15,
                      decorationThickness: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CustomeButton2(
                  text: 'Order',
                  onPressed: () async {
                    try {
                      Payment.makePayment(context, totalAmount);
                      print('Payment sheet initialized successfully.');
                    } catch (e) {
                      print('Error initializing payment sheet: $e');
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: products[index].isSelected,
                        activeColor: Color.fromARGB(255, 150, 62, 7),
                        checkColor: Colors.white,
                        onChanged: (value) {
                          setState(() {
                            products[index].isSelected = value!;
                            if (!value) {
                              selectAll = false;
                            } else if (products
                                .every((product) => product.isSelected)) {
                              selectAll = true;
                            }
                            updateTotalAmount();
                          });
                        },
                      ),
                      Image.asset(
                        products[index].imagePath,
                        width: 50,
                        height: 50,
                      ),
                    ],
                  ),
                  title: Text(
                    products[index].name,
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 28, 28, 28),
                        fontSize: 15,
                        decorationThickness: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'Price: ₪ ${products[index].price}\nQuantity: ${products[index].quantity}',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        fontSize: 12,
                        decorationThickness: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (products[index].quantity > 1) {
                              products[index].quantity--;
                              updateTotalAmount();
                            }
                          });
                        },
                      ),
                      Text(
                        '${products[index].quantity}',
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 28, 28, 28),
                            fontSize: 13,
                            decorationThickness: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            products[index].quantity++;
                            updateTotalAmount();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/*
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
 List<Product> products = [
  Product(name: 'Orange Juice', price: 4.0, quantity: 1, imagePath: 'images/icon/orange_juice.png'),
  Product(name: 'Mr Chips', price: 3.0, quantity: 1, imagePath: 'images/icon/mr_chips.png'),
  Product(name: 'Milk Chocolate', price: 2.0, quantity: 1, imagePath: 'images/icon/milk_chocolate.png'),
  // Add more products here
];


  bool selectAll = false;
  double totalAmount = 0.0;

  void updateTotalAmount() {
    totalAmount = products
        .where((product) => product.isSelected)
        .fold(0.0, (sum, product) => sum + (product.price * product.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Vending Machine',
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 150, 62, 7),
                fontSize: 20,

                decorationThickness: 1,
                fontWeight: FontWeight.bold,
                //padding: 10,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: selectAll,
                  activeColor: Color.fromARGB(255, 150, 62, 7),
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      selectAll = value!;
                      for (var product in products) {
                        product.isSelected = selectAll;
                      }
                      updateTotalAmount();
                    });
                  },
                ),
                Text(
                  'All',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 28, 28, 28),
                      fontSize: 15,

                      decorationThickness: 1,
                      fontWeight: FontWeight.bold,
                      //padding: 10,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  '\₪ ${totalAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 28, 28, 28),
                      fontSize: 15,

                      decorationThickness: 1,
                      fontWeight: FontWeight.bold,
                      //padding: 10,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CustomeButton2(
                  text: 'Order',
                  onPressed: () async {
                    try {
                      Payment.makePayment(context,
                          totalAmount); 
                      print('Payment sheet initialized successfully.');
                    } catch (e) {
                      print('Error initializing payment sheet: $e');
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: products[index].isSelected,
                    activeColor: Color.fromARGB(255, 150, 62, 7),
                    checkColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        products[index].isSelected = value!;
                        if (!value) {
                          selectAll = false;
                        } else if (products
                            .every((product) => product.isSelected)) {
                          selectAll = true;
                        }
                        updateTotalAmount();
                      });
                    },
                  ),
                  title: Text(
                    products[index].name,
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 28, 28, 28),
                        fontSize: 15,

                        decorationThickness: 1,
                        fontWeight: FontWeight.bold,
                        //padding: 10,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    'Price: ₪ ${products[index].price}\nQuantity: ${products[index].quantity}',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                     
                        fontSize: 12,

                        decorationThickness: 1,
                        fontWeight: FontWeight.bold,
                        //padding: 10,
                      ),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (products[index].quantity > 1) {
                              products[index].quantity--;
                              updateTotalAmount();
                            }
                          });
                        },
                      ),
                      Text(
                        '${products[index].quantity}',
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            color: Color.fromARGB(255, 28, 28, 28),
                            fontSize: 13,

                            decorationThickness: 1,
                            fontWeight: FontWeight.bold,
                        
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            products[index].quantity++;
                            updateTotalAmount();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/
class Product {
  String name;
  double price;
  int quantity;
  bool isSelected;
  String imagePath;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
    this.isSelected = false,
    required this.imagePath,
  });
}
