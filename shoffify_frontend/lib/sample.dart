import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample"),
        backgroundColor: const Color.fromARGB(255, 245, 167, 167),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: const Icon(Icons.abc_outlined),
        actions: const [Icon(Icons.abc_outlined), Icon(Icons.abc_rounded)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Container(
                        decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                            ),
                        child: Column(
                          children: [
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80")),
                            const Text(
                              "Food",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                      Container(
                      child: Container(
                        decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                            ),
                        child: Column(
                          children: [
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8fA%3D%3D&w=1000&q=80")),
                            const Text(
                              "Food",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(onPressed: (){}, child: const Text("Click")),
            Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: TextButton(onPressed: (){}, child: const Text("CLick 2", style: TextStyle(color: Colors.green, decoration: 
              TextDecoration.underline),)),
            ),
          ],
        ),
      ),
    );
  }
}
