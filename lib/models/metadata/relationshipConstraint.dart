import 'package:dhis2_flutter_toolkit/models/metadata/relationshipType.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityType.dart';
import 'package:objectbox/objectbox.dart';

import 'program.dart';
import 'programStage.dart';

class RelationshipConstraint {
  String relationshipEntity;
  String name;

  final trackedEntityType = ToOne<TrackedEntityType>();
  final relationshipType = ToOne<RelationshipType>();
  final program = ToOne<Program>();
  final programStage = ToOne<ProgramStage>();

  RelationshipConstraint(
      {required this.relationshipEntity, required this.name});

  RelationshipConstraint.fromMao(Map json)
      : relationshipEntity = json["relationshipEntity"],
        name = json["name"];
}
