// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/email_Tab.dart';
// import 'package:job_dekho_app/Utils/color.dart';
// import 'package:job_dekho_app/Views/forgotpassword_Screen.dart';
// import '../Utils/ApiModel/LoginModel.dart';
// import '../Utils/CustomWidgets/mobile_Tab.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../Utils/api_path.dart';
// import 'Recruiter/recruitermyprofile_Screen.dart';
// import 'signup_Screen.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//
//   // var _value = 0;
//   bool isEmail = true;
//
//   Future<LoginModel?> loginEmail() async {
//     print("Api Working@@@");
//     var headers = {
//       'Cookie': 'ci_session=ad447bdb61848f5c85e9459927a16a9bf91e1a0f'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.login}'));
//     request.fields.addAll({
//       'email': '${emailController.text}',
//       'password': '${passwordController.text}',
//     });
//
//     print(request);
//     print("this is new request =====>>> ${request.fields}");
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResponse);
//       print("Nowwwww ${jsonResponse}");
//       if(jsonResponse['staus'] == 'true') {
//         // Fluttertoast.showToast(msg: '${jsonResponse['message']}');
//         print("Working Nowww ${jsonResponse['data']['id']}");
//         // String userId = jsonResponse['data']['id'];
//         // String userEmail = jsonResponse['data']['email'];
//       }
//       Navigator.push(context, MaterialPageRoute(builder: (context) => RecruiterMyProfileScreen()));
//     }
//     else {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResponse);
//       print(jsonResponse.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea
//       (child: Scaffold(
//       backgroundColor: primaryColor,
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 170,
//               decoration: BoxDecoration(
//                 color: primaryColor,
//               ),
//               child: Image.asset('assets/egate_logo.png', scale: 1.3,),
//             ),
//             Container(
//               padding: EdgeInsets.all(14),
//               width: size.width,
//               height: size.height / 1.3,
//               decoration: BoxDecoration(
//                   color: whiteColor,
//                   borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text('Log In', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
//                   SizedBox(height: 10,),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   //   children: [
//                       // Row(
//                       //   children: [
//                       //     // Radio(
//                       //     //   fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
//                       //     //   value: 1, groupValue: _value, onChanged: (value){setState((){isEmail = true;});},),
//                       //     // Text('Email', style: TextStyle(fontWeight: FontWeight.bold),),
//                       //   ],
//                       // ),
//                       // Row(
//                       //   children: [
//                       //     // Radio(
//                       //     //     activeColor: Colors.red,
//                       //     //     fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
//                       //     //     value: 2, groupValue: _value, onChanged: (value){setState(() {isEmail = false;});}),
//                       //     // Text('Mobile', style: TextStyle(fontWeight: FontWeight.bold),),
//                       //   ],
//                       // )
//                     // ],
//                   // ), // Email & Mobile Radio Button
//                   Column(children: [isEmail ? EmailTabs() : MobileTabs()]),
//                   SizedBox(height: 80,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Don't have an account? ", style: TextStyle(color: greyColor,fontWeight: FontWeight.bold),),
//                       GestureDetector(onTap: (){Get.to(SignUpScreen());},child: Text("Sign Up", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )
//     ));
//   }
// }

