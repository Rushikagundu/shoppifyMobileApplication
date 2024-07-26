import 'package:flutter/material.dart';

class newWidget extends StatefulWidget {
  const newWidget({super.key});

  @override
  State<newWidget> createState() => _newWidgetState();
}

class _newWidgetState extends State<newWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Application"),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        leading: const Icon(Icons.abc_rounded),
        actions: const [Icon(Icons.abc), Icon(Icons.abc_rounded)],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                      "https://media.istockphoto.com/id/1409236261/photo/healthy-food-healthy-eating-background-fruit-vegetable-berry-vegetarian-eating-superfood.jpg?b=1&s=612x612&w=0&k=20&c=2zneB18UvroqNeKhG13kCT-jgMuxvHHpEcWKhNDFxBk="),
                                ),
                                const Text("Healthy Eating",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blue))
                              ],
                            )),
                      ),
                      Container(
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(
                                      "https://media.istockphoto.com/id/1409236261/photo/healthy-food-healthy-eating-background-fruit-vegetable-berry-vegetarian-eating-superfood.jpg?b=1&s=612x612&w=0&k=20&c=2zneB18UvroqNeKhG13kCT-jgMuxvHHpEcWKhNDFxBk="),
                                ),
                                const Text("Healthy Eating",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blue))
                              ],
                            )),
                      )
                    ],
                  ))),
          Container(
              child: TextFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: const BoxDecoration(color: Colors.blue),
                child: TextButton(
                  onPressed: () {},
                  child:
                      const Text("Click Here", style: TextStyle(color: Colors.white)),
                )),
          )
        ]),
      ),
    );
  }
}
