import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myntra/cart.dart';
import 'package:myntra/components/custom_appbar.dart';
import 'package:myntra/components/custom_navbar.dart';
import 'package:myntra/profile.dart';
import 'package:myntra/men.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:myntra/wishlist.dart';
import 'package:myntra/women.dart';
import 'package:myntra/connections.dart' as connect;
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class homeWidget extends StatefulWidget {
  const homeWidget({super.key});

  @override
  State<homeWidget> createState() => _homeWidgetState();
}

class _homeWidgetState extends State<homeWidget> {

  String Location='Press the icon to enable location';

  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
  return await Geolocator.getCurrentPosition();
}

  Future<void> GetLocationFromLatAndLong(Position position) async{
    
    List<Placemark> placemark= await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);
    Placemark place=placemark[0];  
    Location='${place.street},${place.country},${place.postalCode}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: SizedBox(
              height: 50,
              width: 360,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async{
                        Position position= await _determinePosition();
                      
                        GetLocationFromLatAndLong(position);
                        setState(() {
                          
                        });
                      },
                      child: Icon(Icons.gps_fixed_rounded)),
                   Text('${Location}')
                  
                  ],
                ),
              ),
            )
            ),
            Consumer<ProductProvider>(
              builder: (context, provider,child) {
                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 180,
                              child: GestureDetector(
                                child:
                                    Image.network("${connect.mediaUrl}/${provider.categoryData[0]['fields']['image_path']}"),
                                onTap: () async{
                                  var subProd= await connect.fetchProductsubCategories(1);
                                  provider.setSubCategoryData(subProd);
                                  print(provider.subCategoryData);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (Builder) => menWidget()));
                                },
                              ),
                            ),
                             Text("${provider.categoryData[0]['fields']['name']}"),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 150,
                              width: 180,
                              child: GestureDetector(
                                child:
                                    Image.network("${connect.mediaUrl}/${provider.categoryData[1]['fields']['image_path']}"),
                                onTap: () async{
                                  var subProd= await connect.fetchProductsubCategories(2);
                                  provider.setSubCategoryData(subProd);
                                  print(provider.subCategoryData);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (Builder) => womenWidget()));
                                },
                              ),
                            ),
                            Text("${provider.categoryData[1]['fields']['name']}"),
                          ],
                        ),
                      )
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
                decoration: BoxDecoration(color:Color.fromARGB(255, 0, 0, 0)),
                child: Center(
                    child: const Text(
                  "Summer Sale",
                  style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
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
      bottomNavigationBar: CustomNavbar(selectedIndex: 0),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => menWidget()));
          },
          child: Text("Next")),
    );
  }
}
