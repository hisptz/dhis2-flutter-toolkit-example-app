import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';

import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';

import 'package:dhis2_flutter_toolkit/syncServices/baseTrackerData.dart';

class RelationshipSync extends BaseTrackerSyncService<Relationship> {
  String relationshipType;
  String id;

  RelationshipSync(this.relationshipType, this.id)
      : super(
          label: "Relatioships($relationshipType)",
          fields: [
            "*",
          ],
          box: relationshipBox,
          resource: "tracker/relationships",
          extraParams: {relationshipType: id},
          dataKey: "instances",
        );

  @override
  Relationship mapper(Map<String, dynamic> json) {
    return Relationship.fromMap(json);
  }
}
