import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Utils/api_path.dart';
import 'package:job_dekho_app/Jdx_screens/MyProfile.dart';

import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Utils/color.dart';

import '../../Helper/session.dart';
import '../../Model/GetTmc.dart';
import '../../Model/faq_model.dart';



class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFaqApi();
  }
  String? title,dec;
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
              Text(getTranslated(context, "FAQS"),style: TextStyle(color: whiteColor),),
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
        child:faqModel == null ? Center(child: CircularProgressIndicator()):faqModel?.data?.isEmpty ?? false ? Text("No Faq Found!!!"): Container(
            decoration: BoxDecoration(
                color: backGround,
                borderRadius: BorderRadius.only(topRight: Radius.circular(50))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: faqModel?.data?.length ?? 0,

                  itemBuilder: (context,i){
                  // title  = faqModel?.data?[i];
                  //   dec = faqModel?.data?[i];
                return  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primaryColor)
                    ),
                    child:  ExpansionTile(
                      title: Text("${faqModel?.data?[i].question}"),
                      children: [
                        ListTile(
                          title: Html(
                            data: faqModel?.data?[i].answer,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            )


        ),
        )

      ],
    ),
    )
    );
  }
  String? quetion;
  FaqModel ? faqModel;
  getFaqApi() async {

    var headers = {
      'Cookie': 'ci_session=e664e18a8c1eab77c4e0e1d8f3c29c616e85d57f'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/api_faq'));
    request.fields.addAll({
      'type': '2'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  =  await response.stream.bytesToString();
      var finalResult = FaqModel.fromJson(json.decode(result));
      setState(() {
        faqModel =  finalResult;
      });

      print('____Som__gggg____${quetion}_________');
      setState(() {
      });
    }
    else {
      print(response.reasonPhrase);
    }



  }
}
