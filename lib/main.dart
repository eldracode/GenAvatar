import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(new MaterialApp(
      title: 'GenAvatar',
      home: MyApp(),
      theme: new ThemeData(
        primaryColor: Colors.blueAccent,
      ),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var imageUrl = 'https://api.adorable.io/avatars/125/eldraco';
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Avatar Generator'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Stack(children: <Widget>[
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(
                  height: 360,
                  color: Colors.blueAccent,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      new CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 30.0),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          child: new Container(
                              width: 300,
                              child: TextField(
                                controller: searchController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  hintText: 'Enter a random name or any string',
                                  hintStyle: TextStyle(fontSize: 13.0),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 32.0, vertical: 14.0),
                                  border: InputBorder.none,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    elevation: 10.0,
                    onPressed: () {
                      setState(() {
                        imageUrl =
                            'https://api.adorable.io/avatars/125/${searchController.text}';
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text('Generate\n   Avatar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold)),
                    color: Colors.blueAccent,
                  )
                ],
              ),
            )
          ]),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final path = new Path();
    path.lineTo(0.0, size.height);
    var firstEnd = Offset(size.width / 2, size.height - 27);
    var firstControl = Offset(size.width / 4, size.height - 45);
    path.quadraticBezierTo(
        firstControl.dx, firstControl.dy, firstEnd.dx, firstEnd.dy);
    var secondEnd = Offset(size.width, size.height - 70);
    var secondControl = Offset(3 * size.width / 4, size.height - 6);
    path.quadraticBezierTo(
        secondControl.dx, secondControl.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
