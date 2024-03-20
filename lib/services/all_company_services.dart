import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/all_company_detail_model.dart';
import '../models/statastic_model.dart';

var base =
    "https://script.google.com/macros/s/AKfycbwQpbFK957-DLEG6zaSt-6TI7U-kV5lfb5YxVilyy2pFL0u6YbkhqxZ8190KpTPErYGvg/exec";

// Future<AllCompanyDetail> getAllCompanyDetails(String company) async {
//   Uri url = Uri.parse(base);
//   var response = await http.post(
//     url,
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'name': company,
//     }),
//   );
Future<AllCompanyDetail> getAllCompanyDetails() async {
  Uri url = Uri.parse(base);
  var response = await http.get(url);

  // print('Response Status Code: ${response.statusCode}');
  // print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    return AllCompanyDetail.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load company details');
  }
}
