import 'package:components/components.dart';
import 'package:components/widgets/line/line_component.dart';
import 'package:flutter/material.dart';
import 'package:portal/shared/localizations/l10n/localy.dart';

typedef BottomSheetWidgetBuilder = Widget Function(
  BuildContext context,
  double bottomSheetOffset,
);

typedef BottomSheetBodyWidgetBuilder = List<Widget> Function(
  BuildContext context,
  double bottomSheetOffset,
);

class UIUtils {
  static void showPopupWindow(BuildContext context,
      {required String text, required GlobalKey popKey}) {
    PopupWindowComponent.showPopWindow(context, text, popKey,
        popDirection: PopupDirection.top, hasCloseIcon: true);
  }

  static void showLoading(BuildContext context,
      {bool tapOutsideDismiss = true}) {
    LoadingDialog.show(context, barrierDismissible: tapOutsideDismiss);
  }

  static void hideLoading(BuildContext context) {
    LoadingDialog.dismiss(context);
  }

  static void showSuccessMessage(BuildContext context, String message) {
    SnackBarInfo(message, ScaffoldMessenger.of(context), AppColors.success)
        .show();
  }

  static void showWarningMessage(BuildContext context, String message) {
    SnackBarInfo(message, ScaffoldMessenger.of(context), AppColors.warning)
        .show();
  }

  static void showErrorMessage(BuildContext context, String message) {
    SnackBarInfo(message, ScaffoldMessenger.of(context), AppColors.error)
        .show();
  }

  static void showInfoMessage(BuildContext context, String message) {
    SnackBarInfo(message, ScaffoldMessenger.of(context), AppColors.info).show();
  }

  static void showConfirmDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required GestureTapCallback buttonConfirmCallback,
      required GestureTapCallback onCancel}) {
    DialogManager.showConfirmDialog(context,
        title: title,
        message: message,
        dialogStyle: BaseDialogStyle(
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: FontAlias.fontAlias16)),
        cancel: Localy.of(context)!.commonCancel,
        confirm: Localy.of(context)!.commonOk,
        onConfirm: buttonConfirmCallback,
        onCancel: onCancel);
  }

  static void showBottomSheet({
    required BuildContext context,
    required BottomSheetWidgetBuilder header,
    required BottomSheetBodyWidgetBuilder children,
    BottomSheetWidgetBuilder? bottomBuilder,
  }) {
    showStickyFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.9,
      maxHeight: 0.9,
      headerHeight: 100,
      useRootNavigator: true,
      context: context,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      headerBuilder: (context, offset) {
        return Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SpacingAlias.SizeHeight8,
                  Center(
                    child: Container(
                      height: 5,
                      width: 56,
                      decoration: BoxDecoration(
                        color: AppColors.grey3,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  header(context, offset),
                ],
              )),
              LineComponent(color: AppColors.grey3, height: 0.2),
            ],
          ),
        );
      },
      bodyBuilder: (context, offset) {
        return SliverChildListDelegate(
          children(context, offset),
        );
      },
      bottomBuilder: bottomBuilder,
      anchors: [],
    );
  }
}
