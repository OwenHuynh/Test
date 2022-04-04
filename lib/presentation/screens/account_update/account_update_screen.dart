import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/application/application.dart';

class AccountUpdateScreen extends StatelessWidget {
  const AccountUpdateScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBarText(title),
      body: Center(
        child: Text('DIDと合わせて機能実装'),
      ),
    );
  }
}
