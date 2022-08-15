import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final storageRef = FirebaseStorage.instance.ref();
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? img;

  Future pickimage() async {
    try {
      print("hello1");
      img = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 50);

      final path = 'images/new.jpg';
      if (img == null) {
        return;
      }
      final imagetemp = File(img!.path);
      final ref = FirebaseStorage.instance.ref(path).putFile(imagetemp);
    } on PlatformException catch (e) {
      print("failed to pick image");
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: [.6,1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffC9D99D),
                Color(0xffC6926D),
              ])),
      width: w,
      height: h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset('assets/sketch.png'),
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            'Say Cheeese !!!',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: pickimage,
            child: Container(
              child: Image.asset(
                'assets/camera.png',
                scale: .9,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Click camera to upload image',
            style: GoogleFonts.montserrat(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 17),
          )
        ],
      ),
    ));
  }
}
