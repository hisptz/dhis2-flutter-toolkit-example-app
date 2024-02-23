import 'package:dhis2_flutter_toolkit/components/SystemInfo.dart';
import 'package:dhis2_flutter_toolkit/components/UserInfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            Intl.message("Home"),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
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
                    context.push("/programs");
                  },
                  child: const Text("Programs"))
            ],
          ),
        ),
      ),
    );
  }
}
