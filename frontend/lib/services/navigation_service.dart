import 'package:project/utils/constants.dart';

class NavigationService {
  static final _navigationKey = GlobalKeys.navigatorKey;

  static Future<dynamic> pushReplacementNamed(
    String routeName, {
    Object? arguments,
  }) async {
    return await _navigationKey.currentState
        ?.pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pop() {
    _navigationKey.currentState?.pop();
  }

  static Future<dynamic> pushNamed(
    String routeName, {
    Object? arguments,
  }) async {
    return await _navigationKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }
}
