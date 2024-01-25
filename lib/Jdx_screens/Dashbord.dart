import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:job_dekho_app/Helper/session.dart';

import '../Utils/color.dart';
import 'HomeScreen.dart';
import 'PickPort/RegisterParcel.dart';
import 'MyProfile.dart';
import 'PickPort/new_order_screen.dart';
import 'order_screen.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  //int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final GlobalKey<ScaffoldState> _key = GlobalKey();


  int currentIndex = 1 ;
  int bottomIndex = 0;

  List pageList  = [
    HomeScreen(),
    //OrderHistrry(),
    NewOrderHistroy(),
    //RegistParcelScreen(),
    DrawerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () async {
          // Display a confirmation dialog when the back button is pressed.
          bool exit = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Exit App'),
                content: Text('Are you sure you want to exit the app?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Cancel exit
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Confirm exit
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            },
          );

          return exit ?? false; // Exit if the user confirmed (true) or continue if canceled (false).
        },
        child: Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              //buttonBackgroundColor: Colors.white,
              color: primaryColor,
              backgroundColor: whiteColor,
              items: [
                CurvedNavigationBarItem(
                    child: Icon(Icons.dashboard,color: Colors.white,),
                    label:getTranslated(context, "Home"),
                    labelStyle: TextStyle(color: Colors.white)
                ),
                CurvedNavigationBarItem(
                    child: Image.asset("assets/Orders.png",scale: 1.8,),
                    label: getTranslated(context, "Orders"),
                    labelStyle: TextStyle(color: Colors.white)
                ),
                CurvedNavigationBarItem(
                    child: Icon(Icons.person,color: Colors.white,),
                    label: getTranslated(context, "My Account"),
                    labelStyle: TextStyle(color: Colors.white)
                ),
              ],
              onTap: (index) {
                setState(() {
                  bottomIndex = index;
                });

                //Handle button tap
              },
            ),
            key: _key,
        body: pageList[bottomIndex]
    ),
      );
  }
}
