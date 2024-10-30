import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/login/login_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/login/login_event.dart';
import '../blocs/login/login_state.dart';
import '../utils/constants/app_strings.dart';
import '../widgets/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController =
      TextEditingController(text: 'teste');
  final TextEditingController _passwordController =
      TextEditingController(text: 'senha');

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    context.read<LoginBloc>().add(LoginButtonPressed(
          username: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        ));
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocProvider(
        create: (_) => LoginBloc(),
        child: GestureDetector(
          onTap: _dismissKeyboard,
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                _dismissKeyboard();
                Future.delayed(const Duration(milliseconds: 50), () {
                  CustomSnackBar.show(context, state.error);
                });
              } else if (state is LoginSuccess) {
                context.go('/home');
              }
            },
            builder: (context, state) {
              return _loginForm(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 44.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/splash_logo.png',
              height: 150,
            ),
            const SizedBox(height: 30),
            _textField(
              controller: _usernameController,
              labelText: AppStrings.usernameLabel,
              prefixIcon: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(height: 16),
            _textField(
              controller: _passwordController,
              labelText: AppStrings.passwordLabel,
              prefixIcon: const Icon(Icons.lock, color: Colors.white),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleLogin(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  AppStrings.loginButton,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String labelText,
    required Icon prefixIcon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }
}
