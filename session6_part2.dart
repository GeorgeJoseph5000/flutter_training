import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
  .authStateChanges(),
        builder: (context, snapshot) {
            try {
            if (snapshot.hasData){
              if(snapshot.data!.email != null){
                return ElevatedButton(onPressed: () async {
                  try {
                    var cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "georgejoseph5000@gmail.com", password: "12345678");
                    var db = FirebaseFirestore.instance;
                    await db.collection("users").doc(cred.user!.uid).set({
                        "username": "george50",
                        "friends": ["mohamed50"]
                    });
                  } catch (e) {
                    
                  }
                }, child: Text("Register"));
              }else{
                return Text("You are registered");
              }
            }
              
            } catch (e) {
              
            }
            return CircularProgressIndicator();
          })
    );
  }
}
