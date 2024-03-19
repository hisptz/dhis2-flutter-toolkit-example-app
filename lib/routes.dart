import 'package:dhis2_flutter_toolkit/dhis2_flutter_toolkit.dart';
import 'package:dhis2_flutter_toolkit_example_app/modules/controlled_form/controlled_form.dart';
import 'package:dhis2_flutter_toolkit_example_app/modules/programs/program_form.dart';
import 'package:dhis2_flutter_toolkit_example_app/modules/ui.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'components/Loader.dart';
import 'modules/home.dart';
import 'modules/login.dart';
import 'modules/programs/list.dart';
import 'modules/programs/program.dart';
import 'modules/sync.dart';
import 'modules/trackedEntityInstances/list.dart';
import 'modules/trackedEntityInstances/trackedEnityInstance.dart';
import 'modules/tracker_data_sync.dart';
import 'modules/tracker_data_upload.dart';
import 'state/db.dart';
import 'utils/init.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      redirect: (context, state) async {
        final D2UserCredential? credentials =
            await D2AuthService().currentUser();
        if (credentials == null) {
          return "/login";
        }
        await D2Utils.initialize(context);
        final db = Provider.of<DBProvider>(context, listen: false).db;
        final D2User? user = D2UserRepository(db).get();

        if (user == null) {
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
                  )),
          GoRoute(
              path: ":uid/registration-form",
              builder: (context, state) => ProgramFormExample(
                    programUid: state.pathParameters["uid"]!,
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
        builder: (context, state) => TeiList(
              programId: state.uri.queryParameters["program"],
            ),
        routes: [
          GoRoute(
              path: ":uid",
              builder: (context, state) => TeiDetails(
                    id: state.pathParameters["uid"],
                  ))
        ]),
    GoRoute(path: "/ui", builder: (context, state) => const UIComponents()),
    GoRoute(
        path: "/controlled-form",
        builder: (context, state) => ControlledFormExample())
  ],
);
