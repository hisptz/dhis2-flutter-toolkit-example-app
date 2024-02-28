import 'package:dhis2_flutter_toolkit/modules/home.dart';
import 'package:dhis2_flutter_toolkit/modules/login.dart';
import 'package:dhis2_flutter_toolkit/modules/programs/list.dart';
import 'package:dhis2_flutter_toolkit/modules/programs/program.dart';
import 'package:dhis2_flutter_toolkit/modules/sync.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/state/db.dart';
import 'package:dhis2_flutter_toolkit/syncServices/metadataSync.dart';
import 'package:dhis2_flutter_toolkit/utils/init.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      redirect: (context, state) async {
        final D2Credential? credentials = D2Credential.fromPreferences();
        if (credentials == null) {
          return "/login";
        }
        await D2Utils.initialize(context);
        final db = Provider.of<DbProvider>(context, listen: false).db;
        final metadataSync = MetadataSync(db);
        if (!metadataSync.isSynced()) {
          return "/sync";
        }
        return "/home";
      },
    ),
    GoRoute(path: "/sync", builder: (context, state) => const SyncPage()),
    GoRoute(path: "/home", builder: (context, state) => const Home()),
    GoRoute(path: "/login", builder: (context, state) => const Login()),
    GoRoute(
        path: "/programs",
        builder: (context, state) => const ProgramList(),
        routes: [
          GoRoute(
              path: ":uid",
              builder: (context, state) => ProgramDetails(
                    id: state.pathParameters["uid"],
                  ))
        ]),
  ],
);
