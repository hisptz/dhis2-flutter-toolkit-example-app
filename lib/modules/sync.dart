import 'package:dhis2_flutter_toolkit/modules/home.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';
import 'package:dhis2_flutter_toolkit/syncServices/metadataSync.dart';
import 'package:flutter/material.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  bool loading = false;
  bool syncing = false;
  String currentSyncLabel = "";
  MetadataSync metadataSyncService = MetadataSync();
  int progress = 0;
  List<BaseSyncService> unSyncedMeta = [];

  initializeSync() async {
    if (unSyncedMeta.isNotEmpty) {
      setState(() {
        syncing = true;
      });
      await Future.forEach(unSyncedMeta, (element) {
        setState(() {
          currentSyncLabel = element.label;
        });
        element.sync().then((value) {
          setState(() {
            progress = progress + 1;
            currentSyncLabel = "";
          });
        });
      });
      setState(() {
        syncing = false;
      });
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    metadataSyncService.checkUnSynced().then((value) {
      setState(() {
        unSyncedMeta = value;
        loading = false;
      });
      initializeSync();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double progressPercentage = progress / (unSyncedMeta.length + 1) * 100;

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: loading
              ? [
                  const CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.all(16.0)),
                  Text("Checking for metadata...")
                ]
              : [
                  LinearProgressIndicator(
                    value: progressPercentage,
                  ),
                  Padding(padding: EdgeInsets.all(16.0)),
                  Text("Syncing $currentSyncLabel")
                ],
        ),
      ),
    );
  }
}
