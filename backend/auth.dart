import 'dart:convert';
import 'package:http/http.dart' as http;

//Authentication class for signup login & otp verification
//(OTP will be sent automatically when the user signsup or logsin correctly)
//A response.message will be sent based on the results use those messages to improve the user experience
class Auth {
  final url = 'https://thresholdd.herokuapp.com';
  // final url = 'http://localhost:8000';
  final primaryPath = '/api/v1/users';
  var userName = '';
  var mobile = '';
  var role = '';

  // Required data for login: role, mobile, password, userName, mobileConfirm and passwordConfirm
  signup(
      {required String userName,
      required String mobile,
      required String mobileConfirm,
      required String password,
      required passwordConfirm,
      required role}) async {
    var localUrl = Uri.parse(url + primaryPath + '/signup');
    var response = await http.post(
      localUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        'userName': userName,
        'mobile': mobile,
        'mobileConfirm': mobileConfirm,
        'password': password,
        'passwordConfirm': passwordConfirm,
        'role': role
      }),
    );

    _saveData(userName: userName, role: role, mobile: mobile);
    final data = jsonDecode(response.body);
    return data['message'];
  }

  // Required data for login: role, mobile, password and userName
  login(
      {required String userName,
      required String mobile,
      required String password,
      required String role}) async {
    var localUrl = Uri.parse(url + primaryPath + '/login');
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
        'role': role
      }),
    );
    _saveData(userName: userName, role: role, mobile: mobile);
    final data = jsonDecode(response.body);
    return data['message'];
  }

  // Required data for login: role, mobile, password and OTP
  verifyOtp(
      {required String userName,
      required String mobile,
      required String otp,
      required String role}) async {
    var localUrl = Uri.parse(url + primaryPath + '/verify');
    var response = await http.post(
      localUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        'userName': userName,
        'mobile': mobile,
        'role': role,
        'otp': otp
      }),
    );
    final data = jsonDecode(response.body);
    return data['message'];
  }

  //Private function to save data for otp verification
  _saveData(
      {required String role,
      required String mobile,
      required String userName}) {
    this.role = role;
    this.mobile = mobile;
    this.userName = userName;
  }
}
