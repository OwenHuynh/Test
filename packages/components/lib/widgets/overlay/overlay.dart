import 'package:components/components.dart';
import 'package:flutter/material.dart';

class ExtendedOverlay {
  factory ExtendedOverlay() => _singleton ??= ExtendedOverlay._();

  ExtendedOverlay._();

  static ExtendedOverlay? _singleton;

  final List<ExtendedOverlayEntry> _overlayEntryList = <ExtendedOverlayEntry>[];

  List<ExtendedOverlayEntry> get overlayEntryList => _overlayEntryList;

  void closeAllOverlay() {
    for (final ExtendedOverlayEntry element in _overlayEntryList) {
      element.removeEntry();
    }
  }

  ExtendedOverlayEntry? showOverlay(Widget widget, {bool autoOff = false}) {
    final OverlayState? _overlay =
        BaseGlobal().globalNavigatorKey.currentState!.overlay;
    if (_overlay == null) {
      return null;
    }
    final ExtendedOverlayEntry entry =
        ExtendedOverlayEntry(autoOff: autoOff, widget: widget);
    _overlay.insert(entry);
    if (!autoOff) {
      _overlayEntryList.add(entry);
    }
    return entry;
  }

  bool closeOverlay({ExtendedOverlayEntry? entry}) {
    if (entry != null) {
      return entry.removeEntry();
    } else {
      if (_overlayEntryList.isNotEmpty) {
        return _overlayEntryList.last.removeEntry();
      }
    }
    return false;
  }
}

class ExtendedOverlayEntry extends OverlayEntry {
  ExtendedOverlayEntry({
    this.autoOff = false,
    WidgetBuilder? builder,
    Widget? widget,
    bool opaque = false,
    bool maintainState = false,
  })  : assert(builder != null || widget != null),
        super(
            builder: builder ?? (_) => widget!,
            opaque: opaque,
            maintainState: maintainState);

  final bool autoOff;

  bool removeEntry() {
    try {
      super.remove();
      if (!autoOff) {
        ExtendedOverlay()._overlayEntryList.remove(this);
      }
      if (scaffoldWillPop) {
        scaffoldWillPop = false;
      }
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  void remove() => removeEntry();
}
