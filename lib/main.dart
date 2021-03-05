import 'package:flutter/material.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:gasejakt/ui/screens/history_screen.dart';
import 'package:gasejakt/ui/screens/home_screen.dart';
import 'package:gasejakt/ui/screens/register_huntingday_screen.dart';

void main() {
  setupServiceLocator();
  runApp(GoosehuntApp());
}

const PrimaryColor = Color(0xFF006964);
const MaterialColor kPrimaryColor = const MaterialColor(
  0xFF006964,
  const <int, Color>{
    50: const Color(0xFF006964),
    100: const Color(0xFF006964),
    200: const Color(0xFF006964),
    300: const Color(0xFF006964),
    400: const Color(0xFF006964),
    500: const Color(0xFF006964),
    600: const Color(0xFF006964),
    700: const Color(0xFF006964),
    800: const Color(0xFF006964),
    900: const Color(0xFF006964),
  },
);

class GoosehuntApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var tv = TabBarView(
      children: [
        RegisterHuntingdayScreen(),
        HistoryScreen(title: 'Historikk'),
        HomeScreen(
          title: "Meg",
        )
      ],
    );

    var def = DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: menu(),
        body: tv,
      ),
    );

    var themeData = ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: kPrimaryColor,
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

    return MaterialApp(
      title: 'Gåsejakt',
      theme: themeData,

      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: def,
    );
  }
}

Widget menu() {
  return Container(
    color: PrimaryColor,
    child: TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: PrimaryColor,
      tabs: [
        Tab(
          text: "Registrer",
          icon: Icon(Icons.send),
        ),
        Tab(
          text: "Historikk",
          icon: Icon(Icons.insert_chart),
        ),
        Tab(
          text: "Meg",
          icon: Icon(Icons.account_circle),
        ),
      ],
    ),
  );
}
