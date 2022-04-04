import 'package:net_module/models/response_base.dart';

class BytesResponse extends ResponseBase {
  BytesResponse(this.bytes);

  final List<int> bytes;
}
