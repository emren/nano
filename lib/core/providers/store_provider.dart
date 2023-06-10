import 'dart:convert';
import '../models/store_model.dart';
import 'base_provider.dart';
import 'package:http/http.dart' as http;

class StoreProvider extends BaseProvider {
  String _token = '';
  List<StoreModel> _storeAds = [];
  List<StoreModel> get storeAds => _storeAds;
  set storeAds(List<StoreModel> ads) {
    _storeAds = ads;
    notifyListeners();
  }



  Future<bool> auth(String email, String password) async {
    String url = 'https://fakestoreapi.com/auth/login';
    Uri uri = Uri.parse(url);
    var response = await http.post(uri,
        body: ({
          'username': email,
          'password': password,
        }));

    if (response.statusCode == 200) {
      _token = json.decode(response.body)['token']!;
      return true;
    } else {
      return false;
    }
  }

  void fetchStoreAds() async {
    String url = 'https://fakestoreapi.com/products';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    final body = response.body;
    final json = jsonDecode(body);
    List<StoreModel> store =
        List<StoreModel>.from(json.map((model) => StoreModel.fromJson(model)));
    storeAds = store;
  }
}
