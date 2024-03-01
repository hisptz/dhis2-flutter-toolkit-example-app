import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';

abstract class SyncableRepository<T> {
  //Sync that one entity to the server
  Future syncOne(DHIS2Client client, T entity);

  Future syncMany(
    DHIS2Client client,
    List<T> entities,
  );
}
