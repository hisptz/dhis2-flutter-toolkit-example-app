import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class D2OrgUnitSync extends BaseSyncService<OrganisationUnit> {
  List<String> orgUnitIds;

  D2OrgUnitSync(this.orgUnitIds)
      : super(
          label: "Organisation Unit",
          fields: [
            "*",
          ],
          extraParams: {"withinUserHierarchy": "true"},
          box: organisationUnitBox,
          resource: "organisationUnits",
        );

  @override
  OrganisationUnit mapper(Map<String, dynamic> json) {
    return OrganisationUnit.fromMap(json);
  }
}
