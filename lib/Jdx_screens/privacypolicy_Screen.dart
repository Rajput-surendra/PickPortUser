import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Utils/api_path.dart';

import '../Helper/session.dart';
import '../Model/privacypolicy.dart';
import '../Model/privacypolicymodel.dart';
import '../Utils/color.dart';
import 'MyProfile.dart';
import 'package:http/http.dart' as http;

import 'notification_Screen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  var privacyData;

  PrivacypolicyModel? privacypolicy;
  getPrivacy()async{
    var headers = {
      'Cookie': 'ci_session=e664e18a8c1eab77c4e0e1d8f3c29c616e85d57f'
    };
    var request = http.MultipartRequest('GET', Uri.parse('${ApiPath.baseUrl}users/Privacy'));
    request.fields.addAll({
      'type': '2'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print("thisssssssssssssssss==============>${response}");

      var finalResponse =await response.stream.bytesToString();
      var jsonResponse = PrivacypolicyModel.fromJson(jsonDecode(finalResponse));

      setState(() {
        // privacypolicy = jsonResponse;
        privacyData = jsonResponse.data ;
        //log('${item?.pgDescri}____________________hello');
        // print("privacy policy ${privacypolicy}");
        // print("thisssssssssssssssss==============>${finalResponse}");

      });
    }
    else {
      print(response.reasonPhrase);
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getPrivacy();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: primaryColor,

            body:  Column(
              children: [
                SizedBox(height: 10,),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text(getTranslated(context, "Privacy Policy"),style: TextStyle(color: whiteColor),),
                        Container(
                          height: 40,
                          width: 40,
                          decoration:  BoxDecoration(
                              color: splashcolor,
                              borderRadius:
                              BorderRadius.circular(100)),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const SupportNewScreen()));
                              },
                              child: Center(
                                child: Image.asset(
                                  'assets/ProfileAssets/support.png',scale: 1.3,
                                ),
                              )),
                        ),
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
                      child:   privacyData == null || privacyData == "" ? Center(child: CircularProgressIndicator(),) : Container(

                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
                            color: Colors.white
                        ),
                        width: size.width,
                        height: size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Html(data: "${privacyData}"),
                              Text('${privacyData?.pgDescri}', style:  TextStyle(fontSize: 16,),),

                            ],
                          ),
                        ),
                      )

                  ),
                )

              ],
            ),




        ));;
  }
}
