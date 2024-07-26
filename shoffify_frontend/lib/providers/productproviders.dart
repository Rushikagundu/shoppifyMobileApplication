import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myntra/connections.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String url='http://192.168.1.25:8000';

String mediaUrl='$url/media';

class ProductProvider extends ChangeNotifier{

  List categoryData= [];
  List subCategoryData= [];
  List productData= [];
  List profileData=[];
  List cartData=[];
  List wishlistData=[];
  Map singleProduct={};
  double totalPrice =0.0;

  setSingleProduct(data){
    print("singleprod data: $data");
    print(data.runtimeType);
    singleProduct=data;
    notifyListeners();
  }


  setCart(data){
   
    print("Entered SetCart");
    cartData=data;
    totalPrice=0;
       for(var i=0;i<cartData.length;i++){
      
      totalPrice=totalPrice+ int.parse(cartData[i]['fields']['product_price']);
    }
    double tot=totalPrice;
    notifyListeners();
  }


  setProductData(data){
    productData=data;
    notifyListeners();
  }

  setCategoryData(data) {
    categoryData = data;
    notifyListeners();
  }

  setSubCategoryData(data){
    subCategoryData=data;
    print('inproviderSubcat-${subCategoryData}');
    notifyListeners();
  }

  setProfileData(data){
    profileData=data;
    notifyListeners();
  }

  setWishlist(data) async {
    wishlistData = data;
    print("wishlistData: $wishlistData");
    notifyListeners();
  }
  removeFromCart(prodId) async{
    var data=await delete_cartitem(prodId);
    print("after delete ${data["message"]}");
  }

  removeWishlistItem(prodId) async {
    var data=await delete_wishlistItem(prodId);
    print("data $data");
  }
    

}