import 'package:flutter/material.dart';
import 'package:project/services/navigation_service.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/routes.dart';
import 'package:project/view_models/login_viewmodel.dart';
import 'package:project/widgets/round_button.dart';
import 'package:project/widgets/screen_starter.dart';
import 'package:project/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenStarter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [
          RecycleLogo(),
          SizedBox(height: 40),
          LoginForm(),
        ],
      ),
    );
  }
}

class RecycleLogo extends StatelessWidget {
  const RecycleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(ImagePaths.recycleLogo),
          height: 100,
        ),
        Text("RecyclablesAI"),
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  final _vm = LoginViewModel();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          RecycleTextField(
            controller: _emailController,
            hintText: "Email",
            prefixIcon: const Icon(Icons.email),
            validator: (email) => _vm.validateEmail(email),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          RecycleTextField(
            controller: _passwordController,
            hintText: "Password",
            validator: (password) => _vm.validatePassword(password),
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_isPasswordVisible,
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
              splashRadius: 15,
              icon: _isPasswordVisible
                  ? const Icon(Icons.remove_red_eye_outlined)
                  : const Icon(Icons.remove_red_eye_rounded),
              iconSize: 20,
              onPressed: () => _togglePasswordVisibility(),
            ),
          ),
          const SizedBox(height: 40),
          RecycleButton(
            onPressed: () {
              String email = _emailController.text.trim();
              String password = _passwordController.text;
              _vm.validateThen(
                _formKey,
                () => _vm.handleLogin(email, password),
              );
            },
            text: "Log in",
            backgroundColor: Colors.blueGrey[900]!,
            textColor: Colors.white,
          ),
          const SizedBox(height: 40),
          const Text("Don't have an account?"),
          TextButton(
            onPressed: () {
              NavigationService.pushReplacementNamed(RouteNames.register);
            },
            child: Text(
              "Register",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blueGrey[900],
              ),
            ),
            // backgroundColor: Colors.blueGrey[900]!,
            // textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
