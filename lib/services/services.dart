import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_models.dart';

var base =
    "https://script.googleusercontent.com/macros/echo?user_content_key=D0H3iMZikQI_yWUw_g2PNRJ_0MjdcW7_gIH3XPfRCi7c9mPvndCohKkDrY2IUClxAzvesH2CP8j9HgDiZ_oB4uZbsFkpn2G_m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnE4Vm4PEdcCKRFQhPCIFmh_IB3rtxLYElxJgqykYidF6kZ41hBodb7XpIZ4wjWUjlArRnR1saWmD2bq0gIoJrA9FmNp2exz8OQ&lib=M2s0iekLXcCpKZtCEBnaSnr9qhhlEOC_Q";

getPosts() async {
  Uri url = Uri.parse(base);
  var res = await http.get(url);

  try {
    if (res.statusCode == 200) {
      var data = postModelsFromJson(res.body);
      return data.placement;
    } else {
      print("Error during Connection!!!");
    }
  } catch (e) {
    print(e.toString());
  }
}

