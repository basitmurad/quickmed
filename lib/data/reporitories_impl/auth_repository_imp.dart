import 'package:quickmed/core/network/api_client.dart';
import 'package:quickmed/data/dataSource/auth_dataSources.dart';
import 'package:quickmed/data/models/request/register_request.dart';
import 'package:quickmed/data/models/response/register_response.dart';
import 'package:quickmed/domain/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepository{
  final AuthDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<RegisterResponse> registerUser(RegisterRequest request) async{
    try {
      return await authRemoteDataSource.register(request);
    } catch (error) {
      throw Exception('Error in repository during Registration: $error');
    }
  }




}