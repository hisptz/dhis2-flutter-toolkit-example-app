import 'package:dhis2_flutter_toolkit/components/SystemInfo.dart';
import 'package:dhis2_flutter_toolkit/components/UserInfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SystemInfoWidget(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              const UserInfoWidget(),
              TextButton(
                  onPressed: () {
                    context.go("/programs");
                  },
                  child: const Text("Programs"))
            ],
          ),
        ),
      ),
    );
  }
}
