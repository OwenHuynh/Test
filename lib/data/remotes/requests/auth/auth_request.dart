import 'package:net_module/net_module.dart';

class AuthRequest extends RequestBase {
  AuthRequest({this.email, this.password});

  final String? email;
  final String? password;

  @override
  String get endpoint => '/user/login';

  @override
  Map<String, dynamic> toData() {
    return {"email": email, "password": password};
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
