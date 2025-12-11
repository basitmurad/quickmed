import 'package:quickmed/data/models/request/register_request.dart';
import 'package:quickmed/data/models/response/register_response.dart';

abstract class AuthRepository{

  Future<RegisterResponse>  registerUser(RegisterRequest request);

}