import 'package:dhis2_flutter_toolkit/syncServices/base.dart';
import 'package:dhis2_flutter_toolkit/syncServices/metadataSync.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  String currentSyncLabel = "";
  MetadataSync metadataSyncService = MetadataSync();
  int progress = 0;
  List<BaseSyncService> unSyncedMeta = [];

  @override
  void initState() {
    metadataSyncService.sync().then((value) {
      context.go("/home");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SyncStatus>(
      stream: metadataSyncService.stream,
      builder: (context, data) {
        SyncStatus? status = data.data;
        var error = data.error;

        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Syncing Metadata",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              status != null
                  ? Text(
                      "Syncing ${status.label} ${status.synced}/${status.total}")
                  : const Text("Please wait..."),
              error != null ? Text(error.toString()) : Text(""),
            ],
          ),
        ));
      },
    );
  }
}
