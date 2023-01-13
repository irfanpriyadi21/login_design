import 'package:flutter/material.dart';

class Mainmenu extends StatefulWidget {

  final VoidCallback signOut;
  Mainmenu(this.signOut);

  @override
  _MainmenuState createState() => _MainmenuState();
}

class _MainmenuState extends State<Mainmenu> {
  signOut(){
    setState(() {
      widget.signOut();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: (){
              signOut();

              },
            icon: Icon(Icons.power_settings_new),
          )
        ],
      ),
      body: Center(
        child: Text("Main Menu"),
      ),
    );
  }
}
