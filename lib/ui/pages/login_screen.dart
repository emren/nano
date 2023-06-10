import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:nano/ui/pages/store_page.dart';
import 'package:nano/ui/theme/palette.dart';
import 'package:provider/provider.dart';

import '../../core/providers/store_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode focusQuestion = FocusNode();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var storeProvider = Provider.of<StoreProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          logoWidget(height, width),
          authWidget(height, width, storeProvider, context),
        ],
      ),
    );
  }

  Container authWidget(double height, double width, StoreProvider storeProvider,
      BuildContext context) {
    return Container(
      height: height / 2,
      width: width,
      color: Colors.white,
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Container(
              width: 300,
              child: Column(
                children: [
                  TextFormField(
                    textCapitalization: TextCapitalization.none,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: SizedBox(
                        width: 5,
                        height: 5,
                        child: Image.asset(
                          'assets/check.png',
                        ),
                      ),
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    onFieldSubmitted: (value) async {},
                    textInputAction: TextInputAction.next,
                    cursorWidth: 1.2,
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: SizedBox(
                        width: 5,
                        height: 5,
                        child: Image.asset(
                          'assets/eye.png',
                        ),
                      ),
                      labelText: 'Password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    onFieldSubmitted: (value) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    focusNode: focusQuestion,
                    textInputAction: TextInputAction.done,
                    cursorWidth: 1.2,
                    validator: (value) {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 270,
            height: 65,
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      const MaterialStatePropertyAll(Palette.light_blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Palette.light_blue)))),
              onPressed: () async {
                var isAuthed = await storeProvider.auth(email, password);
                if (isAuthed) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StorePage(),
                    ),
                  );
                }
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NEED HELP?',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container logoWidget(double height, double width) {
    return Container(
      height: height / 2,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Palette.dark_blue,
          Palette.light_blue,
        ]),
      ),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/nano.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          const AlignPositioned(
            alignment: Alignment.bottomCenter,
            dx: -110,
            dy: -20,
            child: Text(
              'Log In',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SF Pro Display',
                  fontSize: 34,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
