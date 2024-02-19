import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/statastic_model.dart';

var base =
    "https://script.googleusercontent.com/macros/echo?user_content_key=5X8NU0Kyi6CXysnFFwyg6I6FADHypEh1XF_1JI2OizpPdZCSKxdahfHvE9nE-1R6EuxGuo3w5-TYy-fCD0iYrO14Bdu5d-PRm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnKVDinL3YIYOuGUf9zCJkCc8njPaiyf7U3gOhvo7NFk7jfcisUUk_b1JWz8elc5FxNL3T0_xnbXNjjSjQFUbxTnLaPXV_NAf3Nz9Jw9Md8uu&lib=M7YPc5SIiVeu1WbPjDIwDqIJbrqgPk4bf";

Future<StatasticModels> getStatasticDetails() async {
  Uri url = Uri.parse(base);
  var response = await http.get(url);

  // print('Response Status Code: ${response.statusCode}');
  // print('Response Body: ${response.body}');

  if (response.statusCode == 200) {
    return StatasticModels.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load company details');
  }
}
