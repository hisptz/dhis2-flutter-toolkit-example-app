import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Legend implements DHIS2MetadataResource {
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  String uid;

  String name;
  int startValue;
  int endValue;
  String color;
  String displayName;



  Legend(this.created, this.lastUpdated, this.uid, this.name, this.startValue,
      this.endValue, this.color, this.displayName);
}
