import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getDate() async{
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      String date = response.body;
      return jsonDecode(date);
    } else {
      print(response.statusCode);
    }
  }
}