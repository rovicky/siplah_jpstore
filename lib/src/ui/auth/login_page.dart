import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:siplah_jpmall/src/bloc/login/login_bloc.dart';
import 'package:siplah_jpmall/src/bloc/login/login_state.dart';
import 'package:siplah_jpmall/src/ui/auth/register_page.dart';
import 'package:siplah_jpmall/src/ui/mainpage.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> with LoginState {
  final bloc = LoginBloc();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF6BB8E3),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: MediaQuery.of(context).size.width / 5,
                        right: 10,
                        child: Container(
                          child: Image.asset(
                            'src/image/buku.png',
                            scale: 6,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 3),
                    width: MediaQuery.of(context).size.width - 50,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 80,
                                width: 20,
                                decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                        image: AssetImage(
                                            "src/image/Icons_SIPLAH_JPSTORE_2020.png"),
                                        fit: BoxFit.fill)),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "\nMasukkan Akun Kamu Disini",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12))
                                ]),
                              ), //text logo
                              SizedBox(height: 15),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)),
                                child: Center(
                                  child: TextField(
                                    controller: username,
                                    decoration: InputDecoration(
                                        contentPadding:
                                        const EdgeInsets.all(5.0),
                                        border: InputBorder.none,
                                        hintText: "Username"),
                                  ),
                                ),
                              ), //user
                              SizedBox(height: 10),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black54)),
                                child: Center(
                                  child: TextField(
                                      controller: password,
                                      decoration: InputDecoration(
                                          contentPadding:
                                          const EdgeInsets.all(5.0),
                                          border: InputBorder.none,
                                          hintText: "Password"),
                                      obscureText: _obscureText),
                                ),
                              ),
//                              new FlatButton(
//                                  onPressed: _toggle,
//                                  child: new Text(_obscureText ? "Show" : "Hide")),
                              SizedBox(height: 10),
                              MaterialButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (context) => Container(height: 50, width: 50, child: Center(child: CircularProgressIndicator(),),));
                                  submit();
                                },
                                color: Color(0xFF3FCB9B),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Login",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ), //Login
//                        SizedBox(height:),

                              SizedBox(height: 10),
                              MaterialButton(
                                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage())),
                                color: Color(0xffab2345).withOpacity(0.7),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("Daftar Nanti",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      child: Divider(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(width: 5.0),
                                    Text("atau"),
                                    SizedBox(width: 5.0),
                                    Container(
                                      width: 50,
                                      child: Divider(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ), //logo atau
                              SizedBox(height: 10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black87),
                                    children: [
                                      TextSpan(text: "Belum memiliki akun? "),
                                      TextSpan(
                                          text: "Daftar disini.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Register()))
                                      ),
                                    ]),
                              ) //logo daftar disini
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        //Button Login Google
                        //Button Login facebook
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  LoginPageState createdState() => this;
}