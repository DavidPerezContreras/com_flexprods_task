import 'package:flutter/material.dart';
import 'package:nested_navigation/domain/model/describable_error.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/bottom_nav_page.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:nested_navigation/provider/theme_provider.dart';
import 'package:nested_navigation/provider/top_level_navigation_provider.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final ThemeProvider _themeProvider;
  late final AuthProvider _authProvider;
  late final TopLevelNavigationProvider _topLevelNavigationProvider;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? username;
  String? password;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);

    _authProvider.addListener(
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {},
        );
      },
    );
    _authProvider.addListener(_handleAuthChange);
  }

  void _handleAuthChange() {
    ResourceState<User> userState = _authProvider.userState;

    switch (userState.status) {
      case Status.SUCCESS:
        setState(() {
          _isLoading = false;
          Navigator.of(_topLevelNavigationProvider
                  .topLevelNavigation.currentState!.context)
              .pushReplacement(
            MaterialPageRoute(
              builder: (context) => const BottomNavigationPage(),
            ),
          );
        });
        break;
      case Status.LOADING:
        setState(() {
          _isLoading = true;
        });
        break;
      case Status.ERROR:
        setState(
          () {
            _isLoading = false;
            _showErrorMessage(userState.error!);
          },
        );
        break;
      case Status.NONE:
        setState(() {
          _isLoading = false;
          _formKey = GlobalKey<FormState>();
        });
        break;
      default:
    }
  }

  void _showErrorMessage(DescribableError error) async {
    String errorMessage = error.description;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );

    _authProvider.logout();
  }

  init() {}

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Loading Indicator'),
        ),
        body: const Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: double.infinity,
        width: double.infinity,
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
                    TextFormField(
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
                      onSaved: (value) => username = value,
                    ),
                    const Divider(
                      height: 20,
                      color: Colors.transparent,
                    ),
                    TextFormField(
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
                      onSaved: (value) => password = value,
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
                          _authProvider.login(username!, password!);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
