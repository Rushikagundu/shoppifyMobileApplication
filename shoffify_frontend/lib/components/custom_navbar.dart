import 'package:flutter/material.dart';
import 'package:myntra/connections.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/profile.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:myntra/wishlist.dart';
import 'package:provider/provider.dart';


class CustomNavbar extends StatefulWidget {
  final selectedIndex;
  const CustomNavbar({super.key, required this.selectedIndex});

  @override
  State<CustomNavbar> createState() => _CustomNavbarState();
}

class _CustomNavbarState extends State<CustomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, child) {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            backgroundColor:  Color.fromARGB(255, 181,192,124),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: widget.selectedIndex,
            onTap: (index) async {
              if(index==0){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>homeWidget()));
              }
              else if(index==1){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>homeWidget()));
              }
              else if(index==2){
                var data = await fetchWishlist();

                provider.setWishlist(data);
                // print(data);
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>Wishlist()));
              }else{
                var data = await fetchProfile();
                provider.setProfileData(data);
                // print(data);
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>logoutWidget()));
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined,
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
          
                icon: Icon(
                  
                  Icons.favorite),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'My Profile',
              ),
            ],
          );
      }
    );
  }
}