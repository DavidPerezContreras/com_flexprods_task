import 'package:flutter/material.dart';
import 'package:nested_navigation/data/auth/remote/auth_remote_impl.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/provider/auth_navigation_provider.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/content_page.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.red,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("Login Screen"),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onSaved: (value) => username = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) => password = value,
                ),
                ElevatedButton(
                  child: Text("Login"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      authProvider.login(username!, password!);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
