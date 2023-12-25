import 'package:flutter/material.dart';
import 'package:nested_navigation/data/auth/remote/error/auth_errors.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/domain/model/user.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/provider/auth_navigation_provider.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/content_page.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthNavigation extends StatefulWidget {
  const AuthNavigation({super.key});

  @override
  State<AuthNavigation> createState() => _AuthNavigationState();
}

class _AuthNavigationState extends State<AuthNavigation> {
  late final AuthProvider _authProvider;
  late final AuthNavigationProvider _authNavigationProvider;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _authNavigationProvider =
        Provider.of<AuthNavigationProvider>(context, listen: false);

    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _authProvider.addListener(_handleAuthChange);
  }

  void _handleAuthChange() {
    ResourceState<User> _userState = _authProvider.userState;

    switch (_userState.status) {
      case Status.SUCCESS:
        setState(() {
          _isLoading = false;
          _authNavigationProvider
              .navigate(const MaterialPage(child: ContentPage()));
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
            _showErrorMessage(_userState.error!);
          },
        );
        break;
      case Status.NONE:
        setState(
          () {
            _isLoading = false;
            _authNavigationProvider.logout();
          },
        );
        break;
      default:
    }
  }

  void _showErrorMessage(DescriptableError error) async {
    String errorMessage = error.description;

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
    );

    _authProvider.logout();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading Indicator'),
        ),
        body: Center(
          child: Container(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Scaffold(
      body: Navigator(
        key: _authNavigationProvider.authNavigation,
        pages: [_authNavigationProvider.activePage],
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return true;
          }
          return true;
        },
      ),
    );
  }
}
