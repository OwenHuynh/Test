import 'dart:io';

import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:portal/presentation/screens/download_app/download_app.view_model.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:portal/state-management/selector.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DownloadAppScreen extends HookWidget {
  const DownloadAppScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StoresSelector>(
        converter: StoresSelector.fromStore,
        builder: (context, state) {
          return DownloadAppBody(
            state,
            title: title,
          );
        });
  }
}

class DownloadAppBody extends HookWidget {
  const DownloadAppBody(this.state, {required this.title});

  final StoresSelector state;
  final String title;

  @override
  Widget build(BuildContext context) {
    final viewModel = useDownloadAppViewModel(context, state);
    return BaseScaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          actions: [],
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                if (Platform.isAndroid) {
                  viewModel.onNavigateDownloadAndroid(
                      viewModel.appList[index].messageDownload);
                } else if (Platform.isIOS) {
                  viewModel.onNavigateDownloadIOs(
                      viewModel.appList[index].messageDownload);
                } else {
                  null;
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        style: BorderStyle.solid,
                        color: Colors.grey.shade400,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      viewModel.appList[index].urlImage,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      '${viewModel.appList[index].title}',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontFamily: 'DMSans',
                        fontSize: FontAlias.fontAlias12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: viewModel.appList.length,
        ));
  }
}
