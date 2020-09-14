import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './Screens/auth_Screen.dart';
import './Screens/Chat_Screen.dart';

  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.blueAccent,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor : Colors.deepOrange,
          textTheme : ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // ignore: deprecated_member_use
      home: StreamBuilder(stream:FirebaseAuth.instance.onAuthStateChanged ,builder:(ctx, userSnapshot)
      {
         if(userSnapshot.connectionState == ConnectionState.waiting)
        {
          Center(child: Text('Loading...'),);
        }
        if(userSnapshot.hasData)
        {
          return ChatScreen();
        }
        return  AuthScreen();
      } ,)
      
    );
  }
}


