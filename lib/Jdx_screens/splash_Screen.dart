import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:job_dekho_app/Jdx_screens/Dashbord.dart';
import 'package:job_dekho_app/Jdx_screens/HomeScreen.dart';
import 'package:job_dekho_app/Jdx_screens/signin_Screen.dart';
import 'package:job_dekho_app/changelanguage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  FlutterGifController? controller1;
  String? userid;
  void checkLogin()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    userid = pref.getString('userid');
     isLan  = await pref.getBool('isLanguage') ?? false;
     setState(() {

     });
  }
  bool? isLan;
  @override
  void initState() {
    // TODO: implement initState
    //Timer(Duration(seconds: 5), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));});
    super.initState();
    controller1 = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller1?.repeat(
        min: 0,
        max: 53,
        period: const Duration(seconds: 5),
      );
    });
    Future.delayed(Duration(seconds: 3),(){
      return checkLogin();
    });


    Future.delayed(Duration(seconds: 5),() async {
      if(userid == null || userid == ""){
        print('____Som______${userid}_________');

        if(isLan == true){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));

        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChangeLanguage()));
        }
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyStatefulWidget()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset("assets/splash.gif"),
        )
        
        // Container(
        //   width: double.infinity,
        //     decoration: const BoxDecoration(
        //         color: Colors.white,
        //         image:DecorationImage(
        //             image:AssetImage('assets/splash screen.png', ),
        //             fit: BoxFit.cover
        //         ),
        //     ),
        //   // child:  GifImage(
        //   //   controller: controller1!,
        //   //   image: const AssetImage("assets/ProfileAssets/pickport user gif - Copy.gif"),
        //   // ),
        // ),
      ),
    );
  }
}

