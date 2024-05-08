class NetworkUtil {
//  Future<dynamic> searchReferalPatient(
  //   String searchString) async {
  // try {

  //   // final String url = ApiUrl.baseUrl + ApiUrl.searchPatientList;
  //   final body = jsonEncode({"keyword": searchString});

  //   cancellationToken = CancellationToken();
  //   http.Response? response = await HttpClientHelper.post(
  //     Uri.parse(url),
  //     cancelToken: cancellationToken,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer $token",
  //       'Accept': 'application/json'
  //     },
  //     body: body,
  //     timeLimit: const Duration(seconds: 5),
  //   );
  //   if (response!.statusCode == 401 || response.statusCode == 404) {
  //     prefs.clear();
  //     AppRoutesMaps.gotoSplashLight();
  //   }
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final ReverseReferalsListModel patientSearchResultModel =
  //         ReverseReferalsListModel.fromJson(data as Map<String, dynamic>);
  //     return patientSearchResultModel;
  //   }
  //   return null;
  // } on OperationCanceledError catch (_) {
  //   return null;
  // } catch (e) {
  //   return null;
  // }
  // }
}
