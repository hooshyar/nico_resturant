import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nico_resturant/src/services/auth_service.dart';
import 'package:nico_resturant/src/style/style.dart';
import 'package:nico_resturant/src/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final auth = Auth();

  bool validate = true;

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
//    var user = Provider.of<FirebaseUser>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: sKey,
        body: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(gradient: mainGradientColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: Image.asset(
                          'lib/assets/Manager_logo_white.png',
                          scale: 1.5,
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(boxShadow: [globalBoxShadow]),
//              padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white,
                              ),
                              child: formTextFieldNoBorder(
                                  validator: (input) {
                                    if (input.isEmpty || !input.contains('@')) {
                                      setState(() {
                                        validate = false;
                                      });

                                      return 'Please Enter a Valid Email';
                                    }
                                    return null;
                                  },
                                  controller: emailController,
                                  theLabel: 'Email: ',
                                  theHelper: 'name@domainemail.com'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(boxShadow: [globalBoxShadow]),
//              padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: formPasswordText(
                                validator: (input) {
                                  if (input.isEmpty || !input.contains('')) {
                                    setState(() {
                                      validate = false;
                                    });

                                    return 'Please Enter a Valid Email';
                                  }
                                  return null;
                                },
                                controller: passwordController,
                                theLabel: 'Password: ',
                                theHelper: 'password'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: globalBtn(
                          textColor: Colors.grey[800],
                          theTitle: 'Login',
                          theGColor: LinearGradient(colors: [
                            Colors.greenAccent,
                            Colors.greenAccent[100]
                          ]),
                          theOnPressed: () {
                            signIn();
//                        emailController.text = 'wow';
                          })),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'If you forgot your password please contact the '
                        'Datacode company, phone number:',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        '+964 751 449 1008',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      _email = emailController.text;
      _password = passwordController.text;
      try {
//        setState(() {
//          _isLoading = true;
//        });

        var user = await auth.signInWithEmailAndPassword(_email, _password);
//        setState(() {
//          _isLoading = false;
//        });

        if (user != null) {
          if (_email.contains('hooshyar')) {
            Navigator.pushNamed(context, '/AdminPage');
          } else {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/HomePage');
          }
        } else {
          debugPrint('show alert');
          setState(() {
            return sKey.currentState
                .showSnackBar(SnackBar(content: Text('Error')));
          });
        }
      } catch (e) {
//        setState(() {
//          _isLoading = false;
//        });
        sKey.currentState.showSnackBar(SnackBar(content: Text('Error')));
        debugPrint('the Error is here  $e  ');
      }
    }
  }
}
