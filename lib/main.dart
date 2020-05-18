import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'save_class.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: homePage()
    );
  }
}

class homePage extends StatefulWidget{
  @override
  _myHomePageState createState()=>new _myHomePageState();
}

class _myHomePageState extends State<homePage>{
  @override
  void initState(){
    super.initState();
    _verificar();


  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController val1 =
  new TextEditingController(text: "");
  final TextEditingController val2 =
  new TextEditingController(text: "");
  final TextEditingController val3 =
  new TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Registro de Usuario"),
        centerTitle: true,
        backgroundColor: Colors.red[400],
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(padding: EdgeInsets.only(top: 40)),
          new Column(
            children: <Widget>[
              new Center(
                child: Container(
                  height: 100,
                  width: 230,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(image:
                    new NetworkImage("https://www.osi.es/sites/default/files/images/imagen-decorativa-infografia-cuentas-usuario.png"),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              new Padding(padding: EdgeInsets.all(30.0)),
              //new MiBotton("Siguiente", Colors.deepOrange),

              Form(
                key: _formKey,
                child: new Column(
                  children: <Widget>[
                    new TextField(
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                          hintText: "Nombre"),
                      controller: val1,
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    new Text(" E-mail",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                      ),),
                    new TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                          hintText: "ejemplo@yahoo.com"),
                      controller: val2,
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    new Text("Password",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    new TextField(
                      keyboardType: TextInputType.text,
                      decoration:  new InputDecoration(
                          hintText: "Contraseña"),
                      controller: val3,
                    ),
                  ],
                ),
              ),
              new Padding(padding: EdgeInsets.all(30.0)),
              RaisedButton(
                  textColor: Colors.white,
                  color: Colors.pink,
                  onPressed: () {
                    _enviarDatos(val1.text,val3.text,val2.text);
                    // print("Clicko")
                    child: new Text("Guardar",textScaleFactor: 2.0,);
                  } ),
            ],
          )
        ],
      ),
    );
  }

  //Metodos de validacion
  Future<String> _tenerContrasea() async{
    final sharedprefs = await SharedPreferences.getInstance();
    var numero = sharedprefs.getString('Pass') ?? "vacio";
    print(numero);
    return numero;
  }
  Future<String>_TenerNombre()async{
    final shaedpref = await SharedPreferences.getInstance();
    var name =  shaedpref.getString('name') ?? 'vacio';
    print(name);
    return name;
  }
  Future<String>_TenerCorreo()async{
    final sharedpref = await SharedPreferences.getInstance();
    var Email = sharedpref.getString("Email") ?? 'vacio';
    print(Email);
    return Email;
  }
  Future<void> _verificar() async {
    final sharedprefs = await SharedPreferences.getInstance();
    String password = await _tenerContrasea();
    String Correo = await _TenerCorreo();
    String Nombre = await _TenerNombre();
    setState(() {
      if(password == "vacio" && Correo == "vacio" && Nombre == "vacio"){
        print("te faltan datos");
      }
      else{
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => home(password,Nombre,Correo)));
      }
    });
  }
  Future<void> _enviarDatos(nombre,contrasea,correo) async {
    final sharedprefs = await SharedPreferences.getInstance();
    await sharedprefs.setString("Pass", contrasea.toString());
    await sharedprefs.setString("Email", correo.toString());
    await sharedprefs.setString("name", nombre.toString());
    setState(() {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => home(contrasea.toString(),nombre.toString(),correo.toString())));
    });



  }

}