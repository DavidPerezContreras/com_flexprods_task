import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/config/config.dart';
import 'package:test/domain/model/describable_error.dart';
import 'package:test/domain/model/resource_state.dart';
import 'package:test/presentation/pages/bottom_nav/bottom_nav_page.dart';
import 'package:test/presentation/pages/login/register_page.dart';
import 'package:test/presentation/pages/splash_page/splash_page.dart';
import 'package:test/provider/auth_provider.dart';
import 'package:test/provider/theme_provider.dart';
import 'package:test/provider/top_level_navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthProvider _authProvider;
  late final TopLevelNavigationProvider _topLevelNavigationProvider;
  late final ThemeProvider _themeProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordTextObscure = true;
  late final VoidCallback onAuthChange;
  bool _isLoading = true;

  Future<void> _launchURL(Uri url) async {
    await canLaunchUrl(url)
        ? await launchUrl(url, mode: LaunchMode.externalApplication)
        : throw 'Could not launch $url';
  }

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
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    onAuthChange = () {
      switch (_authProvider.loginState.status) {
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
            _showErrorMessage(_authProvider.loginState.error!, context);
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //await Future.delayed(const Duration(seconds: 1));
      _authProvider.fastLogin("", "");
    });
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
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context,BoxConstraints) {
                return Container(
                  alignment: Alignment.center,

//                  height: double.infinity,
 //                 width: double.infinity,
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: 500+BoxConstraints.maxHeight/6,
                        width: 600,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration:
                                      BoxDecoration(border: Border.all(width: 8)),
                                  child: const Image(
                                    fit: BoxFit.scaleDown,
                                    image: AssetImage(
                                      "assets/logo/bee_task_logo.png",
                                    ),
                                  ),
                                ),
                                Divider(height: BoxConstraints.maxHeight/6,),
                                TextFormField(
                                  autocorrect: false,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(256),
                                  ],
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    labelText: 'Enter your username',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).colorScheme.secondary),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.error),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.error),
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
                                    labelText: 'Enter your password',
                                    labelStyle: TextStyle(
                                        color: Theme.of(context).colorScheme.onSurface),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).colorScheme.secondary),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.error),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.error),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).colorScheme.primary),
                                    ),
                                  ),
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
                                        width:
                                            2), // change the color and width as needed
                                    minimumSize: const Size(
                                        200, 60), // change the size as needed
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
                                const Flexible(
                                    child: Text("You don't have an account?")),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(_topLevelNavigationProvider
                                            .topLevelNavigation.currentContext!)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (context) => const RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        icon: const Image(
                                            height: 50,
                                            image: AssetImage(
                                                'assets/images/linkedin_logo.png')),
                                        onPressed: ()  => _launchURL(linkedInUrl),
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        icon: Image(
                                            height: 50,
                                            image: _themeProvider.isDarkMode
                                                ? const AssetImage(
                                                    'assets/images/github_logo_light.png')
                                                : const AssetImage(
                                                    'assets/images/github_logo.png')),
                                        onPressed: ()  => _launchURL(githubUrl),
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
                );
              }
            ),
          ));
    }

    return body;
  }
}
