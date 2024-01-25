// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/customTextButton.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextFormField.dart';
// import '../Utils/color.dart';
// import 'signin_Screen.dart';
//
// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }
//
// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         //centerTitle: true,
//         backgroundColor: Colors.transparent,
//         leading: GestureDetector(
//           onTap: (){
//             Get.to(SignInScreen());
//           },
//           child: Icon(Icons.arrow_back_ios, color: primaryColor, size: 26),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Container(
//             //   width: 250,
//             //   height: 300,
//             //   child: Image.asset('assets/AuthAssets/forgotpassword.png'),
//             // ),
//             SizedBox(height: 25,),
//             Text("Forget Password?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'Lora'),),
//             SizedBox(height: 20,),
//             Text('Enter email associated \n with your account', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: greyColor1,fontFamily: 'Lora'),textAlign: TextAlign.center,),
//             CustomTextFormField(label: "Email"),
//             SizedBox(height: 50,),
//             CustomTextButton(buttonText: "Submit")
//           ],
//         ),
//       ),
//     ));
//   }
// }
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Helper/session.dart';
import '../Utils/CustomWidgets/TextFields/customTextFormField.dart';
import '../Utils/api_path.dart';
import '../Utils/color.dart';
import 'PickPort/Update_password.dart';
import 'package:http/http.dart' as http;

import 'PickPort/help_Screen.dart';
import 'PickPort/otp_verify_Screen.dart';



class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();

  // loginwitMobile() async {
  //   String? token ;
  //   try{
  //     token  = await FirebaseMessaging.instance.getToken();
  //
  //   } on FirebaseException{
  //   }
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('otp', "otp");
  //   preferences.setString('mobile', "mobile");
  //   print("this is apiiiiiiii");
  //   var headers = {
  //     'Cookie': 'ci_session=b13e618fdb461ccb3dc68f327a6628cb4e99c184'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${bal.sendForgotOtp}'));
  //   request.fields.addAll({
  //     'mobile': mobileController.text,
  //     'fcm_id' : '${token}'
  //   });
  //   ///Are ghar jaao enjoy karo
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var finalresponse = await response.stream.bytesToString();
  //     final jsonresponse = json.decode(finalresponse);
  //
  //     if (jsonresponse['error'] == false) {
  //       String otp = jsonresponse['data'][0]["otp"];
  //       String mobile = jsonresponse['data'][0]["mobile"];
  //
  //       Fluttertoast.showToast(msg: '${jsonresponse['message']}',backgroundColor: Secondry);
  //       Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => UpdatePassword(OTP: otp.toString(),MOBILE:mobile.toString() ,)
  //           ));
  //     }
  //     else{
  //       Fluttertoast.showToast(msg: "${jsonresponse['message']}",backgroundColor: Secondry);
  //     }
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body:Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Center(child: Icon(Icons.arrow_back)),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(getTranslated(context, "Forgot_pass1"),style: TextStyle(color: whiteColor,fontSize: 18),),
                        ],
                      ),
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
                  SizedBox(height: 10,),
                  Text(
                    getTranslated(context, "Welcome to PickPort"),
                    style: TextStyle(color: whiteColor, fontSize: 20),
                  )
                ],
              )
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                  color: backGround,
                  borderRadius:
                  BorderRadius.only(topRight: Radius.circular(50))),
              child:   Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        child: Card(
                          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 1,
                          child: Center(
                            child: TextFormField(
                              controller: mobileController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              validator: (v) {
                                if (v!.length != 10 ||  v.isEmpty) {
                                  return "mobile number is required";
                                }
                              },
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                contentPadding:
                                EdgeInsets.only(left: 15, top: 12),
                                hintText: "Mobile Number",hintStyle: TextStyle(color: primaryColor),
                                prefixIcon: Icon(
                                  Icons.call,
                                  color:primaryColor,
                                  size: 20,
                                ),

                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                        onTap: (){
                          setState((){
                            isLoading = true;
                          });
                       //   print('____Som______${mobileController.text.isNotEmpty}_________');

                          if(_formKey.currentState!.validate()){
                            print('____Som______${mobileController.text.length}_________');

                            loginWithMobileNumberApi();
                          }else{
                            setState((){
                              isLoading = false;
                            });
                            Fluttertoast.showToast(msg: "Please enter  mobile number!",);
                          }
                        },
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 0,top: 10,bottom: 10),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width/1.2,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: primaryColor),
                            child:
                            Center(child: Text(getTranslated(context, "Send Otp"), style: TextStyle(fontSize: 18, color: whiteColor))),
                          ),
                        )
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),



    );
  }


  String? mobileOtp,mobileNo;
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
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =   await response.stream.bytesToString();
      var finalResult =  jsonDecode(result);
      print('____Som_ccccc_____${result }_________');
      setState(() {
        isLoading = false;
      });

      if(finalResult['status'] == false){

        Fluttertoast.showToast(msg: "vvxcvxcvxcvc");
      }else{
        mobileOtp =  finalResult['data']['otp'];
        mobileNo =  finalResult['data']['user_phone'];
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerrifyScreen(mobile: mobileNo,otp: mobileOtp,isForget: true,)));
        setState(() {
          isLoading = false;
        });
      }
      // Navigator.push(context, MaterialPa
      // geRoute(builder: (context)=>))


    }
    else if(response.statusCode == 400){
      var result =   await response.stream.bytesToString();
      var finalResult =  jsonDecode(result);
      Fluttertoast.showToast(msg: finalResult['message']);
    }
    else {
      setState(() {
        setState(() {
          isLoading = false;
        });
      });
      print(response.reasonPhrase);
    }

  }
}
