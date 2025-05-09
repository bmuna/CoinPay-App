import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import '../../../../core/network/dio_client.dart';
import '../models/error_model.dart';
import '../models/auth_model.dart';

class AuthController extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isSuccess => _isSuccess;

  Future<void> signinWithGoogle() async {
    _isLoading = true;
    _error = null;
    _isSuccess = false;
    notifyListeners();

    try {
      final result = await FlutterWebAuth2.authenticate(
        url: "http://localhost:8081/auth/google",
        callbackUrlScheme: "myapp",
      );

      final uri = Uri.parse(result);
      final email = uri.queryParameters["email"];
      final token = uri.queryParameters["token"];

      if (email != null && token != null) {
        print("Signed in: $email");
        print("Token: $token");
        _isSuccess = true;
      } else {
        _error = 'No email returned in callback';
        _isSuccess = false;
      }
    } catch (e) {
      _error = 'Google sign in failed: $e';
      _isSuccess = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signin(AuthModel model) async {
    _isLoading = true;
    _error = null;
    _isSuccess = false;
    notifyListeners();

    try {
      final response = await DioClient.dio.post(
        '/signin',
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        _isSuccess = true;
        _error = null;
      } else {
        final errorModel = ErrorModel.fromJson(response.data);
        _error = errorModel.error;
        _isSuccess = false;
      }
    } catch (e) {
      _error = 'Login failed. Please try again.';
      _isSuccess = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signup(AuthModel model) async {
    _isLoading = true;
    _error = null;
    _isSuccess = false;
    notifyListeners();

    try {
      final response = await DioClient.dio.post(
        '/signup',
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        _isSuccess = true;
        _error = null;
      } else {
        final errorModel = ErrorModel.fromJson(response.data);
        _error = errorModel.error;
        _isSuccess = false;
      }
    } catch (e) {
      _error = 'Signup failed. Please try again.';
      _isSuccess = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<void> signOut() async {
  //   try {
  //     await _googleSignIn.signOut();
  //   } catch (e) {
  //     // Handle sign out error if needed
  //   }
  // }

  void reset() {
    _isLoading = false;
    _error = null;
    _isSuccess = false;
    notifyListeners();
  }
}
