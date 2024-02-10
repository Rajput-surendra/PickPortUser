import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:job_dekho_app/Helper/session.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';

import 'package:job_dekho_app/Utils/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/notifymodel.dart';
import '../Utils/color.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  Notifymodel? notificationhistory;
  getNotification()async{
    print("Notification Api....");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    var headers = {
      'Cookie': 'ci_session=e27b9a709e79f067f9b5f2e6f6541ff1595521a5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Payment/GetNotificationList'));
    request.fields.addAll({
      'user_id': userid.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = Notifymodel.fromJson(json.decode(finalResponse));

      print("noiiiiiiiiiiiiiiiiiiiiiii==========>${finalResponse}");
      print("noiiiiiiiiiiiiiiiiiiiiiii==========>${jsonResponse}");
      setState(() {
        notificationhistory = jsonResponse;
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
      return getNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Column(
            children: [

              Expanded(
                flex: 2,
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
                      Text(getTranslated(context, "Notification"),style: TextStyle(color: whiteColor,fontSize: 18),),
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
                flex: 13,
                child: Container(
                    decoration: BoxDecoration(
                        color: backGround,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(50))
                    ),
                    child: notificationhistory == null || notificationhistory == "" ? Center(child: CircularProgressIndicator(),) :
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: notificationhistory!.data!.length,
                          itemBuilder: (c,i){
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text("${notificationhistory!.data![i].notification}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'Lora'),)),
                                        Expanded(child: Text("${notificationhistory!.data![i].date}", style: TextStyle(color: greyColor2,fontSize: 12, fontWeight: FontWeight.bold,fontFamily: 'Lora'),)),
                                      ],
                                    ),
                                    Text("${notificationhistory!.data![i].notification}",maxLines: 2,style: TextStyle(fontFamily: 'Lora'),)
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



        ));
  }
}
