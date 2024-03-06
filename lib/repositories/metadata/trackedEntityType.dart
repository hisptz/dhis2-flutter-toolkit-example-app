import 'package:dhis2_flutter_toolkit/models/metadata/trackedEntityType.dart';
import 'package:dhis2_flutter_toolkit/objectbox.g.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/download_mixins/base_meta_download_mixin.dart';
import 'package:dhis2_flutter_toolkit/repositories/metadata/download_mixins/tracked_entity_type_download_mixin.dart';

class D2TrackedEntityTypeRepository
    extends BaseMetaRepository<D2TrackedEntityType>
    with
        BaseMetaDownloadServiceMixin<D2TrackedEntityType>,
        D2TrackedEntityTypeDownloadServiceMixin {
  D2TrackedEntityTypeRepository(super.db);

  @override
  D2TrackedEntityType? getByUid(String uid) {
    Query<D2TrackedEntityType> query =
        box.query(D2TrackedEntityType_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2TrackedEntityType mapper(Map<String, dynamic> json) {
    return D2TrackedEntityType.fromMap(db, json);
  }
}
