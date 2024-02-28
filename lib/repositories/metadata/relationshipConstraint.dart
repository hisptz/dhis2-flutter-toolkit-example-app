import 'package:dhis2_flutter_toolkit/models/metadata/relationshipConstraint.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class D2RelationshipConstraintRepository
    extends BaseRepository<D2RelationshipConstraint> {
  D2RelationshipConstraintRepository(super.db);

  @override
  D2RelationshipConstraint? getByUid(String uid) {
    return null;
  }

  @override
  D2RelationshipConstraint mapper(Map<String, dynamic> json) {
    return D2RelationshipConstraint.fromMap(json);
  }
}
