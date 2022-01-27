library auth;

// ignore_for_file: prefer_final_fields, unused_field
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:authentication_repository/src/models/roles.dart';

// To throw exceptions if got any errors in auth
class AuthFailure implements Exception {
  const AuthFailure([this.message = 'An Unknown Exception Occured']);

  factory AuthFailure.fromMessage(String message) {
    return AuthFailure(message);
  }
  final String message;
}

class AuthenticationRepository {
  final String baseUrl = 'https://thresholdd.herokuapp.com';
  // final String baseUrl = 'http://localhost:8000';

  final String primaryPath = '/api/v1/users';
  String _userName;
  String _mobile;
  String _password;
  String _token = '';
  Roles _role;

  // Getters for userName and role
  String get userName => _userName;
  String get role => getRoleFromEnum(_role);
  Future<String> get token async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final String token = _prefs.getString('token') ?? _token;
    return token;
  }

  AuthenticationRepository({
    String? userName,
    String? mobile,
    String? password,
    Roles? role,
  })  : _userName = userName ?? '',
        _mobile = mobile ?? '',
        _password = password ?? '',
        _role = role ?? Roles.student;

  Future<dynamic> signup({
    required String userName,
    required String mobile,
    required String password,
    required Roles role,
  }) async {
    var localUrl = Uri.parse(baseUrl + primaryPath + '/signup');
    var response = await http.post(
      localUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        'userName': userName,
        'mobile': mobile,
        'password': password,
        'role': getRoleFromEnum(role)
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      _saveData(userName: userName, role: role, mobile: mobile);
      final data = jsonDecode(response.body);
      final token = data['data']['token'];
      _saveToken(token: token);
      return data['message'];
    } else {
      final error = jsonDecode(response.body);
      throw AuthFailure.fromMessage(error['message']);
    }
  }

  Future<dynamic> login({
    required String userName,
    required String mobile,
    required String password,
    required Roles role,
  }) async {
    var localUrl = Uri.parse(baseUrl + primaryPath + '/login');
    var response = await http.post(
      localUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        'userName': userName,
        'mobile': mobile,
        'password': password,
        'role': getRoleFromEnum(role),
      }),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      _saveData(userName: userName, role: role, mobile: mobile);
      final data = jsonDecode(response.body);
      final token = data['data']['token'];
      _saveToken(token: token);
      return data['message'];
    } else {
      final error = jsonDecode(response.body);
      throw AuthFailure.fromMessage(error['message']);
    }
  }

  Future<dynamic> verify({
    required String otp,
  }) async {
    var localUrl = Uri.parse(baseUrl + primaryPath + '/verify');
    var response = await http.post(
      localUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        'userName': userName,
        'mobile': _mobile,
        'role': role,
        'otp': otp
      }),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      final error = jsonDecode(response.body);
      throw AuthFailure.fromMessage(error['message']);
    }
  }

  Future<dynamic> checkUserExistance({required String userName}) async {
    var localUrl = Uri.parse(baseUrl + primaryPath + '/checkUserExistance');
    var response = await http.post(
      localUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        'userName': userName,
      }),
    );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      final error = jsonDecode(response.body);
      throw AuthFailure.fromMessage(error['message']);
    }
  }

  void _saveData({
    required String userName,
    required String mobile,
    required Roles role,
  }) {
    _userName = userName;
    _mobile = mobile;
    _role = role;
  }

  Future<void> _saveToken({required String token}) async {
    _token = token;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('token', token);
  }
}
