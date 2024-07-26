import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myntra/cart.dart';
import 'package:myntra/components/custom_appbar.dart';
import 'package:myntra/components/custom_navbar.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/profile.dart';
import 'package:myntra/order.dart';
import 'package:myntra/connections.dart' as connect;
import 'package:myntra/providers/productproviders.dart';
import 'package:myntra/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:myntra/connections.dart';

class productWidget extends StatefulWidget {
  const productWidget({super.key});

  @override
  State<productWidget> createState() => _productWidgetState();
}

class _productWidgetState extends State<productWidget> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context),
      body: SingleChildScrollView(
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Container(
                      width: 240,
                      child: Image.network(
                          "${connect.mediaUrl}/${provider.singleProduct['fields']['image_path']}"),
                    )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${provider.singleProduct['fields']['name']}",
                                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                                
                                InkWell(
                                  
                                  onTap: () async{
                                        var addprod = await connect.add_to_wishlist(provider.singleProduct['pk']);
                                        Fluttertoast.showToast(msg: '$addprod');
                                        
                                        print( ' wisjlistNew prod ${provider.singleProduct}');
                         
                    },
                                  child: Icon(
                                    Icons.favorite_border, color: Color.fromARGB(255, 115, 122, 79),size: 35,),
                                ),
                                
                                

                              ],
                            ),
                             Text("${provider.singleProduct['fields']['product_desc']}",
                                style: TextStyle(fontSize: 18)),
                         
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18.0),
                              child: Row(
                                children: [
                                   Text(
                                    "MRP ${provider.singleProduct['fields']['product_price']}/-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 80.0),
                                    child: const Text(
                                      "Only Few Left",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 76, 170, 88)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Text("EMI Option Available",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            const Text("EMI stating from Rs. 50/ month",
                                style: TextStyle(fontSize: 18)),
                            Padding(
                              padding: const EdgeInsets.only(left: 210.0),
                              child: const Text(
                                "View Plan",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 76, 170, 88)),
                              ),
                            ),
                            const Text("Select Size",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black)),
                                      child: Center(
                                          child: Text(
                                        "28",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 18),
                                      ))),
                                  Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black)),
                                      child: Center(
                                          child: Text(
                                        "32",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 18),
                                      ))),
                                  Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black)),
                                      child: Center(
                                          child: Text(
                                        "34",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 18),
                                      ))),
                                  Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black)),
                                      child: Center(
                                          child: Text(
                                        "36",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 18),
                                      ))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(22),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 115, 122, 79),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: TextButton(
                                      onPressed: () async{
                                        var addprod = await connect.add_to_cart(provider.singleProduct['pk']);
                                        Fluttertoast.showToast(msg: '$addprod');
                                          var cartProd = await connect.fetchCart();
                                         provider.setCart(cartProd);
                                         
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>Cart()));
                                      },
                                      child: const Text(
                                        "Place your order",
                                        style: TextStyle(color: Color.fromARGB(255, 229, 235, 198)),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
          }
        )
         
       
      ),
           bottomNavigationBar:  CustomNavbar(selectedIndex: 1),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => orderWidget()));
          },
          child: Text("Next")),
    );
  }
}
