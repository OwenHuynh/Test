import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockLocaly extends Localy {
  MockLocaly({
    this.onNoSuchMethod,
  }) : super('ja');

  final Function(Invocation)? onNoSuchMethod;

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      onNoSuchMethod ?? super.noSuchMethod(invocation);
}
