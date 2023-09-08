import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // recuperar los datos con controladores
    TextEditingController txtConUser = TextEditingController();
    final txtUser = TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      controller: txtConUser,
    );

    TextEditingController txtConPass = TextEditingController();
    final txtPass = TextField(
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        ),
      controller: txtConPass,
    );

    // container puede ser el equivalente a un div
    final imgLogo = Opacity(
      opacity: .2,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://w0.peakpx.com/wallpaper/389/270/HD-wallpaper-sword-world-cool-fantasy.jpg')
            ),
        ),
      ),
    );

    final btnEntrar = FloatingActionButton.extended(
      icon: const Icon(Icons.login),
      label: const Text('Entrar'),
      onPressed: 
      (){
        Navigator.pushNamed(context, '/dash');
      }
      );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .8,
            fit: BoxFit.fill,
            image: NetworkImage('https://w0.peakpx.com/wallpaper/389/270/HD-wallpaper-sword-world-cool-fantasy.jpg')
            ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // imgFondo,
              Container(
                height: 200,
                padding: const EdgeInsets.all(30),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                // color: const Color.fromARGB(255, 246, 246, 107),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey
                ),
                child: Column(
                  // padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    txtUser,
                    const SizedBox(height: 10,),
                    txtPass,
                  ],
                ),
              ),
              Positioned(top: 200, child: imgLogo)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: btnEntrar,
    );
  }
}