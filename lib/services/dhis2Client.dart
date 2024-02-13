import 'dart:convert';

import 'package:http/http.dart' as http;

import 'credentials.dart';

class DHIS2Client {
  DHIS2Credentials credentials;

  DHIS2Client(this.credentials);

  DHIS2Client.initialize(
      {required String username,
      required String password,
      required String baseURL})
      : credentials = DHIS2Credentials(username, password, baseURL);

  get username {
    return credentials.username;
  }

  get password {
    return credentials.password;
  }

  get baseURL {
    return credentials.baseURL;
  }

  get headers {
    return {
      "Authorization":
          "Basic ${base64Encode(utf8.encode('$username:$password'))}"
    };
  }

  Uri get uri {
    return Uri.parse("https://$baseURL/api");
  }

  Uri getApiUrl(String url, {Map<String, dynamic>? queryParameters}) {
    return uri.replace(
        pathSegments: [...uri.pathSegments, ...url.split("/")],
        queryParameters: queryParameters);
  }

  //This is the function that sends a Post Request to the DHIS2 Instance
//The function creates a new entity in the DHIS2 Instance Server
//This method accepts url String, query parameters, body of Json data and returns a response object
  Future<http.Response> httpPost(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return http.post(
      apiUrl,
      headers: headers,
      body: body,
    );
  }

//This is the function that sends a Put Request to the DHIS2 Instance with a JSON body
//The function updates an existing entity in the DHIS2 Instance Server
//This method accepts url String, query parameters, body of Json data and returns a response object
  Future<http.Response> httpPut(
    String url,
    body, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return http.put(
      apiUrl,
      headers: headers,
      body: body,
    );
  }

//This is the function that sends a Delete Request to the DHIS2 Instance
//The function deletes an existing entity in the DHIS2 Instance Server
//This method accepts url String, query parameters and returns a response object
  Future<http.Response> httpDelete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return await http.delete(apiUrl, headers: headers);
  }

//This is the function that sends a Get Request to the DHIS2 Instance
//The function Reads entities in the DHIS2 Instance Server
//This method accepts url String, query parameters and returns a response object
  Future<http.Response> httpGet(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    Uri apiUrl = getApiUrl(url, queryParameters: queryParameters);
    return await http.get(apiUrl, headers: headers);
  }

//This is the function that sends a Get Request to the DHIS2 Instance
//The function Reads entities in the DHIS2 Instance Server
  ///This method accepts url String, query parameters and returns a response object with a page size of 1
  Future<http.Response> httpGetPagination(
    String url,
    Map<String, dynamic> queryParameters,
  ) async {
    Map<String, dynamic> dataQueryParameters = {
      'totalPages': 'true',
      'pageSize': '1',
      'fields': 'none',
    };
    dataQueryParameters.addAll(queryParameters);
    return await httpGet(url, queryParameters: dataQueryParameters);
  }

  ///This method returns a String of server url
  @override
  String toString() {
    return '$baseURL => $username : $password';
  }
}

DHIS2Client? client;

void initializeClient(
    {required String baseURL,
    required String username,
    required String password}) {
  DHIS2Credentials credentials = DHIS2Credentials(username, password, baseURL);
  client = DHIS2Client(credentials);
}
