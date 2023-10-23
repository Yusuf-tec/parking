import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/help.dart';
import 'package:parking/login.dart';
import 'package:parking/pages/map.dart';
import 'package:parking/pages/setting.dart';
import 'package:parking/profile.dart';
import 'mainscreen.dart';
import 'parking_location_slots.dart';
import 'package:provider/provider.dart';
import 'package:parking/providers/data_provider.dart';


void main() => runApp(const MyApp(
      tittle: 'tittle'));

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.tittle});
  final String tittle;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final DataProvider _dataProvider = DataProvider();

@override
  void initState() {
    _dataProvider.getAllParkings();
    _dataProvider.getAllSlots();
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: _dataProvider,
        ),
      
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            bodyLarge: GoogleFonts.montserrat(textStyle: textTheme.bodyLarge),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
        // home: const AuthPage(),
        // routes: {
        // '/settings': (context) => const SettingsPage(),
        // '/profile': (context) => const ProfilePage(user: null,),
        // '/map': (context) => const MapPage(),
        // '/help': (context) => const HelpPage(),
        // '/pizzle': (context) => const ParkingLocationList(key: null,)
        // },
      ),
    );
  }
}