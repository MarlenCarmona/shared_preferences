import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
void main() => runApp(MyApps());
class MyApps extends StatelessWidget{
  MyApps({this.pass,this.name,this.correo});
  String pass;
  String name ;
  String correo;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: home(this.pass,this.name,this.correo),
    );
  }

}
class home extends StatefulWidget{
  home(this.pass,this.name,this.correo);
  String pass;
  String name ;
  String correo;
  @override
  _myHomePageState createState() => new _myHomePageState(this.pass,this.name,this.correo);
}
class _myHomePageState extends State<home>{
  _myHomePageState(this.pass,this.name,this.correo);
  String pass;
  String name ;
  String correo;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(title: Text("Hola $name"),
        centerTitle: true,),
      body: ListView(
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 10.0)),
          new Text("Hola $name",
            textAlign: TextAlign.center,
          ),
          new Padding(padding: EdgeInsets.only(top: 10.0)),
          new Text(" Tu correo es: $correo",
            textAlign: TextAlign.center,
          ),
          new Padding(padding: EdgeInsets.only(top: 10.0)),
          new Text(" Tu contraseña es: $pass",
            textAlign: TextAlign.center,
          ),
          new Padding(padding: EdgeInsets.only(top: 10.0)),
          new MaterialButton(
            onPressed: (){
              _CerrarSession();
            },
            child: Text("Cerrar sesion"),
          )
        ],
      ),
    );
  }

  Future<void> _CerrarSession() async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setString("Pass", "vacio");
    await sharedprefs.setString("Email", "vacio");
    await sharedprefs.setString("name", "vacio");
    setState(() {
      Navigator.pop(context, MaterialPageRoute(
          builder: (context) => homePage()));
    });
  }
}