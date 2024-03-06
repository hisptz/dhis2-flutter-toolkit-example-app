import 'package:dhis2_flutter_toolkit/state/client.dart';
import 'package:dhis2_flutter_toolkit/state/db.dart';
import 'package:dhis2_flutter_toolkit/syncServices/trackerDataSync.dart';
import 'package:dhis2_flutter_toolkit/utils/download_status.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TrackerDataSyncPage extends StatefulWidget {
  const TrackerDataSyncPage({super.key});

  @override
  State<TrackerDataSyncPage> createState() => _TrackerDataSyncPageState();
}

class _TrackerDataSyncPageState extends State<TrackerDataSyncPage> {
  String currentSyncLabel = "";
  late D2TrackerDataDownload trackerDataDownloadService;

  int progress = 0;

  @override
  void initState() {
    final db = Provider.of<DBProvider>(context, listen: false).db;
    final client =
        Provider.of<D2HttpClientProvider>(context, listen: false).client;
    trackerDataDownloadService = D2TrackerDataDownload(db, client);
    trackerDataDownloadService.download().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DownloadStatus>(
      stream: trackerDataDownloadService.downloadStream,
      builder: (context, data) {
        DownloadStatus? status = data.data;
        var error = data.error;

        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Intl.message("Syncing Data In Progress",
                    name: "_SyncPageState_build", args: [context]),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              status != null
                  ? status.status == Status.complete && status.label == "All"
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
                      : Text(
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
