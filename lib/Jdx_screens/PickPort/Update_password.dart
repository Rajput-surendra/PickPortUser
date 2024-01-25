import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_dekho_app/Utils/color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Helper/session.dart';


class UpdatePassword extends StatefulWidget {
   UpdatePassword({Key? key,this.MOBILE,this.OTP}) : super(key: key);
  String? OTP,MOBILE;

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final newPasswordC = TextEditingController();
  final CpasswordC = TextEditingController();

  final pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? newPin;
  @override
  Widget build(BuildContext context) {

    verifyOtp() async {
      var headers = {
        'Cookie': 'ci_session=8aab49b6e6c12572dfec865bf8b192a8a73d19de'
      };
      var request = http.MultipartRequest('POST', Uri.parse('https://drplusapp.in/app/v1/api/verify_otp'));
      request.fields.addAll({
        'mobile': widget.MOBILE.toString(),
        'otp': pinController.text,
        'otp_text': widget.OTP.toString(),
        'password': newPasswordC.text,
        'cnf_password': CpasswordC.text
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var finalResult =  jsonDecode(result);
        Fluttertoast.showToast(msg: "${finalResult['message']}",backgroundColor: Secondry);
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      else {
      print(response.reasonPhrase);
      }

    }
    return Scaffold(

      body:  Column(
        children: [
          SizedBox(height: 10,),

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(child: Icon(Icons.arrow_back)),
                    ),
                  ),
                  Text(getTranslated(context, "Notification"),style: TextStyle(color: whiteColor),),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Container(
                decoration: BoxDecoration(
                    color: backGround,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50))
                ),
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Center(
                            child: Form(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PinCodeTextField(

                                    //errorBorderColor:Color(0xFF5ACBEF),
                                    //defaultBorderColor: Color(0xFF5ACBEF),
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value) {
                                      // controller.otp = value.toString() ;
                                      newPin = value.toString();
                                    },
                                    textStyle: const TextStyle(color: Colors.white),
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(10),
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white,
                                      fieldHeight: 60,
                                      fieldWidth: 60,
                                      inactiveFillColor: Colors.white,
                                      activeFillColor: Colors.white,
                                    ),
                                    //pinBoxRadius:20,
                                    appContext: context, length: 4 ,
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "New Password",
                              style: TextStyle(
                                  color: backColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: newPasswordC,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: '',
                                hintStyle:
                                TextStyle(fontSize: 15.0, color: Secondry),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: EdgeInsets.only(left: 10, top: 10)),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "password is required";
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Confirm New Password",
                              style: TextStyle(
                                  color: backColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: CpasswordC,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: '',
                                hintStyle:
                                TextStyle(fontSize: 15.0, color: Secondry),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: EdgeInsets.only(left: 10, top: 10)),
                            validator: (v) {
                              if (newPasswordC.text != CpasswordC.text) {
                                return "password must be same";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          // Center(
                          //   child: Btn(
                          //     color: colors.secondary,
                          //     height: 50,
                          //     width: 320,
                          //     title: 'Update Password',
                          //     onPress: () {
                          //       if (_formKey.currentState!.validate()) {
                          //         verifyOtp();
                          //       }
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),

            ),
          )

        ],
      ),


    );
  }

}
