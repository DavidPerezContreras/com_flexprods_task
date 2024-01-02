import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nested_navigation/config/config.dart';
import 'package:nested_navigation/domain/model/describable_error.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/bottom_nav_page.dart';
import 'package:nested_navigation/presentation/pages/login/register_page.dart';
import 'package:nested_navigation/presentation/pages/splash_page/splash_page.dart';
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
  late final AuthProvider _authProvider;
  late final TopLevelNavigationProvider _topLevelNavigationProvider;
  late final ThemeProvider _themeProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
      await Future.delayed(const Duration(seconds: 1));
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
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration:
                                  BoxDecoration(border: Border.all(width: 8)),
                              child: const Image(
                                fit: BoxFit.scaleDown,
                                image: AssetImage(
                                  "assets/banner/flex_task_banner.png",
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.transparent,
                              height: 2 / 30 * viewportConstraints.maxHeight,
                            ),
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(256),
                              ],
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Enter your username',
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(256),
                              ],
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Enter your password',
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
                                    width:
                                        2), // change the color and width as needed
                                minimumSize: const Size(
                                    200, 60), // change the size as needed
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize:
                                      20, // change the font size as needed
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
                            Divider(
                              color: Colors.transparent,
                              height: 2 / 30 * viewportConstraints.maxHeight,
                            ),
                            const Flexible(
                                child: Text("You don't have an account?")),
                            TextButton(
                              onPressed: () {
                                Navigator.of(_topLevelNavigationProvider
                                        .topLevelNavigation.currentContext!)
                                    .pushReplacement(
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
                                    onPressed: () => _launchURL(linkedInUrl),
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
              );
            },
          ),
        ),
      );
    }

    return body;
  }
}
