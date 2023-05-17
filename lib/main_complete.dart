import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_notification/routes/routes.dart';
import 'package:flutter_awesome_notification/themes/themes_controller.dart';
import 'notifications/notifications_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationsController.initializeLocalNotifications();
  await NotificationsController.interceptInitialCallActionRequest();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  static String name = 'Awesome Notifications - Example App';
  static Color mainColor = const Color(0xFF9D50DD);

  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    // Only after at least the action method is set, the notification events are delivered
    NotificationsController.initializeNotificationsEventListeners();
  }

  @override
  Widget build(BuildContext context) {
    String initialRoute =
        NotificationsController.initialCallAction == null
            ? PAGE_HOME
            : PAGE_PHONE_CALL;
    debugPrint('initialRoute: $initialRoute');

    return MaterialApp(
      title: App.name,
      color: App.mainColor,
      navigatorKey: App.navigatorKey,
      initialRoute: initialRoute,
      routes: materialRoutes,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child ?? const SizedBox.shrink(),
      ),
      theme: ThemesController.currentTheme,
    );
  }
}
