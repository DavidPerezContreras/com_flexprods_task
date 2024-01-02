import 'package:flutter/material.dart';
import 'package:nested_navigation/domain/model/describable_error.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/bottom_nav_page.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:nested_navigation/provider/top_level_navigation_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  bool _isLoading = false;

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
            _showErrorMessage(_authProvider.registerState.error!, context);
          });
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                          TextFormField(
                            maxLength: 256,
                            controller: _usernameController,
                            decoration: InputDecoration(
                              labelText: 'Enter your username',
                              labelStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                            maxLength: 256,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Enter your password',
                              labelStyle: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
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
                              "Register",
                              style: TextStyle(
                                fontSize: 20, // change the font size as needed
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _authProvider.register(_usernameController.text,
                                    _passwordController.text);
                              }
                            },
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 2 / 30 * viewportConstraints.maxHeight,
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
}
