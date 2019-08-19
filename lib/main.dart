import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    title: "hello",
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.bars),
          onPressed: null,
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text("Tech Post", style: TextStyle()),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.newspaper,
              size: 20.0,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            const Text("Loading...");
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot mypost = snapshot.data.documents[index];
                return Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 310.0,
                      child: Material(
                        color: Colors.white30,
                        elevation: 14.0,
                        shadowColor: Colors.yellowAccent,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200.0,
                                  child: Image.network(
                                    "${mypost['image']}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "${mypost['title']}",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "${mypost['subtitle']}",
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w200,
                                      color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*.47,
                        left: MediaQuery.of(context).size.height*.52,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.brown,
                        child: Icon(Icons.star, color: Colors.white, size: 20.0,),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        stream: Firestore.instance.collection("post").snapshots(),
      ),
    );
  }
}
