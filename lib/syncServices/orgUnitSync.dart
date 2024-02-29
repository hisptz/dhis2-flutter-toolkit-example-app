import 'package:dhis2_flutter_toolkit/models/metadata/organisationUnit.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:dhis2_flutter_toolkit/syncServices/base.dart';

class D2OrgUnitSync extends BaseSyncService<D2OrganisationUnit> {
  List<String> orgUnitIds;

  D2OrgUnitSync(ObjectBox db, DHIS2Client client, {required this.orgUnitIds})
      : super(
          label: "Organisation Units",
          fields: [
            "*",
          ],
          extraParams: {"withinUserHierarchy": "true"},
          db: db,
          client: client,
          resource: "organisationUnits",
        );

  @override
  D2OrganisationUnit mapper(Map<String, dynamic> json) {
    return D2OrganisationUnit.fromMap(db, json);
  }
}
