import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
//  String url='http://127.0.0.1:8000';

// String url='http://192.168.1.30:8000/';
// String url='http://192.168.143.153:8000/';
String url = 'http://192.168.1.25:8000';

String mediaUrl = '$url/media';

registerUser(name, email, password, phone) async {
  Map data = {
    'name': name,
    'email': email,
    'phone': phone,
    'password': password
  };

  try {
    var response =
        await http.post(Uri.parse('$url/register/'), body: jsonEncode(data));
    var status = response.statusCode;
    var responseBody = jsonDecode(response.body);
 
    return responseBody;
  } catch (e) {
    print('Exception: $e');
  }
}

loginUser(email, password) async {
  Map data = {'email': email, 'password': password};
  try {
    print(url);
    var response =
        await http.post(Uri.parse('$url/login/'), body: jsonEncode(data));
    var loginStatus = response.statusCode;
    print(loginStatus);
    var responseBody = jsonDecode(response.body);
    print("Login ResBody: $responseBody");

    if (responseBody['message'] == 'success') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseBody['token']);
    }

    // print(prefs.getString('token'));

    return responseBody;
  } catch (e) {
    print('Exception:$e');
  }
}

delete_cartitem(prodId) async {
  Map data = {
    "id": prodId,
  };
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');
  var response = await http.post(Uri.parse("$url/delete/"),
      body: jsonEncode(data), headers: {'token': tokenInCache ?? '0'});
  var loginStatus = response.statusCode;
  print(loginStatus);
  var responseBody = jsonDecode(response.body);
  return responseBody;
}

delete_wishlistItem(prodId) async {
  Map data = {
    "id": prodId,
  };
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');
  var response = await http.post(Uri.parse("$url/delete_wishlist/"),
      body: jsonEncode(data), headers: {'token': tokenInCache ?? '0'});
  var loginStatus = response.statusCode;
  print(loginStatus);
  print(response.body);
  var responseBody = jsonDecode(response.body);
  print(responseBody);
}

fetchProducts(subcatId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');

  var response = await http.get(Uri.parse("$url/get_products/$subcatId"),
      headers: {'token': tokenInCache ?? '0'});
  // print(response.statusCode);
  // print(response.body);
  return jsonDecode(jsonDecode(response.body));
}

fetchProductsubCategories(catId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');
  print("$url/get_product_subcategories/$catId");
  var response = await http.get(
      Uri.parse("$url/get_product_subcategories/$catId"),
      headers: {'token': tokenInCache ?? '0'});
  print(response.statusCode);
  print(response.body);
  return jsonDecode(jsonDecode(response.body));
}

fetchCategories() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');

  var response = await http.get(Uri.parse("$url/get_product_categories/"),
      headers: {'token': tokenInCache ?? '0'});
  //  print(response.statusCode);
  // print(response.body);
  return jsonDecode(jsonDecode(response.body));
}

fetchProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');
  var response = await http
      .get(Uri.parse("$url/profile/"), headers: {'token': tokenInCache ?? '0'});
  if (response.statusCode == 200) {
    return (jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(msg: "Failed to Fetch User Data");
    return ['', '', ''];
  }
}

fetchCart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');
  var response = await http.get(Uri.parse('$url/get_cart/'),
      headers: {'token': tokenInCache ?? '0'});
  if (response.statusCode == 200) {
    print(jsonDecode(jsonDecode(response.body)).runtimeType);
    return jsonDecode(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(msg: "Failed to Fetch Cart Data");
  }
}

add_to_cart(prodId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');
  var response = await http.post(Uri.parse("$url/add_to_cart/$prodId"),
      headers: {'token': tokenInCache ?? '0'});
  var cartStatus = response.statusCode;
  print(cartStatus);
  if (response.statusCode == 200) {
    print(response.body);
    return (jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(msg: "Failed to add product");
    return ['failed'];
  }
}

add_to_wishlist(prodId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');
  print('Add to Wishlist : $url/add_wishlist/$prodId');
  var response = await http.post(Uri.parse('$url/add_wishlist/$prodId'),
      headers: {'token': tokenInCache ?? '0'});
  var wishlistStatus = response.statusCode;
  print(wishlistStatus);
  if (response.statusCode == 200) {
    print(response.body);
    return (jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(msg: "Failed to add product");
    return ['failed'];
  }
}

fetchWishlist() async {
  print("Fetch Wishlist In");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var tokenInCache = prefs.getString('token');
  var response = await http.get(Uri.parse('$url/get_wishlist/'),
      headers: {'token': tokenInCache ?? '0'});
  if (response.statusCode == 200) {
    print('fetched wishlist ${response.body}');
    // print(jsonDecode(jsonDecode(response.body)).runtimeType);
    return jsonDecode(jsonDecode(response.body));
  } else {
    Fluttertoast.showToast(msg: "Failed to Fetch Wishlist");
  }
}
