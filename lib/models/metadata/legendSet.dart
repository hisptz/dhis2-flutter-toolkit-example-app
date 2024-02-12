import 'package:dhis2_flutter_toolkit/models/metadata/metadataBase.dart';
import 'package:objectbox/objectbox.dart';

import 'legend.dart';

@Entity()
class LegendSet implements DHIS2MetadataResource {
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
