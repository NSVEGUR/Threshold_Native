import 'dart:convert';
import 'package:http/http.dart' as http;


//Authentication class for signup login & otp verification
//(OTP will be sent automatically when the user signsup or logsin correctly)
//A response.message will be sent based on the results use those messages to improve the user experience
class Auth {
  final url = 'https://thresholdd-api.herokuapp.com';
  final primaryPath = '/api/v1/users';
  var userName = '';
  var mobile = '';
  var role = '';


  // Required data for login
  // role: ['admin', 'student', 'teacher']
  // userName
  // password
  // mobile must be verified number (use validator npm package to verify mobile number in the front end)
  signup(data)async{
    String result = '';
    var localUrl = Uri.parse(url + primaryPath + '/signup');
    var response = await http.post(
        localUrl,
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String?>{
          'userName': data['userName'],
          'mobile': data['mobile'],
          'mobileConfirm': data['mobileConfirm'],
          'password': data['password'],
          'passwordConfirm': data['passwordConfirm'],
          'role': data['role']
        }),
    );
    _saveData(data);
    print(response.statusCode);
    if(response.statusCode == 400)
    {
      result = 'username already exist';
    }
    else if(response.statusCode == 401)
    {
      result = 'authorization error';
    }
    else if(response.statusCode == 200 || response.statusCode == 201)
    {
      result = 'success';
    }
    else{
      result = 'internal error';
    }

    return result;
  }

  // Required data for login
  // role: ['admin', 'student', 'teacher']
  // userName
  // password
  // mobile must be verified number (use validator npm package to verify mobile number in the front end)
  login(data)async{
    String result = '';
    var localUrl = Uri.parse(url + primaryPath + '/login');
    var response = await http.post(
      localUrl,
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        'userName': data['userName'],
        'mobile': data['mobile'],
        'password': data['password'],
        'role': data['role']
      }),
    );
    _saveData(data);
    if(response.statusCode == 404)
    {
      result = 'invalid userName or password';
    }
    else if(response.statusCode == 401)
    {
      result = 'authorization error';
    }
    else if(response.statusCode == 400){
      result = 'details Missing';
    }
    else if(response.statusCode == 200 || response.statusCode == 201)
    {
      result = 'success';
    }
    else{
      result = 'internal error';
    }

    return result;
  }

  //Required data is just OTP
  verify(otp)async{
    String result = '';
    var localUrl = Uri.parse(url + primaryPath + '/verify');
    var response = await http.post(
      localUrl,
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String?>{
        'userName': userName,
        'mobile': mobile,
        'role': role,
        'otp': otp
      }),
    );
    if(response.statusCode == 404)
    {
      result = 'invalid OTP';
    }
    else if(response.statusCode == 401)
    {
      result = 'authorization error';
    }
    else if(response.statusCode == 400){
      result = 'otp expired';
    }
    else if(response.statusCode == 200 || response.statusCode == 201)
    {
      result = 'success';
    }
    else{
      result = 'internal error';
    }

    return result;
  }

  //Private function to save data for otp verification
  _saveData(data) {
    role = data['role'];
    mobile = data['mobile'];
    userName = data['userName'];
  }
}
