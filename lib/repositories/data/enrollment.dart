import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';
import 'package:dhis2_flutter_toolkit/repositories/data/sync.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

import '../../objectbox.g.dart';

class D2EnrollmentRepository extends BaseRepository<D2Enrollment>
    implements SyncableRepository<D2Enrollment> {
  D2EnrollmentRepository(super.db);

  @override
  D2Enrollment? getByUid(String uid) {
    Query<D2Enrollment> query =
        box.query(D2Enrollment_.uid.equals(uid)).build();
    return query.findFirst();
  }

  List<D2Enrollment>? getAll() {
    Query query = box.query().build();
    return query.find() as List<D2Enrollment>;
  }

  @override
  D2Enrollment mapper(Map<String, dynamic> json) {
    return D2Enrollment.fromMap(db, json);
  }

  D2EnrollmentRepository byTrackedEntity(int id) {
    queryConditions = D2Enrollment_.trackedEntity.equals(id);
    return this;
  }

  @override
  Future<List<D2Enrollment>> syncMany(
      DHIS2Client client, List<D2Enrollment> entities) {
    // TODO: implement syncMany
    throw UnimplementedError();
  }

  @override
  Future syncOne(DHIS2Client client, D2Enrollment entity) {
    // TODO: implement syncOne
    throw UnimplementedError();
  }
}
