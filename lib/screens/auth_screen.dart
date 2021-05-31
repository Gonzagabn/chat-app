import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    setState(() {
      _isLoading = true;
    });

    UserCredential userCredential;
    try {
      if (authData.isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: authData.email!.trim(),
          password: authData.password!,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: authData.email!.trim(),
          password: authData.password!,
        );

        final userData = {
          'name': authData.name,
          'email': authData.email,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userData);
      }
    } on FirebaseAuthException catch (err) {
      final msg = err.message ?? 'Ocorreu um erro! verifique suas credenciais.';
      _scaffoldMessengerKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        // body: AuthForm(_handleSubmit),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  AuthForm(_handleSubmit),
                  if (_isLoading)
                    Positioned.fill(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        decoration:
                            BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
