import 'package:flutter/material.dart';
import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:nested_navigation/provider/theme_provider.dart';
import 'package:nested_navigation/provider/top_level_navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final ThemeProvider _themeProvider;
  late final AuthProvider _authProvider;
  late final TopLevelNavigationProvider _topLevelNavigationProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _launchURL(Uri url) async {
    await canLaunchUrl(url)
        ? await launchUrl(url, mode: LaunchMode.externalApplication)
        : throw 'Could not launch $url';
  }

  @override
  void initState() {
    super.initState();

    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Form(
              key: _formKey,
              child: Card(
                margin: const EdgeInsets.all(18),
                color: Theme.of(context).cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image(
                          image: AssetImage(
                            "assets/banner/flex_task_banner.png",
                          ),
                        ),
                        height: 200,
                      ),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Enter your username',
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _usernameController.text = value ?? "",
                      ),
                      const Divider(
                        height: 20,
                        color: Colors.transparent,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Enter your password',
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _passwordController.text = value ?? "",
                      ),
                      const Divider(
                        height: 35,
                        thickness: 0,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Colors.black38,
                              width: 2), // change the color and width as needed
                          minimumSize:
                              const Size(200, 60), // change the size as needed
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20, // change the font size as needed
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _authProvider.login(_usernameController.text,
                                _passwordController.text);
                          }
                        },
                      ),
                      Spacer(),
                      Flexible(child: Text("You don't have an account?")),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image(
                                  height: 50,
                                  image: AssetImage(
                                      'assets/images/linkedin_logo.png')),
                              onPressed: () => _launchURL(linkedInUrl),
                            ),
                            SizedBox(width: 10),
                            IconButton(
                              icon: Image(
                                  height: 50,
                                  image: AssetImage(
                                      'assets/images/github_logo.png')),
                              onPressed: () => _launchURL(githubUrl),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
