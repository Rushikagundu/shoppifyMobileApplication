import 'package:flutter/material.dart';
import 'package:myntra/components/custom_appbar.dart';
import 'package:myntra/components/custom_navbar.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/productcategories.dart';
import 'package:myntra/profile.dart';
import 'package:myntra/product.dart';
import 'package:myntra/connections.dart' as connect;
import 'package:myntra/providers/productproviders.dart';
import 'package:myntra/wishlist.dart';
import 'package:provider/provider.dart';
class menWidget extends StatefulWidget {
  const menWidget({super.key});

  @override
  State<menWidget> createState() => _menWidgetState();
}

class _menWidgetState extends State<menWidget> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: customAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<ProductProvider>(
              builder: (context, provider, child) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 100,
                              child: GestureDetector(
                                child: Image.network("${connect.mediaUrl}/${provider.subCategoryData[0]['fields']['image_path']}"), onTap: () async{
                                  var prod=await connect.fetchProducts(1);
                                  provider.setProductData(prod);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Productcategories()));
                                },),
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
                              width: 100,
                              child: GestureDetector(
                                child: Image.network("${connect.mediaUrl}/${provider.subCategoryData[1]['fields']['image_path']}"), onTap: () async{
                                  var prod=await connect.fetchProducts(2);
                                  provider.setProductData(prod);
                                  print(provider.productData);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Productcategories()));
                                },),
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
                                  child: Image.network("${connect.mediaUrl}/${provider.subCategoryData[2]['fields']['image_path']}"),onTap: () async {
                                     var prod= await connect.fetchProducts(3);
                                    
                                     provider.setProductData(prod);
                                     print(provider.productData);
                                        Navigator.push(context, MaterialPageRoute(builder:(Builder)=>Productcategories()));
                                      },
                                ),
                              ),
                              Text("${provider.subCategoryData[2]['fields']['name']}"),
                            ],
                          ),
                        ),
                        
                    ],
                  ),
                );
              }
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
        ),
      ),
     bottomNavigationBar: CustomNavbar(selectedIndex: 1),
       floatingActionButton: 
      FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>Productcategories()));
      }, child:Text("Next")),
    );
  }
}