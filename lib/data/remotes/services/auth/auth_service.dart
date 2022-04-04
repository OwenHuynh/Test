import 'package:portal/data/remotes/requests/auth/auth_request.dart';
import 'package:portal/data/remotes/responses/auth/auth_response.dart';
import 'package:net_module/net_module.dart';

class AuthService extends HttpServiceBase {
  AuthService(Dio dioInstance) : super(dio: dioInstance);

  Future<AuthResponse> login(
      {required String email, required String password}) {
    final request = AuthRequest(email: email, password: password);

    return postData(
      request: request,
      mapper: (json, _) => AuthResponse.fromJson(json),
    );
  }
}
