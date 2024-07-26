import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myntra/cart.dart';
import 'package:myntra/components/custom_navbar.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/profile.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:provider/provider.dart';
import 'package:myntra/connections.dart' as connect;

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 181,192,124),
          foregroundColor: Color.fromRGBO(8, 8, 8, 1),
          leading: BackButton(),
          centerTitle: true,
          title: Text(
            "My Wishlist",
            style: TextStyle(color: Color.fromARGB(187, 63, 70, 27)),
          ),
          actions: [
            Icon(Icons.search),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (builder) => Cart()));
                },
                child: Icon(Icons.shopping_bag))
          ]),
      body: SingleChildScrollView(
        child: Consumer<ProductProvider>(builder: (context, provider, child) {
          if (provider.wishlistData.isEmpty) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 298.0),
              child: Column(
                children: [
                  Icon(Icons.shopping_bag),
                  Text(
                    "Nothing here :(",
                    style: TextStyle(fontSize: 28),
                  )
                ],
              ),
            ));
          }
          return SizedBox(
            height: 700,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: provider.wishlistData.length,
              itemBuilder: (context, index) {
                return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: const Color.fromARGB(187, 63, 70, 27)))),
                      // border: Border.all(),),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                            height: 150,
                            
                            child: SizedBox(
                             
                              width: 100,
                              child: Image.network(
                                  "${connect.mediaUrl}/${provider.wishlistData[index]['fields']['image_path']}"),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Text(
                                "${provider.wishlistData[index]['fields']['name']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 23),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  '${provider.wishlistData[index]['fields']['product_desc']}',
                                  style: TextStyle(fontSize: 18),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Text(
                                  'Price:${provider.wishlistData[index]['fields']['product_price']}/-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                                onTap: () async {
                                  await provider.removeWishlistItem(provider.wishlistData[index]['pk']);
                                  var data = await connect.fetchWishlist();
                                  provider.setWishlist(data);
                                },
                                child: Icon(Icons.delete_outline_rounded, color: const Color.fromARGB(187, 63, 70, 27),)),
                                InkWell(
                                  onTap: () async{
                                    var addprod = await connect.add_to_cart(provider.wishlistData[index]['pk']);
                                    print("msg: $addprod");
                                    var cartProd = await connect.fetchCart();
                                  provider.setCart(cartProd);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Cart()));
                                  },
                                  child:  Icon(Icons.shopping_bag_outlined, color: const Color.fromARGB(187, 63, 70, 27),),
                                )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
              },
              
            ),
          );
        }),
      ),
      bottomNavigationBar: CustomNavbar(selectedIndex: 2),
    );
  }
}
