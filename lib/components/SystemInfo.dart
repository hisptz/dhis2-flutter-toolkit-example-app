import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:dhis2_flutter_toolkit_example_app/state/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SystemInfoWidget extends StatefulWidget {
  const SystemInfoWidget({super.key});

  @override
  State<SystemInfoWidget> createState() => _SystemInfoWidgetState();
}

class _SystemInfoWidgetState extends State<SystemInfoWidget> {
  bool loading = false;
  late D2SystemInfoRepository repository;
  D2SystemInfo? info;

  @override
  void initState() {
    setState(() {
      final db = Provider.of<DBProvider>(context, listen: false).db;
      repository = D2SystemInfoRepository(db);
      info = repository.get();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "System Information",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(info?.systemName ?? "")
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Version",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(info?.version ?? "")
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "System ID",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(info?.systemId ?? "")
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Calendar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(info?.calendar ?? "")
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Context Path",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(info?.contextPath ?? "")
            ],
          ),
        ],
      ),
    );
  }
}
