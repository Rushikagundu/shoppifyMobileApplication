import 'package:flutter/material.dart';
import 'package:myntra/components/custom_appbar.dart';
import 'package:myntra/components/custom_navbar.dart';
import 'package:myntra/product.dart';
import 'package:myntra/connections.dart' as connect;
import 'package:myntra/productcategories.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:provider/provider.dart';

class womenWidget extends StatefulWidget {
  const womenWidget({super.key});

  @override
  State<womenWidget> createState() => _womenWidgetState();
}

class _womenWidgetState extends State<womenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context),
      body: SingleChildScrollView(
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 80,
                              child: GestureDetector(
                                child: Image.network(
                                    "${connect.mediaUrl}/${provider.subCategoryData[0]['fields']['image_path']}"),onTap: ()async{
                                       var prod=await connect.fetchProducts(4);
                                  provider.setProductData(prod);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Productcategories()));
                                    },
                              ),
                            ),
                             Text("${provider.subCategoryData[0]['fields']['name']}"),
                          ],
                        ),
                      ),
                       Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 80,
                              child: GestureDetector(
                                child: Image.network(
                                    "${connect.mediaUrl}/${provider.subCategoryData[1]['fields']['image_path']}"), onTap: ()async{
                                       var prod=await connect.fetchProducts(5);
                                  provider.setProductData(prod);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Productcategories()));
                                    },
                              ),
                            ),
                             Text("${provider.subCategoryData[1]['fields']['name']}"),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 100,
                              child: GestureDetector(
                                child: Image.network(
                                    "${connect.mediaUrl}/${provider.subCategoryData[2]['fields']['image_path']}"),onTap: ()async{
                                       var prod=await connect.fetchProducts(6);
                                  provider.setProductData(prod);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Productcategories()));
                                    },
                              ),
                            ),
                             Text("${provider.subCategoryData[2]['fields']['name']}"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 38.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Center(
                        child: const Text(
                      "Summer Sale",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                  ),
                ),
       Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/banner.jpg",
                      fit: BoxFit.cover,
                    )),
              ],
            );
          }
        ),
      ),
      bottomNavigationBar:  CustomNavbar(selectedIndex: 1),

      floatingActionButton: 
      FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>productWidget()));
      }, child:Text("Next")),
    );
    
  }
}