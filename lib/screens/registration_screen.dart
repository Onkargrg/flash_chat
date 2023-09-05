import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserRegistrationScreen extends StatefulWidget {
  static const String id = 'user_registration_screen';

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Hero(
                          tag: 'logo',
                          child: Container(
                            height: 150.0,
                            child: Image.asset('images/logo.png'),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Flash Chat',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 40.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Email'),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your Password'),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        RoundedButton(
                            title: 'Register',
                            color: Colors.blueAccent,
                            onPressed: () async {
                              setState(() {
                                showSpinner = false;
                              });
                              try {
                                final newUser = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
                                if (newUser != null) {
                                  Navigator.pushNamed(context, ChatScreen.id);
                                }
                                setState(() {
                                });
                              } catch (e) {
                                print(e);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
