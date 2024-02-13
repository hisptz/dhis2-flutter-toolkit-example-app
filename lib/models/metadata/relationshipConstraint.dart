import 'package:dhis2_flutter_toolkit/models/metadata/RelationshipType.dart';
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
      this.relationshipEntity,this.name);
}
