import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../state/client.dart';
import '../state/db.dart';

class TrackerDataSyncPage extends StatefulWidget {
  const TrackerDataSyncPage({super.key});

  @override
  State<TrackerDataSyncPage> createState() => _TrackerDataSyncPageState();
}

class _TrackerDataSyncPageState extends State<TrackerDataSyncPage> {
  String currentSyncLabel = "";
  late D2TrackerDataDownloadService trackerDataDownloadService;

  int progress = 0;

  @override
  void initState() {
    final db = Provider.of<DBProvider>(context, listen: false).db;
    final client =
        Provider.of<D2HttpClientProvider>(context, listen: false).client;
    trackerDataDownloadService = D2TrackerDataDownloadService(db, client);
    trackerDataDownloadService.download().then((value) {
      context.pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<D2SyncStatus>(
      stream: trackerDataDownloadService.downloadStream,
      builder: (context, data) {
        D2SyncStatus? status = data.data;
        var error = data.error;

        String message = status?.status == D2SyncStatusEnum.initialized
            ? "Initializing download of ${status?.label}"
            : "Syncing ${status?.label} ${status?.synced}/${status?.total}";

        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Intl.message("Downloading Data In Progress",
                    name: "_SyncPageState_build", args: [context]),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              status != null
                  ? status.status == D2SyncStatusEnum.complete &&
                          status.label == "All"
                      ? Column(
                          children: [
                            const Text("Done!"),
                            TextButton(
                                onPressed: () {
                                  context.go("/tei");
                                },
                                child: const Text("Go to data"))
                          ],
                        )
                      : Text(message)
                  : const Text("Please wait..."),
              error != null ? Text(error.toString()) : const Text(""),
            ],
          ),
        ));
      },
    );
  }
}
