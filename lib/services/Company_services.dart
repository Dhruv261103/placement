import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:placement/models/company_models.dart';

var base =
    "https://script.googleusercontent.com/macros/echo?user_content_key=IQ4Rhz7XRw9tgSwB6R0kkbgecqE6vCwvZ8lJhe55FbwmwX7ULikctravvo4zoGJbpKBUUUJelxGZPERehKEeb_muZ4xVq7Q6m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnI7HIXXWVRGVMw0b66v14lULg9BxOL2LRbNp3P6Q3ihzrvDBHECbsKON-Qgen3hU4vjwakafPdM-Tg5DRuuo084neP1A4xEK3tz9Jw9Md8uu&lib=Mctl2FAPUZ_woJHAoQw9MNIJbrqgPk4bf";

getCompanyDetails() async {
  Uri url = Uri.parse(base);
  var response = await http.get(url);

  // print('Response Status Code: ${response.statusCode}');
  // print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    var data = companymodelFromJson(response.body);
    return data.companies;
  } else {
    throw Exception('Failed to load company details');
  }
}
