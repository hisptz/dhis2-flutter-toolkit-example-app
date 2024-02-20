import 'package:dhis2_flutter_toolkit/models/metadata/relationshipConstraint.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2RelationshipConstraintBox = db.store.box<D2RelationshipConstraint>();

class D2RelationshipConstraintRepository
    extends BaseRepository<D2RelationshipConstraint> {
  D2RelationshipConstraintRepository() : super(d2RelationshipConstraintBox);

  @override
  D2RelationshipConstraint? getByUid(String uid) {
    return null;
  }

  @override
  D2RelationshipConstraint mapper(Map<String, dynamic> json) {
    return D2RelationshipConstraint.fromMap(json);
  }
}
