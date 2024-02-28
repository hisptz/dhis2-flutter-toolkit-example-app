import 'package:dhis2_flutter_toolkit/models/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/dataElement.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/legend.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/legendSet.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/option.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/optionSet.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/program.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRule.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRuleAction.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programRuleVariable.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programSection.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStage.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStageDataElement.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programStageSection.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/programTrackedEntityAttribute.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityAttribute.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/trackedEntityType.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';
import 'package:dhis2_flutter_toolkit/syncServices/syncStatus.dart';

class D2ProgramSync extends BaseSyncService<D2Program> {
  List<String> programIds;
  late List<D2Program> programs;

  D2ProgramSync(ObjectBox db, this.programIds)
      : super(
          label: "Programs",
          filters: ["id:in:[${programIds.join(",")}]"],
          db: db,
          resource: "programs",
        );

  @override
  D2Program mapper(Map<String, dynamic> json) {
    return D2Program.fromMap(db, json);
  }

  syncMeta(key, value) {
    switch (key) {
      case "dataElements":
        return D2DataElementRepository(db).saveOffline(value);
      case "options":
        return D2OptionRepository(db).saveOffline(value);
      case "optionSets":
        return D2OptionSetRepository(db).saveOffline(value);
      case "programRuleVariables":
        return D2ProgramRuleVariableRepository(db).saveOffline(value);
      case "programTrackedEntityAttributes":
        return D2ProgramTrackedEntityAttributeRepository(db).saveOffline(value);
      case "programStageDataElements":
        return D2ProgramStageDataElementRepository(db).saveOffline(value);
      case "programStages":
        return D2ProgramStageRepository(db).saveOffline(value);
      case "programRuleActions":
        return D2ProgramRuleActionRepository(db).saveOffline(value);
      case "trackedEntityAttributes":
        return D2TrackedEntityAttributeRepository(db).saveOffline(value);
      case "trackedEntityTypes":
        return D2TrackedEntityTypeRepository(db).saveOffline(value);
      case "programs":
        return D2ProgramRepository(db).saveOffline(value);
      case "programRules":
        return D2ProgramRuleRepository(db).saveOffline(value);
      case "legends":
        return D2LegendRepository(db).saveOffline(value);
      case "legendSets":
        return D2LegendSetRepository(db).saveOffline(value);
      case "programSections":
        return D2ProgramSectionRepository(db).saveOffline(value);
      case "programStageSections":
        return D2ProgramStageSectionRepository(db).saveOffline(value);
    }
  }

  List<String> sortOrder = [
    "optionSets",
    "options",
    "legendSets",
    "legends",
    "dataElements",
    "trackedEntityAttributes",
    "trackedEntityTypes",
    "programs",
    "programRuleVariables",
    "programRules",
    "programRuleActions",
    "programTrackedEntityAttributes",
    "programSections",
    "programStages",
    "programStageDataElements",
    "programStageSections",
  ];

  Future<void> syncProgram(String programId) async {
    Map<String, dynamic>? programMetadata = await dhis2client
        ?.httpGet<Map<String, dynamic>>("programs/$programId/metadata");

    if (programMetadata == null) {
      throw "Error getting program $programId";
    }

    List<MapEntry<String, dynamic>> metadataEntries = programMetadata.entries
        .where((element) => sortOrder.contains(element.key))
        .toList();
    metadataEntries.sort(
        (a, b) => sortOrder.indexOf(a.key).compareTo(sortOrder.indexOf(b.key)));

    await Future.forEach(metadataEntries,
        (MapEntry<String, dynamic> element) async {
      if (element.key == "system") {
        return;
      }

      List<Map<String, dynamic>> value =
          element.value.cast<Map<String, dynamic>>();
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
