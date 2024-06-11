import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/domain/model/describable_error.dart';
import 'package:test/domain/model/resource_state.dart';
import 'package:test/presentation/pages/bottom_nav/bottom_nav_page.dart';
import 'package:test/presentation/pages/splash_page/splash_page.dart';
import 'package:test/provider/auth_provider.dart';
import 'package:test/provider/top_level_navigation_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final AuthProvider _authProvider;
  late final TopLevelNavigationProvider _topLevelNavigationProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final VoidCallback onAuthChange;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  bool _isPasswordTextObscure = true;
  bool _isConfirmPasswordTextObscure = true;

  void _showErrorMessage(DescribableError error, BuildContext context) async {
    String errorMessage = error.description;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onAuthChange = () {
      switch (_authProvider.registerState.status) {
        case Status.SUCCESS:
          Navigator.of(_topLevelNavigationProvider
                  .topLevelNavigation.currentContext!)
              .pushReplacement(
            MaterialPageRoute(
              builder: (context) => const BottomNavigationPage(),
            ),
          );
          break;
        case Status.ERROR:
          setState(() {
            _isLoading = false;
            _showErrorMessage(_authProvider.registerState.error!, context);
          });
          break;
        case Status.LOADING:
          setState(
            () {
              _isLoading = true;
            },
          );
          break;
        case Status.NONE:
          setState(
            () {
              _isLoading = false;
            },
          );
          break;
        default:
      }
    };
    _authProvider.addListener(onAuthChange);
  }

  @override
  void dispose() {
    super.dispose();
    _authProvider.removeListener(onAuthChange);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_isLoading) {
      body = const SplashPage();
    } else {
      body = Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        body: SafeArea(
          child: LayoutBuilder(builder:
            (BuildContext buildContext, BoxConstraints boxConstraints) {
              var listwidth=boxConstraints.maxWidth-80;
              if( boxConstraints.maxWidth>600){
                listwidth=boxConstraints.maxWidth/2.2;
              }

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: listwidth,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(256),
                                  ],
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    labelText: "Enter a username",
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).colorScheme.error),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).colorScheme.error),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "You must enter a username";
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
                                  obscureText: _isPasswordTextObscure,
                                  autocorrect: false,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(256),
                                  ],
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(_isPasswordTextObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordTextObscure =
                                              !_isPasswordTextObscure;
                                        });
                                      },
                                    ),
                                    labelText: "Enter a password",
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).colorScheme.error),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).colorScheme.error),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter a password";
                                    }
                                    if (value.length < 8) {
                                      return "Passwords must be at least 8 characters long";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) =>
                                      _passwordController.text = value ?? "",
                                ),
                                const Divider(
                                  height: 20,
                                  color: Colors.transparent,
                                ),
                                TextFormField(
                                  obscureText: _isConfirmPasswordTextObscure,
                                  autocorrect: false,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(256),
                                  ],
                                  controller: _confirmPasswordController,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(_isConfirmPasswordTextObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isConfirmPasswordTextObscure =
                                              !_isConfirmPasswordTextObscure;
                                        });
                                      },
                                    ),
                                    labelText: "Confirm your password",
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).colorScheme.error),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).colorScheme.error),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "You must confirm your password";
                                    }
                                    if (_passwordController.text !=
                                        _confirmPasswordController.text) {
                                      return "Passwords don't match";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) =>
                                      _confirmPasswordController.text = value ?? "",
                                ),
                                const Divider(
                                  height: 35,
                                  thickness: 0,
                                ),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.black38,
                                        width:
                                            2), // change the color and width as needed
                                    minimumSize: const Size(
                                        200, 60), // change the size as needed
                                  ),
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize:
                                          20, // change the font size as needed
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      _authProvider.register(
                                          _usernameController.text,
                                          _passwordController.text);
                                    }
                                  },
                                ),
                                Divider(
                                  color: Colors.transparent,
                                  height: 2 / 30 * boxConstraints.maxHeight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    return body;
  }
}
