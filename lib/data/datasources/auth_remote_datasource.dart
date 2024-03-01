import 'package:dartz/dartz.dart';
import 'package:flutter_onlineshop_app/core/constants/variables.dart';
import 'package:flutter_onlineshop_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_onlineshop_app/data/models/requests/register_request_model.dart';
import 'package:flutter_onlineshop_app/data/models/responses/auth_response_model.dart';
import 'package:http/http.dart' as http;



class AuthRemoteDatasource {
  
  //login
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  //logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/logout'),
        headers: {'Authorization': 'Bearer ${authData?.accessToken}'});

    if (response.statusCode == 200) {
      AuthLocalDatasource().removeAuthData();
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }

  //register
  Future<Either<String, AuthResponseModel>> register(
    RegisterRequestModel registerRequestModel) async {
      final response = await http.post(
        Uri.parse('${Variables.baseUrl}/api/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: registerRequestModel.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(AuthResponseModel.fromJson(response.body));
      } else {
        return const Left('register gagal');
      }
    }

  //update fcm token
  Future<Either<String, String>> updateFcmToken(String fcmToken) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/update-fcm'),
      headers: {
        'Authorization': 'Bearer ${authData?.accessToken}',
        'Accept': 'application/json',
      },
      body: {'fcm_id': fcmToken},
    );

    if (response.statusCode == 200) {
      return Right(response.body);
    } else {
      return Left(response.body);
    }
  }
}
