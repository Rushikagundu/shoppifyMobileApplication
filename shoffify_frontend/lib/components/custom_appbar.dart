import 'package:flutter/material.dart';
import 'package:myntra/cart.dart';
import 'package:myntra/connections.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:provider/provider.dart';


customAppbar(context) {
  return AppBar(
          backgroundColor:  Color.fromARGB(255, 181,192,124),
          foregroundColor: Color.fromRGBO(8, 8, 8, 1),
          leading: const Icon(Icons.dehaze),
          actions: [
            Icon(Icons.search),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            ),
            Consumer<ProductProvider>(
              builder: (context, provider, child) {
                return InkWell(
                    onTap: () async{
                      var cartProd= await fetchCart();
                      provider.setCart(cartProd);
                    
                      Navigator.push(
                          context, MaterialPageRoute(builder: (builder) => Cart()));
                    },
                    child: Icon(Icons.shopping_bag));
              }
            )
          ]);
    }
 
