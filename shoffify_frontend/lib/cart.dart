import 'package:flutter/material.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/profile.dart';
import 'package:myntra/order.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:myntra/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:myntra/connections.dart' as connect;

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Cart",
            style: TextStyle(color: Color.fromARGB(255, 68, 79, 16)),
          ),
          backgroundColor: const Color.fromARGB(255, 181,192,124),
          foregroundColor: Color.fromARGB(255, 68, 79, 16),
          leading: BackButton(),
          actions: [
            Icon(Icons.search),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            ),
            Consumer<ProductProvider>(builder: (context, provider, child) {
              return InkWell(
                  onTap: () async {
                    var cartProd = await connect.fetchCart();
                    provider.setCart(cartProd);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => Cart()));
                  },
                  child: Icon(
                    Icons.shopping_bag,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ));
            })
          ]),
      body: Consumer<ProductProvider>(builder: (context, provider, index) {
        if (provider.cartData.isEmpty) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 298.0),
            child: Column(
              children: [
                Icon(Icons.shopping_bag),
                Text(
                  "Empty Cart :(",
                  style: TextStyle(fontSize: 28),
                )
              ],
            ),
          ));
        }
        return Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.82,
                width: 400,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: provider.cartData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: const Color.fromARGB(187, 63, 70, 27)))),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: SizedBox(
                                      height: 300,
                                      width: 120,
                                      child: Image.network(
                                          "${connect.mediaUrl}/${provider.cartData[index]['fields']['image_path']}"),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: SizedBox(
                                    width: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${provider.cartData[index]['fields']['name']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        SizedBox(
                                          child: Text(
                                            '${provider.cartData[index]['fields']['product_desc']}',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                            'Rs.${provider.cartData[index]['fields']['product_price']}/-',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await provider.removeFromCart(
                                            provider.cartData[index]['pk']);
                                        var cartProd =
                                            await connect.fetchCart();
                                        provider.setCart(cartProd);
                                        
                                      },
                                      child: Icon(Icons.delete_outline_rounded, color: Color.fromARGB(255, 127, 137, 74),),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ));
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total Price: Rs ${provider.totalPrice}/-",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => orderWidget()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                        
                           color: Color.fromARGB(255, 115, 122, 79),
                                      borderRadius: BorderRadius.circular(30)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                                                "Buy Now",
                                                                style:
                                                                    TextStyle(color: Color.fromARGB(255, 255, 255, 255),),
                                                              ),
                                      ),
                        ),
                        
                      ),
                ],
              ),
              // SizedBox(
              //   height: 50,
              // )
            ],
          ),
        );
      }),
    );
  }
}
