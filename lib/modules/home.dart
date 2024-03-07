import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/SystemInfo.dart';
import '../components/UserInfoWidget.dart';
import '../state/db.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  D2AuthService authService = D2AuthService();
                  authService.logoutUser().then((value) {
                    Provider.of<DBProvider>(context, listen: false).close();
                    context.replace("/");
                  });
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
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
                  child: const Text("Programs")),
              TextButton(
                  onPressed: () {
                    context.push("/data-sync");
                  },
                  child: const Text("Tracked Data Download")),
              TextButton(
                  onPressed: () {
                    context.push("/data-upload");
                  },
                  child: const Text("Tracked Data Upload")),
              TextButton(
                  onPressed: () {
                    context.push("/tei");
                  },
                  child: const Text("Tracked Entity Instances"))
            ],
          ),
        ),
      ),
    );
  }
}
