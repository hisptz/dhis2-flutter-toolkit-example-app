import 'package:dhis2_flutter_toolkit/models/data/enrollment.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

import '../../objectbox.g.dart';

final d2EnrollmentBox = db.store.box<D2Enrollment>();

class EnrollmentRepository extends BaseRepository<D2Enrollment> {
  EnrollmentRepository() : super(d2EnrollmentBox);

  @override
  D2Enrollment? getByUid(String uid) {
    Query<D2Enrollment> query =
        d2EnrollmentBox.query(D2Enrollment_.uid.equals(uid)).build();
    return query.findFirst();
  }

  @override
  D2Enrollment mapper(Map<String, dynamic> json) {
    return D2Enrollment.fromMap(json);
  }
}
