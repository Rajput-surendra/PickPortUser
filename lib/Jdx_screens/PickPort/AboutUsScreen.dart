import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Utils/api_path.dart';
import 'package:job_dekho_app/Jdx_screens/MyProfile.dart';
import 'package:job_dekho_app/Utils/color.dart';

import '../../Helper/session.dart';
import '../../Model/About_model.dart';
import '../../Model/GetTmc.dart';

import 'package:http/http.dart' as http;

import 'SupportNewScreen.dart';



class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {

  // GetTmc? gettmc;
  // getTermCondition() async {
  //   var headers = {
  //     'Cookie': 'ci_session=e664e18a8c1eab77c4e0e1d8f3c29c616e85d57f'
  //   };
  //   var request = http.MultipartRequest('GET', Uri.parse('https://developmentalphawizz.com/pickport/api/Users/TermsCondition'));
  //   request.fields.addAll({
  //     'type': '2'
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     final result = await response.stream.bytesToString();
  //     var ResultTMC = GetTmc.fromJson(jsonDecode(result));
  //     print(" this is tmccccccccccccccccc${ResultTMC}");
  //     setState(() {
  //       gettmc = ResultTMC;
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }


  AboutModel? aboutModel;
  get() async {
    var headers = {
      'Cookie': 'ci_session=4598d6ec5c3975e6954777d948d0580900a0e8e6'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/about_us_both'));
    request.fields.addAll({
      'type':'1'
    });

    http.StreamedResponse response = await request.send();
    print('____Som______${request}_________');
    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      var finaResult = AboutModel.fromJson(jsonDecode(result));
      setState(() {
        aboutModel = finaResult;
        print('____Som______${aboutModel}_________');
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  // getTermCondition() async {
  //   var headers = {
  //     'Cookie': 'ci_session=99881b4987b7a73271c8992e93cee36c93506e46'
  //   };
  //   var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}Users/TermsCondition'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     final result = await response.stream.bytesToString();
  //     var ResultTMC = GetTmc.fromJson(jsonDecode(result));
  //     print(" this is tmccccccccccccccccc${ResultTMC}");
  //     setState(() {
  //       gettmc = ResultTMC;
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  //
  // }

  // getTermCondition()async{
  //   var headers = {
  //     'Cookie': 'ci_session=e27b9a709e79f067f9b5f2e6f6541ff1595521a5'
  //   };
  //   var request = http.MultipartRequest('GET', Uri.parse('${ApiPath.baseUrl}Users/TermsCondition'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var finalResponse = await response.stream.bytesToString();
  //     final jsonResponse = json.decode(finalResponse);
  //     setState(() {
  //       termData = jsonResponse['data'][0]['html'].toString();
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
    // Future.delayed(Duration(milliseconds: 300),(){
    //   return getTermCondition();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: primaryColor,

            body : Column(
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
              Text(getTranslated(context, "AboutUs"),style: TextStyle(color: whiteColor),),
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
            child:    aboutModel ==  null || aboutModel == "" ? Center(child: CircularProgressIndicator(),) : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text("${aboutModel?.data?.first.title}"),
                 Text("${aboutModel?.data?.first.description}")
                ],
              ),
            ),
        ),
      )

      ],
    ),
    )
    );
  }
}
