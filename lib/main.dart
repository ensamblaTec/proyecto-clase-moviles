import 'package:flutter/material.dart';
import 'package:pmsn20232/assets/global_values.dart';
import 'package:pmsn20232/assets/styles.dart';
import 'package:pmsn20232/routes/routes.dart';
import 'package:pmsn20232/screens/login_screen.dart'; // Aplicación Android
// import 'package:flutter/cupertino.dart'; // Aplicación iOS
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    /** 
     * Contexto: La pantalla actual
    */
    return ValueListenableBuilder(
      valueListenable: GlobalValues.flagTheme,
      builder: (context, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
          routes: getRoutes(),
          theme: value ? StylesApp.darkTheme(context) : StylesApp.lightTheme(context)
          );
      }
    );
  }
}

// import 'package:flutter/material.dart'; // Aplicación Android
// // import 'package:flutter/cupertino.dart'; // Aplicación iOS
// void main() {
//   runApp(MainApp());
// }

// class MainApp extends StatelessWidget {
//   MainApp({super.key});

//   int contador = 0;

//   @override
//   Widget build(BuildContext context) {
//     /** 
//      * Contexto: La pantalla actual
//     */
//     return MaterialApp( // Widget principal que contiene a todos los widgets
//       title: "Primera App",
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Text('Contador de clics $contador', style: TextStyle(color: Colors.blueAccent),),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(
//             Icons.mouse, 
//             color: Color.fromARGB(255, 100, 100, 100),),
//             onPressed: (){
//               contador++;
//             }),
//       ),
//     );
//   }
// }