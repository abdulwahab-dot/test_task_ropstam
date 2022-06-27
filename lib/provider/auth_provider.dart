import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_task/Screens/api_view.dart';
import 'package:test_task/Screens/home_page.dart';
import 'package:test_task/Utils/navigator.dart';

class AuthenticationProvider extends ChangeNotifier {
  //Setter
  bool _isLoading = false;
  bool _isLogedin = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;
  bool get isLogedin => _isLogedin;
  String get resMessage => _resMessage;

  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    String url = "http://buddy.ropstambpo.com/api/login";

    final body = {"email": email, "password": password};
    print(body);

    try {
      http.Response req =
          await http.post(Uri.parse(url), body: json.encode(body));

      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);

        print(res);
        _isLoading = false;
        _isLogedin = true;
        _resMessage = "Login successfully!";
        PageNavigator(ctx: context).nextPageOnly(page: const ApiView());
        notifyListeners();
      } else {
        final res = json.decode(req.body);

        _resMessage = res['message'];

        print(res);
        _isLoading = false;
        _isLogedin = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _isLogedin = false;
      _resMessage = "Internet connection is not available`";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _isLogedin = false;
      _resMessage = "Please try again`";
      notifyListeners();

      print(":::: $e");
    }
  }

  void clear() {
    _resMessage = "";
    // _isLoading = false;
    notifyListeners();
  }
}
