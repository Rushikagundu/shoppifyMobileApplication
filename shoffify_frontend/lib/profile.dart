import 'package:flutter/material.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/order.dart';
import 'package:myntra/login.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:provider/provider.dart';

class logoutWidget extends StatefulWidget {
  const logoutWidget({super.key});

  @override
  State<logoutWidget> createState() => _logoutWidgetState();
}

class _logoutWidgetState extends State<logoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                 Padding(
                      padding: EdgeInsets.only(top:100),
                      child: Center(child: Text("Profile",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 68, 79, 16)),)),
                    ),
              
                Padding(
                  padding: const EdgeInsets.only(top:50),
                  child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeyKsVv8iDGr6Q3LF9tIdyY_dOi79dqJKjIw&usqp=CAU"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:120.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      child: Row(
                        children: [
                          Text("Name : ",style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25)),
                          Text('${provider.profileData[0]}', style: TextStyle(fontSize: 25),)
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:30.0),
                  child: Container(
                    child: Row(
                      children: [
                        Text("Email : ",style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25)),
                        Text('${provider.profileData[1]}', style: TextStyle(fontSize: 25),)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:26.0),
                  child: Container(
                    child: Row(
                      children: [
                        Text("Mobile Number : ",style: TextStyle(fontWeight:FontWeight.bold, fontSize: 25)),
                        Text('${provider.profileData[2]}', style: TextStyle(fontSize: 25),)
                      ],
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top:30),
                  child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                              
                                ),
                                
                                child: ElevatedButton(
                                    onPressed: () {
                                    Navigator.maybePop(context);
                                    },
                                    child: const Text(
                                      "Back",
                                      style: TextStyle(color: Color.fromARGB(255, 68, 79, 16), fontWeight: FontWeight.bold, fontSize: 20),
                                    )),
                              ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:30),
                  child: Container(
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 68, 79, 16),
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                
                                child: TextButton(
                                    onPressed: () {

                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>shoppingWidget()), (route) => false,);
                                    },
                                    child: const Text(
                                      "LogOut",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                    )),
                              ),
                ),

              ],
            );
          }
        ),
      ),
       floatingActionButton: 
      FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>shoppingWidget()));
      }, child:Text("Next")),
    );
  }
}