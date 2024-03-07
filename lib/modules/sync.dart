import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../state/client.dart';
import '../state/db.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  String currentSyncLabel = "";
  late D2MetadataDownloadService metadataSyncService;

  int progress = 0;

  @override
  void initState() {
    final db = Provider.of<DBProvider>(context, listen: false).db;
    final client =
        Provider.of<D2HttpClientProvider>(context, listen: false).client;
    metadataSyncService = D2MetadataDownloadService(db, client);
    metadataSyncService.download().then((value) {
      context.replace("/");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<D2SyncStatus>(
      stream: metadataSyncService.stream,
      builder: (context, data) {
        D2SyncStatus? status = data.data;
        var error = data.error;
        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Intl.message("Syncing In Progress",
                    name: "_SyncPageState_build", args: [context]),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              status != null
                  ? Text(
                      "Syncing ${status.label} ${status.synced}/${status.total}")
                  : const Text("Please wait..."),
              error != null ? Text(error.toString()) : const Text(""),
            ],
          ),
        ));
      },
    );
  }
}
