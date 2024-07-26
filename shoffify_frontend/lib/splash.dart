import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myntra/register.dart';
import 'package:myntra/login.dart';

class splashWidget extends StatefulWidget {
  const splashWidget({super.key});

  @override
  State<splashWidget> createState() => _splashWidgetState();
}

class _splashWidgetState extends State<splashWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),
    ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register()))
    
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width:360,
          height: 800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child:  Image.asset("assets/shopease.png", fit: BoxFit.cover,),
              )
             
            ],
           
          ),
        )
      ),
    );
  }
}
