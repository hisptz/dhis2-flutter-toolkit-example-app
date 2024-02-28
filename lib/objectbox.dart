import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'objectbox.g.dart'; // created by `flutter pub run build_runner build`

// ObjectBox? db;

class ObjectBox {
  /// The Store of this app.
  final Store store;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create(D2Credential credentials) async {
    String storeId =
        "${credentials.username}-${credentials.systemId}".replaceAll("-", "_");
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
      directory: p.join(docsDir.path, storeId),
    );
    return ObjectBox._create(store);
  }
}
