import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter_dam/screens/home_screen.dart';
import 'package:firebase_flutter_dam/screens/login_screen.dart';
import 'package:firebase_flutter_dam/screens/register_screen.dart';
import 'package:firebase_flutter_dam/seleccionar_pantalla_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //DE AQUI
  await Firebase.initializeApp(
    //hacer siempre para sincronizar con firebase
    options: DefaultFirebaseOptions.currentPlatform,
  ); //A AQUI

  //FirebaseCrashlytics.instance.crash();
  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  //FirebaseAnalytics analytics = FirebaseAnalytics.instance; //Me creeo la instancia

  //await analytics.logEvent(
  //name: 'Prueba_DAM2',
  //parameters: {'timestamp' : DateTime.now().toIso8601String()}
  //);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
