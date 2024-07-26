import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myntra/connections.dart';
import 'package:myntra/homepage.dart';
import 'package:myntra/providers/productproviders.dart';
import 'package:myntra/register.dart';
import 'package:myntra/sample.dart';
import 'package:provider/provider.dart';

class shoppingWidget extends StatefulWidget {
  const shoppingWidget({super.key});

  @override
  State<shoppingWidget> createState() => _shoppingWidgetState();
}

class _shoppingWidgetState extends State<shoppingWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isValid = false;

  validate() {
    String email = emailController.text;
    String password = passwordController.text;
    if (email.isNotEmpty) {
      if (password.isNotEmpty) {
        isValid = true;
      } else {
        Fluttertoast.showToast(msg: "Password required");
      }
    } else {
      Fluttertoast.showToast(msg: "Email required");
    }
  }

  bool passwordVisible = false;

  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          // width:360,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:138.0),
                child: Container(
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/shopease.png", fit: BoxFit.cover,)),
              ),
              const Text(
                "Login",
                style: TextStyle(
                    color: Color.fromARGB(255, 68, 79, 16),
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: SizedBox(
                  width: 250,
                  child: Container(
                      child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email Address",
                      labelText: "Email Address",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  )),
                ),
              ),
              SizedBox(
                width: 250,
                child: Container(
                    child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: passwordVisible,
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
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Consumer<ProductProvider>(
                    builder: (context, provider, child) {
                  return ElevatedButton(
                      onPressed: () async {
                        validate();
                        if (isValid) {
                          var loginStatus = await loginUser(
                              emailController.text, passwordController.text);
                         
                          if (loginStatus['message'] == 'success') {
                            var cat = await fetchCategories();
                            provider.setCategoryData(cat);
                    

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => homeWidget()));
                          } else {
                            Fluttertoast.showToast(msg: 'User Not Found');
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Color.fromARGB(255, 68, 79, 16)),
                      ));
                }),
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?  "),
                  TextButton(
                    child: const Text("Sign in",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builer) => Register()));
                    },
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
      floatingActionButton:
          Consumer<ProductProvider>(builder: (context, provider, child) {
        return FloatingActionButton(
            onPressed: () async {
              var loginStatus = await loginUser('cc@gmail.com', 'cc');
              Fluttertoast.showToast(msg: '$loginStatus');
              if (loginStatus['message'] == 'success') {
                var cat = await fetchCategories();
                provider.setCategoryData(cat);
                print(cat);

                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => homeWidget()));
              } else {
                Fluttertoast.showToast(msg: 'failed');
              }
            },
            child: Text("Next"));
      }),
    );
  }
}
