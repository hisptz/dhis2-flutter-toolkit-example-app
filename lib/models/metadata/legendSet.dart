import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

import 'legend.dart';

@Entity()
class LegendSet extends DHIS2MetadataResource {
  @override
  int id = 0;
  @override
  DateTime created;

  @override
  DateTime lastUpdated;

  @override
  @Unique()
  String uid;

  String name;
  String code;

  final legends = ToMany<Legend>();

  LegendSet(
    this.created,
    this.lastUpdated,
    this.uid,
    this.name,
    this.code,
  );
}
