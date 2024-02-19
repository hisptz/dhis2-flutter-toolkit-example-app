import 'package:dhis2_flutter_toolkit/models/metadata/relationshipConstraint.dart';
import 'package:dhis2_flutter_toolkit/objectbox.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

final d2RelationshipConstraintBox = db.store.box<D2RelationshipConstraint>();

class D2RelationshipConstraintRepository
    extends BaseRepository<D2RelationshipConstraint> {
  D2RelationshipConstraintRepository(super.box);

  @override
  D2RelationshipConstraint? getByUid(String uid) {
    return null;
  }
}
