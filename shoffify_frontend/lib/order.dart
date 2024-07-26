import 'package:flutter/material.dart';
import 'package:myntra/cart.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/profile.dart';

class orderWidget extends StatefulWidget {
  const orderWidget({super.key});

  @override
  State<orderWidget> createState() => _orderWidgetState();
}

class _orderWidgetState extends State<orderWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
          
            Container(
              height: 200,
                 width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: const Color.fromARGB(255, 181,192,124)),
              
              child: const Icon(Icons.check_circle_outline,size: 90,color: Color.fromARGB(255, 68, 79, 16),),
            ),
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: const Text("Congrats!", style: TextStyle(
                color: Color.fromARGB(255, 68, 79, 16), fontWeight: FontWeight.bold, fontSize: 40
              ),),
            ),
             const Text("Order placed successfully!", style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25
            ),),
            Padding(
              padding: const EdgeInsets.only(top: 42.0),
              child: const Text("Your order will be shipped soon", style: TextStyle(
                 fontSize: 20
              ),),
            ),
             const Text("Keep Shopping!!", style: TextStyle(
               fontSize: 20
            ),),
                Padding(
                      padding: const EdgeInsets.only(top: 40),

                      child: Center(
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder:(Builder)=>Cart()));
                              },
                              child: const Text(
                                "Go to Cart",
                                style: TextStyle(color: Color.fromARGB(255, 68, 79, 16), fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                        ),
                      ),
                    ),
            Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 68, 79, 16),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder:(Builder)=>homeWidget()));
                              },
                              child: const Text(
                                "Go to Dashboard",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                        ),
                      ),
                    )
          ],
        ),
      ),
      floatingActionButton: 
      FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>logoutWidget()));
      }, child:Text("Next")),
    );
  }
}