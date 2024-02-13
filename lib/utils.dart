import 'package:dhis2_flutter_toolkit/services/credentials.dart';
import 'package:dhis2_flutter_toolkit/services/dhis2Client.dart';
import 'package:http/http.dart';

Future<DHIS2Credentials?> login(
    {required String baseURL,
    required String username,
    required String password}) async {
  DHIS2Credentials credentials = DHIS2Credentials(username, password, baseURL);
  DHIS2Client client = DHIS2Client(credentials);
  try {
    Response response = await client.httpGet("me");
    print(response);
    return credentials;
  } catch (e) {
    print(e);
  }
  return null;
}
