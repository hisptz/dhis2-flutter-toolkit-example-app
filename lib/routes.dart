import 'package:dhis2_flutter_toolkit/components/Loader.dart';
import 'package:dhis2_flutter_toolkit/modules/home.dart';
import 'package:dhis2_flutter_toolkit/modules/login.dart';
import 'package:dhis2_flutter_toolkit/modules/programs/list.dart';
import 'package:dhis2_flutter_toolkit/modules/programs/program.dart';
import 'package:dhis2_flutter_toolkit/modules/sync.dart';
import 'package:dhis2_flutter_toolkit/modules/trackedEntityInstances/list.dart';
import 'package:dhis2_flutter_toolkit/modules/trackedEntityInstances/trackedEnityInstance.dart';
import 'package:dhis2_flutter_toolkit/modules/tracker_data_sync.dart';
import 'package:dhis2_flutter_toolkit/modules/tracker_data_upload.dart';
import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/services/users.dart';
import 'package:dhis2_flutter_toolkit/state/client.dart';
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
        final D2Credential? credentials = AppAuth().getLoggedInUser();
        if (credentials == null) {
          return "/login";
        }
        await D2Utils.initialize(context);
        final db = Provider.of<DBProvider>(context, listen: false).db;
        final client =
            Provider.of<D2HttpClientProvider>(context, listen: false).client;
        final metadataSync = D2MetadataDownloadService(db, client);
        if (!metadataSync.isSynced()) {
          return "/sync";
        }
        return "/home";
      },
      builder: (context, state) => const Loader(),
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
    GoRoute(
        path: "/data-sync",
        builder: (context, state) => const TrackerDataSyncPage()),
    GoRoute(
        path: "/data-upload",
        builder: (context, state) => const TrackerDataUploadPage()),
    GoRoute(
        path: "/tei",
        builder: (context, state) => const TeiList(),
        routes: [
          GoRoute(
              path: ":uid",
              builder: (context, state) => TeiDetails(
                    id: state.pathParameters["uid"],
                  ))
        ]),
  ],
);
