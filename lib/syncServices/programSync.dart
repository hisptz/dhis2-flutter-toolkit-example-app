import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class D2ProgramSync extends BaseSyncService<D2Program> {
  List<String> programIds;
  late List<D2Program> programs;

  D2ProgramSync(this.programIds)
      : super(
          label: "Program",
          filters: ["id:in:[${programIds.join(",")}]"],
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
          resource: "programs",
        );

  @override
  D2Program mapper(Map<String, dynamic> json) {
    return D2Program.fromMap(json);
  }
}
