import 'dart:async';
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Jdx_screens/HomeScreen.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/trip_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/session.dart';
import '../../Model/order_detail_response.dart';
import '../../Utils/api_path.dart';
import '../../Utils/color.dart';
import '../Dashbord.dart';
import '../Payment method.dart';
import '../notification_Screen.dart';

class BookingConfirmScreen extends StatefulWidget {
  BookingConfirmScreen({Key? key,this.dropLocation,this.picLocation}) : super(key: key);
   String ? dropLocation,picLocation;
  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  TextEditingController  messegeC = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimeDataApi();
  }

  getTimer(){
    timer = Timer.periodic(const Duration(seconds:1 ), (Timer timer) {

      setState(() {
        secondsLeft--;
      });
      if(secondsLeft<0){
        minLeft--;
        secondsLeft=59;
      }
      if(minLeft<1&& secondsLeft<1){
        timer.cancel();
        cancelBookingApi("","0");

      }
    });

    // Timer(pauseDuration, () {
    //   setState(() {
    //   });
    //   timer?.cancel();
    // });
  }
  int? time;
  late FixedExtentScrollController scrollController;
  Timer? timer;
  int counter = 60;
  int secondsLeft = 60;
  int minLeft= 0;
  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    timer?.cancel();
    super.dispose();
  }

  getTimeDataApi() async {
    var headers = {
      'Cookie': 'ci_session=d650e6735d82e1c2ae1d6f29096870e2f01d52e5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/weighting_time'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result = await response.stream.bytesToString();
       var finalResult  = jsonDecode(result);
       setState(() {
         time =int.parse( finalResult['data']['waiting_time']);
         print('____Som______${time}_________');
         minLeft = time!-1;
         getTimer();
       });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  // void startTimer() {
  //    duration =  Duration(minutes: time);
  //
  //   Timer.periodic(duration, (Timer timer) {
  //
  //     print('Timer callback - 5 minutes have passed!');
  //
  //     // If you want to cancel the timer at some point, you can use:
  //     // timer.cancel();
  //   });
  // }
  String? selectedStatus;
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController recipientMobileController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = -1;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true, // Set to true to resize the body when the keyboard is displayed

      backgroundColor: primaryColor,
      bottomSheet:isOpen? BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              height: 280,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius:
                      BorderRadius.circular(10)),
                      elevation: 2,
                      child: Container(
                        decoration: BoxDecoration(color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child:
                        DropdownButtonHideUnderline(
                          child:
                          DropdownButton2<String>(value: selectedStatus,
                            hint: Text("Cancel Order Status",
                              // "Update Delivery Status"
                              style:  TextStyle(
                                  color: backColor,
                                  fontWeight:
                                  FontWeight
                                      .bold),
                            ),
                            isExpanded: true,
                            onChanged: (String?
                            newValue) {
                              //
                              // if (selectedStatus == 'My Reason Is Not In The List') {
                              //  //
                              // }
                              setState(() {
                                selectedStatus = newValue!;
                                if(selectedStatus != 'My Reason Is Not In The List'){
                                  isOpen= true;
                                }


                                print('____Som_hhh_____${selectedStatus}_________');
                              });
                            },
                            items: <String>[
                              'Booking Done By Mistake',
                              'Driver Would not arrive on Time',
                              'Driver Requested to Cancel',
                              'Change In My Mind',
                              'Need to Send Item to Different Address',
                              'Wrong Vehicle Booked',
                              'Cost is High',
                              'Expected Faster Delivery',
                              'My Reason Is Not In The List'
                            ].map<
                                DropdownMenuItem<
                                    String>>((String
                            value) {
                              return DropdownMenuItem<
                                  String>(
                                value: value,
                                child: Text(
                                    value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (selectedStatus == 'My Reason Is Not In The List')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding:
                        const EdgeInsets.only(top: 16.0, left: 20, right: 20),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10)),
                            child:
                            TextFormField(
                             // textAlign: TextAlign.center,
                              maxLines: 3,
                              controller: _otpController,
                              decoration: const InputDecoration(
                                counterText: "",
                                contentPadding:
                                EdgeInsets.only(left: 5),
                                border: InputBorder.none,

                                hintText: "Cancel Reason",
                                // 'Enter OTP',
                              ),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 5,),
                  selectedStatus == null ? SizedBox.shrink():    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            isOpen = false;
                          });

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          width: 80,
                          height: 40,

                          child: Center(child: Text("No",style: TextStyle(
                            color: Colors.white
                          ),)),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            isOpen = false;
                          });
                          cancelBookingApi(selectedStatus.toString(),"2");

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          width: 80,
                          height: 40,

                          child: Center(child: Text("Yes",style: TextStyle(
                              color: Colors.white
                          ),)),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          );
        },
      ):SizedBox(),
      body: Column(
        children: [
          const SizedBox(height: 25,),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyStatefulWidget()));
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: const Center(child: Icon(Icons.arrow_back)),
                    ),
                  ),

                  Text(getTranslated(context, "Booking Confirmed"),style: TextStyle(color: whiteColor,fontSize: 18),),
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
            flex: 14,
            child: Container(
              decoration: BoxDecoration(
                  color: backGround,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50))
              ),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Container(
                    height: 250,
                      child: Image.asset("assets/ProfileAssets/bokingConfirm.png", width: double.infinity)),
                  Text(getTranslated(context, "Booking Successfully"),style: TextStyle(
                    color: primaryColor
                  ),),
                  Text("Searching for a driver ${time} min",style: TextStyle(
                    color: backColor,fontWeight: FontWeight.bold
                  ),),
                   secondsLeft<10? Text("$minLeft : 0$secondsLeft",style: TextStyle(
                   color: backColor,fontWeight: FontWeight.bold
               ),):  Text("0$minLeft : $secondsLeft",style: TextStyle(
                    color: backColor,fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: (){
                                isOpen= true;
                                setState(() {
                                });
                                // showModalBottomSheet(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return StatefulBuilder(
                                //         builder: (context, setState) {
                                //         return ;
                                //       }
                                //     );
                                //   },
                                // );


                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: primaryColor)
                                ),
                                child:  Text(getTranslated(context, "Cancel Trip"), style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,),),
                              )),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>TripDetails(oId: widget.picLocation,)));
                              },
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primaryColor
                                ),
                                child:  Text(getTranslated(context, "Trip Details"), style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,),),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ),
          )

        ],
      ),
    );
  }

String? amt,userid;
  _getCompensationAmmount()async{
    var headers = {
      'Cookie': 'ci_session=406d67c24c747ae88a88a5809e8b6a01e72d97c6'
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}Authentication/get_compensation'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      amt = jsonResponse['data']['compensation'];
      print('__________${amt}_____________');
    }
    else {
      print(response.reasonPhrase);
    }
  }


  cancelBookingApi(String resion,status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString("userid");
    var headers = {
      'Cookie': 'ci_session=5be087b0c4c1b35780570cfe960ca9b361d974b0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Payment/cancel_order'));
    request.fields.addAll({
      'user_id': userid.toString(),
      'order_id':widget.picLocation.toString(),
      'message':_otpController.text,
      'comment':resion.toString(),
      'cancel_by_user':status.toString()
    });
    print('____Som______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var resultFinal = jsonDecode(result);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyStatefulWidget()));
      setState(() {
        Fluttertoast.showToast(msg: "${resultFinal['message']}");
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
}
