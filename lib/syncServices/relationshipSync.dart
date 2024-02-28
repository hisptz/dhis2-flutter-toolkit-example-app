import 'package:dhis2_flutter_toolkit/models/data/fromRelationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/models/data/toRelationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/fromRelationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/relationship.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/toRelationship.dart';
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
    return Relationship.fromMap(json, relationshipType);
  }

  @override
  Future syncPage(int page) async {
    Map<String, dynamic>? data = await getData<Map<String, dynamic>>(page);
    if (data == null) {
      throw "Error getting data for page $page";
    }

    List<Map<String, dynamic>> entityData =
        data[dataKey ?? resource].cast<Map<String, dynamic>>();

    List<Map<String, dynamic>> fromData = relationshipType == "trackedEntity"
        ? entityData
            .map((data) => {
                  "relationshipId": data["relationship"],
                  "from": data["from"]["trackedEntity"]
                })
            .toList()
        : relationshipType == "enrollment"
            ? entityData
                .map((data) => {
                      "relationshipId": data["relationship"],
                      "from": data["from"]["enrollment"]
                    })
                .toList()
            : entityData
                .map((data) => {
                      "id": data["from"]["event"]["event"],
                      "relationshipId": data["relationship"],
                      "from": data["from"]["event"]
                    })
                .toList();

    List<Map<String, dynamic>> toData = relationshipType == "trackedEntity"
        ? entityData
            .map((data) => {
                  "relationshipId": data["relationship"],
                  "to": data["to"]["trackedEntity"]
                })
            .toList()
        : relationshipType == "enrollment"
            ? entityData
                .map((data) => {
                      "relationshipId": data["relationship"],
                      "to": data["to"]["enrollment"]
                    })
                .toList()
            : entityData
                .map((data) => {
                      "relationshipId": data["relationship"],
                      "to": data["to"]["event"]
                    })
                .toList();

    final fromValue = fromData
        .cast<Map>()
        .map((data) => FromRelationship.fromMap(
            data["from"], relationshipType, data["relationshipId"]))
        .toList();

    final toValue = toData
        .cast<Map>()
        .map((data) => ToRelationship.fromMap(
            data["to"], relationshipType, data["relationshipId"]))
        .toList();

    await fromRelationshipBox.putAndGetManyAsync(fromValue);
    await toRelationshipBox.putAndGetManyAsync(toValue);

    List<Relationship> entities = entityData.map(mapper).toList();

    await box.putManyAsync(entities);
  }
}
