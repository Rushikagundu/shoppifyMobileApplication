import 'package:flutter/material.dart';
import 'package:myntra/components/custom_appbar.dart';
import 'package:myntra/components/custom_navbar.dart';
import 'package:myntra/product.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:provider/provider.dart';
import 'package:myntra/connections.dart' as connect;


class Productcategories extends StatefulWidget {
  const Productcategories({ Key? key }) : super(key: key);

  @override
  _ProductcategoriesState createState() => _ProductcategoriesState();
}

class _ProductcategoriesState extends State<Productcategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context),
      body: Consumer<ProductProvider>(
        builder: (context, provider, index) {
          List productList = [[], []];
          for(int i=0; i<provider.productData.length ; ++i){
            if(i%2==0) {
              productList[0].add(provider.productData[i]);
            } else {
              productList[1].add(provider.productData[i]);
            }
          }
          // print("ProductList: ${productList}");
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    height:700,
                    width: 420,
                    child: ListView.builder(
                      itemCount: productList[0].length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index){
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 300,
                              width: 170,
                              child: Container(
                                width: 100,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                     
                                     child:InkWell
                                     (
                                      onTap: () {
                                   
                                        provider.setSingleProduct(productList[0][index]);
                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>productWidget()));
                                      },
                                      child: Image.network("${connect.mediaUrl}/${productList[0][index]['fields']['image_path']}"))),
                                   Text('Price: ${productList[0][index]['fields']['product_price']}/-', style: TextStyle(fontWeight: FontWeight.bold),),
                                     Text(productList[0][index]['fields']['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                    
                                    SizedBox(
                                      height: 20,
                                      child: Text(productList[0][index]['fields']['product_desc'])),
                                    
                                                        
                                  ],
                                ),
                              ),
                            ),
                            if(index < productList[1].length)
                            SizedBox(
                              height: 300,
                              width: 160,
                              child: Container(
                                child: Column(
                                   children: [
                                    SizedBox(
                                      height: 200,
                                      width: 200,
                                      child:InkWell(
                                        onTap: () {
                                        provider.setSingleProduct(productList[1][index]);
                                        Navigator.push(context,MaterialPageRoute(builder: (builder)=>productWidget()) );
                                      },
                                        child: Image.network("${connect.mediaUrl}/${productList[1][index]['fields']['image_path']}"))),
                                  Text('Price: ${productList[1][index]['fields']['product_price']}/-', style: TextStyle(fontWeight: FontWeight.bold),),
                                       Text(productList[1][index]['fields']['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                    
                                      SizedBox(
                                        height: 20,
                                        child: Text(productList[1][index]['fields']['product_desc'])),
                                    
                                  ],
                                ),
                               
                              ),
                            )
                          ],
                        );
                    }),
                  ),
                ),
              ],
            ),
          );
        }
      ),
       bottomNavigationBar:  CustomNavbar(selectedIndex: 1),
    );
  }
}