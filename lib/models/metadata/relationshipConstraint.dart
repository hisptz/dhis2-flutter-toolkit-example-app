import 'package:dhis2_flutter_toolkit/models/base.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/relationshipType.dart';
import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityType.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class D2RelationshipConstraint extends DHIS2Resource {
  int id = 0;
  String relationshipEntity;
  String name;

  final trackedEntityType = ToOne<D2TrackedEntityType>();

  final relationshipType = ToOne<D2RelationshipType>();

  final program = ToOne<D2Program>();

  final programStage = ToOne<D2ProgramStage>();

  D2RelationshipConstraint(
      {required this.relationshipEntity, required this.name});

  D2RelationshipConstraint.fromMao(Map json)
      : relationshipEntity = json["relationshipEntity"],
        name = json["name"];
}
