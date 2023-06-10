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

  void fetchStoreAds() async {
    String url = 'https://fakestoreapi.com/products';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    print(_token);
    final body = response.body;
    final json = jsonDecode(body);
    print(json);
    List<StoreModel> store =
        List<StoreModel>.from(json.map((model) => StoreModel.fromJson(model)));
    print(store);
    storeAds=store;
    print(storeAds);
  }
}
