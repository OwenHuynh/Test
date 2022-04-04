import 'package:portal/presentation/screens/login/login.dart';
import 'package:intl/intl.dart';

mixin L10nStrings {
  /// [Common]
  String get commonOk => Intl.message("Ok", name: 'commonOk');

  String get commonCancel => Intl.message("Cancel", name: 'commonCancel');

  /// [Home]
  String get childHomeTitle => Intl.message("ホーム", name: 'childHomeTitle');

  String get settingPageTitle => Intl.message("設定", name: 'settingPageTitle');

  String get appPageTitle => Intl.message("アプリ", name: 'appPageTitle');

  /// [Error]
  String get badRequestError =>
      Intl.message("Bad requests!", name: 'badRequestError');

  String get unauthorizedError =>
      Intl.message("Access Denied!", name: 'unauthorizedError');

  String get forbiddenError =>
      Intl.message("Forbidden Errors!", name: 'forbiddenError');

  String get networkError =>
      Intl.message("An error occurred. We will record and fix this issue soon!",
          name: 'networkError');

  String get parseError =>
      Intl.message("Data parsing error!", name: 'parseError');

  String get connectTimeoutError =>
      Intl.message("Connection timeout with API server!",
          name: 'connectTimeoutError');

  String get connectError =>
      Intl.message("There is no Internet connection!", name: 'connectError');

  String get sendTimeoutError =>
      Intl.message("Send timeout in connection with API server!",
          name: 'sendTimeoutError');

  String get receiveTimeoutError =>
      Intl.message("Receive timeout in connection with API server!",
          name: 'receiveTimeoutError');

  String get cancelError =>
      Intl.message("Request to API server was cancelled!", name: 'cancelError');

  /// [LoginScreen]
  String get loginSubmitError =>
      Intl.message("Submit error!", name: 'loginSubmitError');

  String get notesEditorScreenLabelTitleConfirmRemoveNote =>
      Intl.message("Remove note",
          name: 'notesEditorScreenLabelTitleConfirmRemoveNote');

  String get notesEditorScreenLabelDescriptionConfirmRemoveNote =>
      Intl.message("Are you sure you want to delete this note?",
          name: 'notesEditorScreenLabelDescriptionConfirmRemoveNote');

  String get loginScreenLabelAppBarTitle =>
      Intl.message("Login Page", name: 'loginScreenLabelAppBarTitle');

  String get loginScreenLabelTitlePage =>
      Intl.message("Welcome", name: 'loginScreenLabelTitlePage');

  String get loginScreenLabelSubTitle =>
      Intl.message("Sign in with your email and password",
          name: 'loginScreenLabelSubTitle');

  String get loginScreenLabelEmail =>
      Intl.message("Email", name: 'loginScreenLabelEmail');

  String get loginScreenLabelPassword =>
      Intl.message("Password", name: 'loginScreenLabelPassword');

  String get loginScreenLabelEmailErrorMessage =>
      Intl.message("メールアドレスを入力してください。",
          name: 'loginScreenLabelEmailErrorMessage');

  String get loginScreenLabelEmailTypeErrorMessage =>
      Intl.message("メールアドレスを正しく入力してください。 \n例：sample@gmail.com",
          name: 'loginScreenLabelEmailTypeErrorMessage');

  String get loginScreenLabelPasswordErrorMessage =>
      Intl.message("パスワードを入力してください。",
          name: 'loginScreenLabelPasswordErrorMessage');

  String get loginScreenLabelPasswordLengthErrorMessage =>
      Intl.message("パスワードを正しく入力してください。６字以上で入力してください。",
          name: 'loginScreenLabelPasswordLengthErrorMessage');

  String get loginScreenLabelLoginButton =>
      Intl.message("Login", name: 'loginScreenLabelLoginButton');

  String get ok => Intl.message("OK", name: "ok");

  String get oops => Intl.message("Oops, Something Went Wrong", name: "oops");

  String get retry => Intl.message("Retry", name: "retry");

  String get textErrorName =>
      Intl.message("Please enter input name", name: "textErrorName");

  String get textErrorAge =>
      Intl.message("Please enter input age", name: "textErrorAge");

  String get textErrorEmail =>
      Intl.message("Please enter input email", name: "textErrorEmail");

  String get emailNotValid =>
      Intl.message("Email is not valid", name: "emailNotValid");

  /// [ChildHomeScreen]
  String get titleBottomSheet =>
      Intl.message("LIST OF DISTRICTS", name: 'titleBottomSheet');

  String get loadPreviousWebError =>
      Intl.message("No back history web!", name: 'loadPreviousWebError');

  String get loadNextWebError =>
      Intl.message("No forward history web!", name: 'loadNextWebError');

  String get bottomSheetButtonConfirmText =>
      Intl.message("Confirm", name: 'bottomSheetButtonConfirmText');

  String get showBottomSheetTitle =>
      Intl.message("show bottom", name: 'showBottomSheetTitle');

  /// [SettingScreen]
  String get serviceCityTitle =>
      Intl.message("サービス利用市区村町", name: 'serviceCityTitle');

  String get selectIndexDistrict =>
      Intl.message("豊能町", name: 'selectIndexDistrict');

  String get accountSettingTitle =>
      Intl.message("各種設定", name: 'accountSettingTitle');

  String get accountUpdate => Intl.message("登録情報変更", name: 'accountUpdate');

  String get otherSettingTitle =>
      Intl.message("その他", name: 'otherSettingTitle');

  String get contactLink => Intl.message("お問い合わせ", name: 'contactLink');

  String get termsTitle => Intl.message("利用規約", name: 'termsTitle');

  String get policyTitle => Intl.message("プライバシーポリシー", name: 'policyTitle');

  String get deleteDistrict =>
      Intl.message("Delete district", name: 'deleteDistrict');

  String get deleteDistrictConfirm =>
      Intl.message("Are you sure to delete ", name: 'deleteDistrictConfirm');

  String get address => Intl.message("Address", name: 'address');

  String get districtList =>
      Intl.message("District list", name: 'districtList');

  String get district => Intl.message("地区を入力してください。", name: 'district');

  String get addDistrict => Intl.message("住所追加", name: 'addDistrict');

  String get urlDistrict =>
      Intl.message("地区のURLを入力してください。", name: 'urlDistrict');

  String get submit => Intl.message("Submit", name: 'submit');

  String get emptyDistrict =>
      Intl.message("There is no district available", name: 'emptyDistrict');

  String get iconAdd => Intl.message("+", name: 'iconAdd');

  String get districtNameErrorMessage =>
      Intl.message("地区が入力されていません。", name: 'districtNameErrorMessage');

  String get districtUrlErrorEmptyMessage =>
      Intl.message("地区URLが入力されていません。", name: 'districtUrlErrorEmptyMessage');

  String get districtUrlErrorMessage =>
      Intl.message("URLを正しく入力してください。", name: 'districtUrlErrorMessage');

  /// [RegisterScreen]

  String get registerScreenLabelAppBarTitle =>
      Intl.message("アカウント登録", name: 'registerScreenLabelAppBarTitle');

  String get registerScreenSubmitButtonTitle =>
      Intl.message("アカウントを作成する", name: 'registerScreenSubmitButtonTitle');

  String get registerScreenLabelEmail =>
      Intl.message("メールアドレス ", name: 'registerScreenLabelEmail');

  String get registerScreenLabelPassword =>
      Intl.message("パスワード ", name: 'registerScreenLabelPassword');

  String get registerScreenLabelConfirmPassword =>
      Intl.message("パスワードの再確認 ", name: 'registerScreenLabelConfirmPassword');

  String get registerScreenLabelPasswordErrorMessage =>
      Intl.message("入力されたパスワードが一致しません。",
          name: 'registerScreenLabelPasswordErrorMessage');

  String get requiredText => Intl.message("(必須)", name: 'requiredText');

  String get privacyTitle => Intl.message("プライバシーポリシー", name: 'privacyTitle');

  String get termTitle => Intl.message("利用規約", name: 'termTitle');

  String get registerScreenConfirmedLabelText =>
      Intl.message("確認後、チェックを入れてください ",
          name: 'registerScreenConfirmedLabelText');

  String get selectDistrictTitle =>
      Intl.message("サービス利用自治体選択", name: 'selectDistrictTitle');

  String get confirmText => Intl.message("確認", name: 'confirmText');

  String get cancelText => Intl.message("キャンセル", name: 'cancelText');

  String get emptySearchText =>
      Intl.message("一致結果が見つかりませんでした。", name: 'emptySearchText');

  String get searchText => Intl.message("検索", name: 'searchText');

  String get selectDistrictButton =>
      Intl.message("登録する", name: 'selectDistrictButton');

  String get loginText => Intl.message("ログイン", name: 'loginText');
}
