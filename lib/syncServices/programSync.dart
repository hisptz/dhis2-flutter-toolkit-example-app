import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class D2ProgramSync extends BaseSyncService<D2Program> {
  String programId;

  D2ProgramSync(this.programId)
      : super(
            label: "Program",
            fields: [
              "*",
              "programTrackedEntityAttributes[*,trackedEntityAttribute[*,legendSets[*,legends[*]]]]",
              "programStages[*,programStageDataElements[*,dataElement[*,legendSets[*,legends[*]]]],programStageSections[*]]",
              "programRules[*,programRuleActions[*]]",
              "programRuleVariables[*]",
              "programSections[*]",
              "attributeValues[*,attribute[*]]",
            ],
            box: programBox,
            resource: "programs/$programId");

  @override
  Future<BaseSyncService<D2Program>> get() async {
    Map? programMetadata = await getData<Map>();
    if (programMetadata != null) {
      entity = D2Program.fromMap(programMetadata);
    }
    return this;
  }
}
