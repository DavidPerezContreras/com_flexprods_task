import 'package:flutter/material.dart';
import 'package:nested_navigation/data/auth/remote/auth_remote_impl.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/provider/auth_navigation_provider.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/content_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthRemoteImpl authRemoteImpl = AuthRemoteImpl();

  @override
  Widget build(BuildContext context) {
    final authNavigationProvider = Provider.of<AuthNavigationProvider>(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.red,
        child: Center(
          child: Column(
            children: [
              Text("Login Screen"),
              ElevatedButton(
                child: Text("Login"),
                onPressed: () async {
                  authRemoteImpl.login().then((resourceState) {
                    if (resourceState.status == Status.SUCCESS) {
                      authNavigationProvider
                          .navigate(const MaterialPage(child: ContentPage()));
                    }
                  });
                },
              ),
              ElevatedButton(
                child: Text("Login"),
                onPressed: () {
                  authNavigationProvider
                      .navigate(const MaterialPage(child: ContentPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
