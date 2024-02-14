import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/utils.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  final TextEditingController _baseURLController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future onLogin() async {
    setState(() {
      loading = true;
    });
    String baseURL = _baseURLController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;

    DHIS2Credentials? credentials =
        await login(baseURL: baseURL, username: username, password: password);

    if (credentials != null) {
      await credentials.saveToPreference();
      print(credentials);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                keyboardType: TextInputType.url,
                controller: _baseURLController,
                decoration: InputDecoration(
                    prefixText: "https://",
                    border: const OutlineInputBorder(),
                    isDense: true,
                    prefixIcon: Icon(
                      Icons.public,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: const Text("DHIS2 URL")),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    isDense: true,
                    prefixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: const Text("Username")),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    isDense: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: const Text("Password")),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextButton(
                onPressed: onLogin,
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Theme.of(context).primaryColor)),
                child: Text(
                  loading ? "Please wait..." : "Login",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
