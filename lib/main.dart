// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp( const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'FireBase Connect'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   final _auth = FirebaseAuth.instance;
//   bool showSpinner = false;
//   String email = 'nguyenhaicuong@ctu.edu.vn';
//   String password = '324712321';
//
//   void _incrementCounter() async{
//     try{
//       final newUser = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password);
//       print(newUser);
//     }catch(e){
//       print(e);
//     }
//   }
//
//   @override
//   void initState(){
//     super.initState();
//     Firebase.initializeApp().whenComplete((){
//       print("comleted");
//       setState(() {
//
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               'Vuong',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
// import 'package:flutterfirebase/screens/login.dart';
// import 'package:flutterfirebase/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import '../../screens/chat.dart';
// import '../../screens/gegister.dart';
import '../../screens/navigation_bottom.dart';
import 'package:flutterfirebase/screens/home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatFirebase());
}
class ChatFirebase extends StatelessWidget{
  const ChatFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:SalomonBottom.id,
      routes: {
        // Welcome.id: (context) => const Welcome(),
        // Login.id: (context) => const Login(),
        // Home.id: (context) => const Home(),
        // Chat.id: (context) => const Chat(),
        // Register.id: (context) => const Register(),
        SalomonBottom.id: (context) => const SalomonBottom(),
      },
    );
  }

}
