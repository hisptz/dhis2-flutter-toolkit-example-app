import 'package:dhis2_flutter_toolkit/state/client.dart';
import 'package:dhis2_flutter_toolkit/state/db.dart';
import 'package:dhis2_flutter_toolkit/syncServices/metadataSync.dart';
import 'package:dhis2_flutter_toolkit/utils/download_status.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    return StreamBuilder<DownloadStatus>(
      stream: metadataSyncService.stream,
      builder: (context, data) {
        DownloadStatus? status = data.data;
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
