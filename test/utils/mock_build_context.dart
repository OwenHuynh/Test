import 'package:flutter/material.dart';
import 'package:portal/state-management/app_states.dart';
import 'package:mocktail/mocktail.dart';
import 'package:redux/redux.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockStore extends Mock implements Store<AppState> {}
