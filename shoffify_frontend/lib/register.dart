import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myntra/connections.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/login.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   bool passwordVisible=false;
      
   @override
    void initState(){
      super.initState();
      passwordVisible=true;
    } 

  bool isValid =false;

  void validate(){
    String username=nameController.text;
    String email=emailController.text;
    String phone=phoneController.text;
    String loginpassword=passwordController.text;
    if(username.isNotEmpty){
        if(email.isNotEmpty){
          if( RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)){
          if(phone.isNotEmpty){
            if(loginpassword.isNotEmpty){
              if( RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(loginpassword)){
                isValid=true;
              }else{
                            Fluttertoast.showToast(msg: "Password must contain minimum 8 characters with aleast 1 Uppercase, 1 lowercase, 1 numeric number and a special symbol ");
              }
  
            }else{
               Fluttertoast.showToast(msg: "Password required");
            }
          }else{
             Fluttertoast.showToast(msg: "Mobile Number required");
          }
          }
          else{
              Fluttertoast.showToast(msg: "enter valid email");
          } 
        }else{
          Fluttertoast.showToast(msg: "Email required");
        } 
      }else{
      Fluttertoast.showToast(msg: "Username required");
      }
  
   
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        
        child: Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.only(top:118.0),
              child: Container(
                  
                  child:SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/shopease.png",fit: BoxFit.cover,))
               ),
            ),
              const Text("Register",
              style: TextStyle(color: Color.fromARGB(255, 68, 79, 16), fontWeight: FontWeight.bold, fontSize: 40 ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 250,
                  child: Container(
                  child: TextFormField(
                    controller: nameController,
                  
                    decoration: const InputDecoration(hintText: "Username",
                      labelText: "Username",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                  ),
                    
                  )
                  ),
                ),
              ),
               Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: SizedBox(
                   width: 250,
                   child: Container(
                   child: TextFormField(
                    controller: emailController,
                     decoration: const InputDecoration(hintText: "Email Address",
                       labelText: "Email Address",
                       floatingLabelBehavior: FloatingLabelBehavior.auto,
                       enabledBorder: OutlineInputBorder(),
                       focusedBorder: OutlineInputBorder(),
                   ),
                     
                   )
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(4.0),
                 child: SizedBox(
                   width: 250,
                   child: Container(
                   child: TextFormField(
                    controller: phoneController,
                     decoration: const InputDecoration(hintText: "Mobile Number",
                       labelText: "Mobile Number",
                       floatingLabelBehavior: FloatingLabelBehavior.auto,
                       enabledBorder: OutlineInputBorder(),
                       focusedBorder: OutlineInputBorder(),
                   ),
                     
                   )
                   ),
                 ),
               ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 250,
                  child: Container(
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    decoration:  InputDecoration(
                      hintText: "Password",
                        labelText: "password",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                     suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    }, icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility))
                  ),
                    
                  )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: ElevatedButton(onPressed: () async {
                  validate();
                  if(isValid){
                       var status = await registerUser(nameController.text, emailController.text, passwordController.text, phoneController.text);
                  Fluttertoast.showToast(msg: '$status');
                  print(status);
                  if(status["message"]=='success'){
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>shoppingWidget()));
                  } 
                  }
                }, child: const Text("SignIn", style: TextStyle(color: Color.fromARGB(255, 68, 79, 16)), )),
              ),
             Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Account exists?  "),
                  TextButton(child: const Text("Log in", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (builer)=>shoppingWidget()));
                  },),
            
                ],
              )
              
             )
          ],
        )
      ),
    );
  }
}