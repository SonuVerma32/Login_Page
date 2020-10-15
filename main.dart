import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()=> runApp(new Myapp());

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return new MaterialApp(
     home: new Loginpage(),
     theme: new ThemeData(
       primarySwatch: Colors.blueGrey,
     ),
   );
  }
}

class Loginpage extends StatefulWidget{
  @override
  State createState()=> new LoginpageState();
}
class LoginpageState extends State<Loginpage> with SingleTickerProviderStateMixin{

  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState(){
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this,
      duration: new Duration(milliseconds: 500)
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeOut);
    _iconAnimation.addListener(()=> this.setState((){}));
    _iconAnimationController.forward();
  }
  final scaffoldkey = new GlobalKey<ScaffoldState>();
  final formkey = new GlobalKey<FormState>();
  String _email,_password;

  /*void getdataa(){
    String s1 = t1.text;
    String s2 = t2.text;
    String s3 = s1+""+s2;
  }*/
  void _submit(){
    final form = formkey.currentState;
    if (form.validate()){
      form.save();
      performLogin();
    }
  }
  performLogin(){
    final snackbar = new SnackBar(content: new Text("Email : $_email & Password : $_password"));
    scaffoldkey.currentState.showSnackBar(snackbar);
  }
@override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey,
      key: scaffoldkey,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
//          new Image(
//            image: new AssetImage("assets/sk.jpg"),
//            fit: BoxFit.cover,
//          ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FlutterLogo(
              size: _iconAnimation.value * 100,
            ),
            new Form(
              key: formkey,
              child:  Theme(
                data: new ThemeData(
                  brightness: Brightness.dark,
                  primarySwatch: Colors.green,
                  inputDecorationTheme: new InputDecorationTheme(
                    labelStyle: new TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                    )
                  )
                ),
                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        autofocus: true,
                        decoration: new InputDecoration(
                          labelText: "Enter Email",
                        ),
                        keyboardType: TextInputType.emailAddress ,
                        validator: (val) => val.contains("@")?null:'Invalid Email',
                        onSaved: (val) => _email = val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Password",
                        ),
                        keyboardType: TextInputType.text ,
                        validator: (val) => val.length<6?'Password to short':null,
                        onSaved: (val) => _password = val,
                        obscureText: true,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                      ),
                      new MaterialButton(
                        color: Colors.greenAccent,
                        child: new Text("Login"),
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0),
                        ),
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),

            )
          ],
        )
        ],
      ),
    );
  }

}
