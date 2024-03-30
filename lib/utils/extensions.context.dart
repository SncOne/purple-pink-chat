part of 'extensions.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  Locale get locale => Localizations.localeOf(this);

  FocusScopeNode get focusScopeNode => FocusScope.of(this);
}

extension CheckNull on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}

extension EditController on AutoDisposeRef {
  TextEditingController useTextEditingController() {
    final controller = TextEditingController();
    onDispose(() {
      controller.dispose();
    });
    return controller;
  }
}

extension AnimController on AutoDisposeRef {
  AnimationController useAnimationController() {
    final controller = AnimationController(
      duration: const Duration(seconds: 3),
      value: 1,
      vsync: useSingleTickerProvider(),
    );

    onDispose(() {
      controller.dispose();
    });

    return controller;
  }
}

extension MediaQueryExtension on BuildContext {
  Size get mediaQuerySize => mediaQuery.size;

  double get height => mediaQuerySize.height;
  double get width => mediaQuerySize.width;

  bool get isPhone => mediaQuerySize.shortestSide < 600;
  bool get isTablet => mediaQuerySize.shortestSide < 720;

  EdgeInsets get mediaQueryPadding => mediaQuery.padding;
  EdgeInsets get mediaQueryViewPadding => mediaQuery.viewPadding;
  EdgeInsets get mediaQueryViewInsets => mediaQuery.viewInsets;

  double get top => mediaQueryViewPadding.top;
  double get bottom => mediaQueryViewPadding.bottom;

  bool get isFullScreen => mediaQueryViewPadding.bottom == 0.0;
}

extension ThemeExtension on BuildContext {
  TextTheme get textTheme => theme.textTheme;

  bool get isDarkMode => theme.brightness == Brightness.dark;
}

extension OrientationExtension on BuildContext {
  Orientation get orientation => mediaQuery.orientation;

  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;
}

extension FocusScopeNodeExtension on BuildContext {
  void unfocus() => focusScopeNode.unfocus();
  bool nextFocus() => focusScopeNode.nextFocus();
  bool previousFocus() => focusScopeNode.previousFocus();
  void requestFocus([FocusNode? node]) => focusScopeNode.requestFocus(node);
}
