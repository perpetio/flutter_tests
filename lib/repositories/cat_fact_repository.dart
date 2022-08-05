import 'dart:convert';
import 'package:http/http.dart';

import '../models/cat_fact.dart';

class CatfactRepository {
  Future<CatFact?> getCatFact() async {
    try {
      Response response = await get(Uri.parse('https://catfact.ninja/fact'));
      if (response.statusCode == 200) {
        CatFact cat = CatFact.fromJson(jsonDecode(response.body));
        return cat;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
