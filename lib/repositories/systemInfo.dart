import 'package:dhis2_flutter_toolkit/models/metadata/systemInfo.dart';
import 'package:dhis2_flutter_toolkit/repositories/base.dart';

class SystemInfoRepository extends BaseSingleRepository<SystemInfo> {
  SystemInfoRepository() : super(fields: ["*"], resource: "system", id: "info");
}