import 'dart:convert';
import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:job_dekho_app/Helper/session.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/email_Tab.dart';
import 'package:job_dekho_app/Views/Job%20Seeker/seekerdrawer_Screen.dart';
import 'package:job_dekho_app/Views/Job%20Seeker/seekermyprofile_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/HomeScreen.dart';
import 'package:job_dekho_app/Views/Recruiter/postJob_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/MyProfile.dart';
import 'package:job_dekho_app/Views/Recruiter/recruitermyprofile_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/forgotpassword_Screen.dart';
import 'package:job_dekho_app/Views/otp_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/CustomWidgets/TextFields/authTextField.dart';
import '../Utils/CustomWidgets/customTextButton.dart';
import '../Utils/CustomWidgets/mobile_Tab.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Utils/api_path.dart';
import '../Utils/color.dart';
import 'Dashbord.dart';
import 'PickPort/help_Screen.dart';
import 'PickPort/otp_verify_Screen.dart';
import 'signup_Screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // var _value = 'Email';
  // bool isEmail = true;
  bool isloader = false;
  bool showPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? token;

  getToken() async {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = fcmToken.toString();
    });
    print("FCM ID Is______________ $token");
  }

  // String? userid;

  emailPasswordLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=7324f9ce3bb7ccbd4b7dc0920071bc3c06f3ca51'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}Authentication/login'));
    request.fields.addAll({
      'email': '${emailController.text}',
      'password': '${passwordController.text}',
      'token': token.toString(),
    });
    print("Checking all fields here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);

      if (jsonResponse['status'] == true) {
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        print("json response new one here ${jsonResponse}");
        String userid = jsonResponse['data']['user_id'];
        String email = jsonResponse['data']['user_email'];
        String phone = jsonResponse['data']['user_phone'];
        String name = jsonResponse['data']['user_fullname'];

        prefs.setString('userid', userid.toString());
        prefs.setString('email', email.toString());
        prefs.setString('phone', phone.toString());
        prefs.setString('name', name.toString());

        print('__________${prefs.getString('phone')}_____________');
        setState(() {
          isloader = false;
          print("final response>>>>> ${jsonResponse}");
        });
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyStatefulWidget()));
      } else {
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
        setState(() {
          isloader = false;
        });
      }
    } else {
      setState(() {
        isloader = false;
      });
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print(jsonResponse.toString());
      Fluttertoast.showToast(msg: "${jsonResponse['message']}");
    }
  }
  String? mobileOtp,mobileNo;
  bool isLoading =  false;
  loginWithMobileNumberApi() async {

    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=c59791396657a1155df9f32cc7d7b547a40d648c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/login'));
    request.fields.addAll({
     'mobile':mobileController.text
    });
    debugPrint(request.fields.toString() + "jjjjj");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      debugPrint(response.statusCode.toString() + "jjjjj");
      var result =   await response.stream.bytesToString();
      var finalResult =  jsonDecode(result);
      if(finalResult['status'] == false){
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      }else{
        mobileOtp =  finalResult['data']['otp'];
        mobileNo =  finalResult['data']['user_phone'];
        setState(() {
          Fluttertoast.showToast(msg: "${finalResult['message']}");
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerrifyScreen(mobile: mobileNo,otp: mobileOtp,)));
        setState(() {
          isLoading = false;
        });
      }
      // Navigator.push(context, MaterialPa
      // geRoute(builder: (context)=>))


    }
    else if(response.statusCode == 400){
      setState(() {
        isLoading = false;
      });
      var result =   await response.stream.bytesToString();
     var finalResult  = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
    }
    else {
      setState(() {
        setState(() {
          isLoading = false;
        });
      });
      // Fluttertoast.showToast(msg: "Invalid Mobile Number");
      print(response.reasonPhrase);
    }

  }

  int _value = 1;
  bool isMobile = false;
  bool isSendOtp = false;
  bool isVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Exit App',
              style: TextStyle(fontFamily: 'Lora'),
            ),
            content: const Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: const Text(
                  'No',
                  style: TextStyle(fontFamily: 'Lora'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  exit(0);
                  // Navigator.pop(context,true);
                  // Navigator.pop(context,true);
                },
                //return true when click on "Yes"
                child: const Text(
                  'Yes',
                  style: TextStyle(fontFamily: 'Lora'),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
        bottom: true,
        child: Scaffold(
            backgroundColor: primaryColor,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getTranslated(context, 'LOGIN'),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text(
                                    getTranslated(context, "GET_HELP"),
                                    style:
                                    TextStyle(color: primaryColor, fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            getTranslated(context, "Welcome to PickPort"),
                            style: TextStyle(color: whiteColor, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        color: backGround,
                        borderRadius:
                            const BorderRadius.only(topRight: Radius.circular(50))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 1,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Secondry),
                              activeColor: Secondry,
                              groupValue: _value,
                              onChanged: (int? value) {
                                setState(() {
                                  _value = value!;
                                  isMobile = false;
                                });
                              },
                            ),
                            Text(
                              getTranslated(context, "email"),
                              style: const TextStyle(fontSize: 21),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Radio(
                                value: 2,
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Secondry),
                                activeColor: Secondry,
                                groupValue: _value,
                                onChanged: (int? value) {
                                  setState(() {
                                    _value = value!;
                                    isMobile = true;
                                  });
                                }),
                            // SizedBox(width: 10.0,),
                            Text(
                              getTranslated(context, "mobile"),
                              style: const TextStyle(fontSize: 21),
                            ),
                          ],
                        ),
                        isMobile == false
                            ? Column(children: [
                                /// email login section
                                Container(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Material(
                                          elevation: 3,
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/1.1,
                                            height: 50,
                                            child: TextField(
                                              controller: emailController,
                                              keyboardType: TextInputType.emailAddress,
                                              decoration: InputDecoration(

                                                contentPadding:
                                                    const EdgeInsets.only(top: 8),
                                                border: const OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                hintText: getTranslated(context, "Entre_Email"),
                                                prefixIcon: Image.asset(
                                                  'assets/AuthAssets/Icon material-email.png',
                                                  scale: 1.5,
                                                  color: Secondry,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Material(
                                          elevation: 3,
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.1,
                                            height: 50,
                                            child: TextField(
                                              obscureText: isVisible ? false : true,
                                              controller: passwordController,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(top: 8),
                                                border: const OutlineInputBorder(
                                                    borderSide: BorderSide.none),
                                                hintText: getTranslated(
                                                    context, "Password"),
                                                prefixIcon: Image.asset(
                                                  'assets/AuthAssets/Icon ionic-ios-lock.png',
                                                  scale: 1.3,
                                                  color: Secondry,
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isVisible ? isVisible = false : isVisible = true;
                                                    });
                                                  },
                                                  icon: Icon(
                                                    isVisible
                                                        ? Icons.remove_red_eye
                                                        : Icons.visibility_off,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(const Forget());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                    getTranslated(
                                                        context, "Forgot_pass"),
                                                    style: TextStyle(
                                                      color: Secondry,
                                                      fontWeight: FontWeight.bold,
                                                    ))),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        // CustomTextButton(buttonText: 'Sign In', onTap: (){
                                        //   emailPasswordLogin();
                                        //   // Navigator.push(context, MaterialPageRoute(builder: (context)=> SeekerDrawerScreen()));
                                        // }),
                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(context, MaterialPageRoute(builder:(context)=> MyStatefulWidget()));

                                            if(emailController.text == ""){
                                              Fluttertoast.showToast(msg: "Email is required");
                                              return;
                                            }if(passwordController.text == ""){
                                              Fluttertoast.showToast(msg: "Password is required");
                                            }else{
                                              emailPasswordLogin();
                                              setState(() {
                                                isloader = true;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.1,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: primaryColor,
                                            ),
                                            child: isloader == true
                                                ? const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Text(
                                                    getTranslated(
                                                        context, "LOGIN"),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: whiteColor),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ])
                            : const SizedBox.shrink(),
                        const SizedBox(height: 30,),
                        isMobile == true
                            ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Material(
                                elevation: 3,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(

                                  height: 50,
                                  child: TextFormField(
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    controller: mobileController,
                                    decoration: InputDecoration(

                                      prefixText: "+91  ",
                                      counterText: "",
                                      contentPadding: const EdgeInsets.only(top: 10,left: 5),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: getTranslated(
                                          context, "ENTER_MOBILE"),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 50,),
                            InkWell(
                              onTap: (){
                                setState((){
                                  isLoading = true;
                                });
                                if(mobileController.text.isNotEmpty && mobileController.text.length == 10){
                                  print('____Som______xsdvdds_________');
                                  loginWithMobileNumberApi();
                                }else{
                                  setState((){
                                    isLoading = false;
                                  });
                                  Fluttertoast.showToast(msg: "Please enter valid mobile number!",);
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context)
                                    .size
                                    .width /
                                    1.1,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: primaryColor,
                                ),
                                child: isLoading == true
                                    ? const Center(
                                  child:
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                                    : Text( getTranslated(context, "Send Otp"),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.w600,
                                      color: whiteColor),
                                ),
                              ),
                            ),
                          ],
                        )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            bottomSheet: Container(
              color: backGround,
              child: Padding(
                padding:  const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(getTranslated(context, "Don't have an account?"), style: const TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap: () {
                        Get.to(const SignUpScreen());
                      },
                      child: Text(getTranslated(context, "Sign Up"),
                        style: TextStyle(
                            color: Secondry, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
  String _selectedCountryCode = '+91'; // Default country code

}
