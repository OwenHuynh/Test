import 'package:portal/presentation/screens/district_list/component/district_form.state.dart';

class DistrictFormViewModel {
  DistrictFormViewModel({
    required this.isValidated,
    required this.state,
    required this.onDistrictNameChange,
    required this.onDistrictUrlChange,
  });

  bool isValidated;
  DistrictFormState state;
  Function(String text) onDistrictNameChange;
  Function(String text) onDistrictUrlChange;
}
