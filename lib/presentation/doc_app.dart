import 'package:doctor_appointment/common/constants/route_constants.dart';
import 'package:flutter/material.dart';

import 'Routes.dart';
import 'fade_page_route_builder.dart';

class DocApp extends StatefulWidget {
  const DocApp({Key? key}) : super(key: key);

  @override
  State<DocApp> createState() => _DocAppState();
}

class _DocAppState extends State<DocApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor Appointment',
      initialRoute: RouteList.initial,
      onGenerateRoute: (RouteSettings settings) {
        final routes = Routes.getRoutes(settings);
        final WidgetBuilder? builder = routes[settings.name];
        return FadePageRouteBuilder(
          builder: builder!,
          settings: settings,
        );
      },
    );
  }
}
