import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //color de fondo de la app
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark

        ),
      ),
      
      body: Padding(

      padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40,20), 
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        ),
      ),   
    );
  }
}