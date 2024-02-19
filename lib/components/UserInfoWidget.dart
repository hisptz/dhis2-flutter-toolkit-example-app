import 'package:dhis2_flutter_toolkit/components/DetailsRow.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/user.dart';
import 'package:dhis2_flutter_toolkit/repositories/user.dart';
import 'package:flutter/material.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  bool loading = false;
  D2UserRepository repository = D2UserRepository();
  D2User? info;

  @override
  void initState() {
    setState(() {
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
            "User Information",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          DetailsRow(label: "First Name", value: info?.firstName ?? ""),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          DetailsRow(label: "Last Name", value: info?.surname ?? ""),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          DetailsRow(label: "Username", value: info?.username ?? ""),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          DetailsRow(
              label: "Authorities", value: info?.authorities.join(", ") ?? ""),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
          DetailsRow(
              label: "User Groups",
              value: info?.userGroups
                      .map((group) => group.name)
                      .toList()
                      .join(", ") ??
                  "")
        ],
      ),
    );
  }
}
