import 'package:dhis2_flutter_toolkit/components/SystemInfo.dart';
import 'package:dhis2_flutter_toolkit/components/UserInfoWidget.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/state/db.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                  D2Credential credentials = D2Credential.fromPreferences();
                  Provider.of<DbProvider>(context, listen: false).close();
                  credentials.logout().then((_) => context.replace("/"));
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
