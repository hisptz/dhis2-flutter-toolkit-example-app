import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/option.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/optionSet.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRule.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRuleAction.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRuleVariable.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStageDataElement.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programTrackedEntityAttribute.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityAttribute.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityType.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';

class D2ProgramSync extends BaseSyncService<D2Program> {
  List<String> programIds;
  late List<D2Program> programs;

  D2ProgramSync(this.programIds)
      : super(
          label: "Programs",
          filters: ["id:in:[${programIds.join(",")}]"],
          box: programBox,
          resource: "programs",
        );

  @override
  D2Program mapper(Map<String, dynamic> json) {
    return D2Program.fromMap(json);
  }

  syncMeta(key, value) {
    switch (key) {
      case "dataElements":
        return D2DataElementRepository().saveOffline(value);
      case "options":
        return D2OptionRepository().saveOffline(value);
      case "optionSets":
        return D2OptionSetRepository().saveOffline(value);
      case "programRuleVariables":
        return D2ProgramRuleVariableRepository().saveOffline(value);
      case "programTrackedEntityAttributes":
        return D2ProgramTrackedEntityAttributeRepository().saveOffline(value);
      case "programStageDataElements":
        return D2ProgramStageDataElementRepository().saveOffline(value);
      case "programStages":
        return D2ProgramStageRepository().saveOffline(value);
      case "programRuleActions":
        return D2ProgramRuleActionRepository().saveOffline(value);
      case "trackedEntityAttributes":
        return D2TrackedEntityAttributeRepository().saveOffline(value);
      case "trackedEntityTypes":
        return D2TrackedEntityTypeRepository().saveOffline(value);
      case "programs":
        return D2ProgramRepository().saveOffline(value);
      case "programRules":
        return D2ProgramRuleRepository().saveOffline(value);
    }
  }

  Future<void> syncProgram(String programId) async {
    Map<String, dynamic>? programMetadata = await dhis2client
        ?.httpGet<Map<String, dynamic>>("programs/$programId/metadata");

    if (programMetadata == null) {
      throw "Error getting program $programId";
    }

    await Future.forEach(programMetadata.entries,
        (MapEntry<String, dynamic> element) async {
      if (element.key == "system") {
        return;
      }

      List<Map<String, dynamic>> value =
          element.value.cast<Map<String, dynamic>>();
      print(value);
      await syncMeta(element.key, value);
    });
  }

  @override
  Future setupSync() async {
    SyncStatus status = SyncStatus(
        synced: 0,
        total: programIds.length,
        status: Status.initialized,
        label: label);
    controller.add(status);

    for (final programId in programIds) {
      await syncProgram(programId);
      controller.add(status.increment());
    }
    controller.add(status.complete());
    controller.close();
  }
}
