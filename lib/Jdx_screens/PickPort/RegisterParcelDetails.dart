import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_dekho_app/Jdx_screens/Dashbord.dart';
import 'package:job_dekho_app/Jdx_screens/Editrecipentcart.dart';
import 'package:job_dekho_app/Jdx_screens/HomeScreen.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Jdx_screens/parceldetailsscreen.dart';
//import 'package:place_picker/entities/location_result.dart';
//import 'package:place_picker/widgets/place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Jdx_screens/PickPort/select_Vehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/session.dart';
import '../../Model/Booking_Single_Data_Model.dart';
import '../../Model/MaterialCategoryModel.dart';
import '../../Model/ParcelWeightModel.dart';
import '../../Model/getprofilemodel.dart';
import '../../Model/registerparcelmodel.dart';
import '../../Utils/api_path.dart';
import '../../Utils/color.dart';
import '../notification_Screen.dart';

class RegisterParcelDetails extends StatefulWidget {
   RegisterParcelDetails({Key? key,this.dropLocation,this.picLocation,this.lat1,this.long1,this.lat2,this.long2,this.orderId}) : super(key: key);
   String ? dropLocation,picLocation,orderId;
   double? lat1 = 0.0;
   double? long1 = 0.0;
   double? lat2 = 0.0;
   double? long2 = 0.0;
  @override
  State<RegisterParcelDetails> createState() => _RegisterParcelDetailsState();
}

class _RegisterParcelDetailsState extends State<RegisterParcelDetails> {
  // TextEditingController senderNameController = TextEditingController();

  //
  // TextEditingController recipientAddressCtr = TextEditingController();
  // TextEditingController recipientnewAddressCtr = TextEditingController();
  // TextEditingController senderAddressCtr = TextEditingController();
  // TextEditingController nameC = TextEditingController();
  // TextEditingController senderfulladdressCtr = TextEditingController();

  // TextEditingController pincodeC = TextEditingController();
  // TextEditingController cityC = TextEditingController();
  // TextEditingController valueController = TextEditingController();
  //
  // // TextEditingController addressC = TextEditingController();
  // TextEditingController receiverfulladdressCtr = TextEditingController();
  //
  // TextEditingController stateC = TextEditingController();
  // TextEditingController countryC = TextEditingController();
  // TextEditingController latitudeC = TextEditingController();
  // TextEditingController longitudeC = TextEditingController();

   TextEditingController recipientMobileController = TextEditingController();
  TextEditingController senderMobileController = TextEditingController();
  TextEditingController   recipientNameController = TextEditingController();
   TextEditingController picUpController = TextEditingController();
   TextEditingController picTimeController = TextEditingController();
   TextEditingController homeController = TextEditingController();



  // String radioButtonItem = 'ONE';
  int id = 0;

  Registerparcelmodel? parcelDetailsModel;

 List receiverList = [];
String? mId;
  // List<String>  selectedvalue = [];
   String? userName,userMobile;
  // Getprofilemodel? getprofile;
  // getuserProfile() async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? userid = preferences.getString("userid");
  //   var headers = {
  //     'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}User_Dashboard/getUserProfile'));
  //   request.fields.addAll({
  //     'user_id': userid.toString()
  //   });
  //
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var finalResult = await response.stream.bytesToString();
  //     final jsonResponse = Getprofilemodel.fromJson(json.decode(finalResult));
  //     setState(() {
  //       getprofile = jsonResponse;
  //       userName = getprofile!.data!.first.firstname.toString();
  //       userMobile = getprofile!.data!.first.firstname.toString();
  //       print('____Som______${userName}_________');
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }
  bool isLoading =  false;
  senParcel() async {
    print(_value.toString()+"+++++++++++++++");
    var data=_value.toString();
    receiverList.clear();
   if(receiverList.isEmpty){
     receiverList.add(
         {

          "meterial_category": "${selectedValue.toString()}",
           //"parcel_weight": "${selectedValue.toString()}",
           "parcel_weight": "",
           "receiver_address": "${widget.dropLocation.toString()}",
           "receiver_latitude": "${widget.lat2}",
           "receiver_longitude": "${widget.long2}",
           "receiver_name": "${recipientNameController.text}",
           "receiver_phone": "${recipientMobileController.text}",
           "reciver_full_address": "${homeController.text}",
           "booking_type":_value.toString(),
           "booking_date":_value.toString() == "0" ? "${getDate()}":picUpController.text,
           "booking_time": _value.toString() == "0" ? "${getTime()}":picTimeController.text,
           "pacel_value" : "",

         });


   }
    print(_value.toString()+"+++++++++++++++");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
      userName = prefs.getString('name');
      userMobile = prefs.getString('phone');
      print('____Som___ffff___${userMobile}_________');
    String? orderid = prefs.getString("orderid");

    print("User Id ${userid.toString()}");
    // print("this is my order id>>>>>>>>>>>>>>${orderid}");
    print("Register and Sender Parcel");
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=1b21f643064e1ac4622693b37863ecfa449561dd',
    };
    var request = http.Request(
        'POST', Uri.parse('${ApiPath.baseUrl}payment/send_parcel'));
     request.body = json.encode({
      "sender_name":userName.toString(),
      "sender_address":widget.picLocation.toString(),
      "sender_phone":userMobile.toString(),
      "sender_latitude": widget.lat1 == null ? latSender :"${widget.lat1}",
      "sender_longitude": widget.long1 == null ? longSender :"${widget.long1}",
      "sender_fulladdress":widget.picLocation.toString(),
      "user_id": "${userid}",
      "data_arr": receiverList,
    });
    print("This is request here>>>>>>>>${request.body}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Working Now Here");
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = Registerparcelmodel.fromJson(json.decode(finalResult));
      String orderid = jsonResponse.orderId.toString();
      prefs.setString('orderid', orderid.toString());
      setState(() {
        isLoading = false;
        parcelDetailsModel = jsonResponse;
        print('____Som___hai___${parcelDetailsModel?.cap?.length}_________');
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ParceldetailsScreen(orderid: orderid, isFromParcelHistory: false,)));

          Navigator.push(context, MaterialPageRoute(builder: (context)=>SelcetVhicle(VichleList: parcelDetailsModel,dropLocation: widget.dropLocation,picLocation: widget.picLocation,senderName: userName,senderMobile: userMobile,

        //Navigator.push(context, MaterialPageRoute(builder: (context)=>SelcetVhicle(VichleList: parcelDetailsModel,dropLocation: widget.dropLocation,picLocation: widget.picLocation,senderName: userName,senderMobile: userMobile,
          receiverName: recipientNameController.text,receiverMobile: recipientMobileController.text,orderId: parcelDetailsModel?.orderId.toString(),
        )));
      });
    }
    else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

 CatData? catData;
  dynamic catIdString;
  MaterialCategoryModel? materialCategoryModel;
  materialCategory() async {
    var headers = {
      'Cookie': 'ci_session=18b59dc18c8193fd4e5e1c025a6904983b2ca7e4'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('${ApiPath.baseUrl}Products/Category'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Material category");
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = MaterialCategoryModel.fromJson(
          json.decode(finalResult));
      print("final Result>>>>>>> ${finalResult.toString()}");
      setState(() {
        materialCategoryModel = jsonResponse;
        print('____Som______${bookingSingleDataModel?.data?.meterialCategory}_________');
        // catIdString = materialCategoryModel?.data?.firstWhere((item) {
        //   if(item.title == bookingSingleDataModel?.data?.meterialCategory){
        //     print("${item.title}"+"__________xxxxxxxxxxx_______${catIdString}__");
        //
        //     return true;
        //   }
        //   else{
        //     return false;
        //   }
        // });
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  ParcelWeightModel? parcelWeightModel;

  parcelWeight() async {
    var headers = {
      'Cookie': 'ci_session=18b59dc18c8193fd4e5e1c025a6904983b2ca7e4'
    };
    var request = http.MultipartRequest(
        'GET', Uri.parse('${ApiPath.baseUrl}Products/getweight'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = ParcelWeightModel.fromJson(json.decode(finalResult));
      print("final Result>>>>>>> ${finalResult.toString()}");
      setState(() {
        parcelWeightModel = jsonResponse;
      });
    }
    else {
      print("Enterrrrrrrrrr");
      print(response.reasonPhrase);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSingleDataApi();
    materialCategory();
    // Future.delayed(Duration(milliseconds: 100), () {
    //   return
    //
    // });

    // Future.delayed(Duration(milliseconds: 100), () {
    //   return parcelWeight();
    // });
    _getCompensationAmmount();

  }

  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  String? selectedValue1;
  String? amt;
  double?  lat;
  double?  long;
  int _value = 0;
  bool isCurrent = false;
  bool isSchedule = false;
  String? selectedFromDate;
   String? date ,time;
   String _dateValue = '';
   var dateFormate;
   String convertDateTimeDisplay(String date)  {
     final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
     final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
     final DateTime displayDate = displayFormater.parse(date);
     final String formatted = serverFormater.format(displayDate);
     return formatted;
   }
   Future _selectDateStart() async {
     DateTime? picked = await showDatePicker(
         context: context,
         initialDate:  DateTime.now(),
         firstDate: DateTime.now(),
         lastDate: DateTime(2025),
         //firstDate: DateTime.now().subtract(Duration(days: 1)),
         // lastDate: new DateTime(2022),
         builder: (BuildContext context, Widget? child) {
           return Theme(
             data: ThemeData.light().copyWith(
                 primaryColor: primaryColor,
                 accentColor: Colors.black,
                 colorScheme:  ColorScheme.light(primary:  primaryColor),
                 // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                 buttonTheme:
                 ButtonThemeData(textTheme: ButtonTextTheme.accent)),
             child: child!,
           );
         });
     if (picked != null)
       setState(() {
         String yourDate = picked.toString();
         _dateValue = convertDateTimeDisplay(yourDate);
         print(_dateValue);
         dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
         picUpController = TextEditingController(text: _dateValue);

       });
   }
   getDate(){
     DateTime now = DateTime.now();
     String formattedDateTime = "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
     // date =  formattedDateTime.substring(0,11);
     return formattedDateTime.substring(0,9);
   }
   getTime(){
     DateTime now = DateTime.now();
     String formattedDateTime = "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
     // date =  formattedDateTime.substring(0,11);
     // time =  formattedDateTime.substring(9,14);
     return formattedDateTime.substring(10,15);
   }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
     date =  formattedDateTime.substring(0,11);
      time =  formattedDateTime.substring(9,14);
    print('____Som__sssssss____${formattedDateTime}____${time}_____');

    // Data data = materialCategoryModel!.data![0].title;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(height: 25,),
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
                  Text("Booking Details",style: TextStyle(color: whiteColor,fontSize: 18),),
                 //Text(getTranslated(context, "orders"),style: TextStyle(color: whiteColor),),
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
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50))
              ),
              child:
              ListView(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [
                  Form(
                    key: _formKey,
                    child: Container(
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,width: 30,
                                  child: Image.asset(
                                    'assets/ProfileAssets/drop location.png',scale: 1.1,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.5,
                                        child: Text(widget.dropLocation.toString(),overflow: TextOverflow.ellipsis,maxLines: 1,))
                                  ],
                                )

                              ],
                            ),
                          ),
                          // ///senderdetails
                          // Column(
                          //   children: const [
                          //     Padding(
                          //       padding: EdgeInsets.only(left: 20.0),
                          //       child: Text("Sender Details", style: TextStyle(
                          //           fontSize: 20, fontWeight: FontWeight.bold),),
                          //     ),
                          //   ],
                          // ),
                          // Center(
                          //   child: Column(
                          //     children: [
                          //       const SizedBox(height: 20,),
                          //       Material(
                          //         color: splashcolor,
                          //         elevation: 1,
                          //         borderRadius: BorderRadius.circular(10),
                          //         child: SizedBox(
                          //           width: MediaQuery
                          //               .of(context)
                          //               .size
                          //               .width / 1.2,
                          //           height: 60,
                          //           child: TextFormField(
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return 'Enter Sender Name';
                          //               }
                          //               return null;
                          //             },
                          //             controller: senderNameController,
                          //             decoration: InputDecoration(
                          //               border: const OutlineInputBorder(
                          //                   borderSide: BorderSide.none
                          //               ),
                          //               hintText: "Sender Name",
                          //               prefixIcon: Image.asset(
                          //                 'assets/AuthAssets/Icon awesome-user.png',
                          //                 scale: 2.1, color: primaryColor,),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(height: 20,),
                          //       Material(
                          //         color: splashcolor,
                          //         elevation: 1,
                          //         borderRadius: BorderRadius.circular(10),
                          //         child: Container(
                          //           width: MediaQuery
                          //               .of(context)
                          //               .size
                          //               .width / 1.2,
                          //           height: 60,
                          //           child: TextFormField(
                          //             maxLength: 10,
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return "Enter Phone No.";
                          //               }
                          //               return null;
                          //             },
                          //             controller: senderMobileController,
                          //             keyboardType: TextInputType.number,
                          //             decoration: InputDecoration(
                          //               border: const OutlineInputBorder(
                          //                   borderSide: BorderSide.none
                          //               ),
                          //               hintText: "Sender Mobile No.",
                          //               counterText: "",
                          //               prefixIcon: Image.asset(
                          //                 'assets/AuthAssets/Icon ionic-ios-call.png',
                          //                 scale: 2.1, color: primaryColor,),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(height: 20,),
                          //       // _addressField(context),
                          //       Material(
                          //         color: splashcolor,
                          //         elevation: 1,
                          //         borderRadius: BorderRadius.circular(10),
                          //         child: SizedBox(
                          //           width: MediaQuery
                          //               .of(context)
                          //               .size
                          //               .width / 1.2,
                          //           height: 60,
                          //           child: TextFormField(
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return 'Please Enter Sender Address';
                          //               }
                          //               return null;
                          //             },
                          //             readOnly: true,
                          //             controller: senderAddressCtr,
                          //             maxLines: 1,
                          //             onTap: () {
                          //               //_getLocation1();
                          //
                          //               Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                   builder: (context) => PlacePicker(
                          //                     apiKey: Platform.isAndroid
                          //                         ? "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY"
                          //                         : "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY",
                          //                     onPlacePicked: (result) {
                          //                       print(result.formattedAddress);
                          //                       setState(() {
                          //                         senderAddressCtr.text =
                          //                             result.formattedAddress.toString();
                          //                         lat1 = result.geometry!.location.lat;
                          //                         long1 = result.geometry!.location.lng;
                          //                       });
                          //                       Navigator.of(context).pop();
                          //                     },
                          //                     initialPosition: LatLng(
                          //                         22.719568,75.857727),
                          //                     useCurrentLocation: true,
                          //                   ),
                          //                 ),
                          //               );
                          //             },
                          //             textInputAction: TextInputAction.next,
                          //             decoration: InputDecoration(
                          //               border: const OutlineInputBorder(
                          //                   borderSide: BorderSide.none
                          //               ),
                          //               hintText: "Sender Address",
                          //               prefixIcon: Image.asset(
                          //                 'assets/ProfileAssets/locationIcon.png',
                          //                 scale: 1.5, color: primaryColor,),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       const SizedBox(height: 20,),
                          //       Material(
                          //         color: splashcolor,
                          //         elevation: 1,
                          //         borderRadius: BorderRadius.circular(10),
                          //         child: Container(
                          //           width: MediaQuery
                          //               .of(context)
                          //               .size
                          //               .width / 1.2,
                          //           height: 80,
                          //           child: TextFormField(
                          //             validator: (value) {
                          //               if (value == null || value.isEmpty) {
                          //                 return 'This Field Is Required';
                          //               }
                          //               return null;
                          //             },
                          //             controller: senderfulladdressCtr,
                          //             decoration: InputDecoration(
                          //               border: const OutlineInputBorder(
                          //                 borderSide: BorderSide.none,
                          //               ),
                          //               hintText: "flat number,floor,building name,etc",
                          //               prefixIcon: Image.asset(
                          //                 'assets/ProfileAssets/locationIcon.png',
                          //                 scale: 1.7, color: primaryColor,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],),
                          // ),

                          ///recipentdetails
                           SizedBox(height: 15,),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(getTranslated(context, "House/ Apartment (Optional)"),style: TextStyle(fontSize: 13),),
                                  SizedBox(height: 5,),
                                  Material(
                                    color: whiteColor,
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 1.1,
                                      height: 60,
                                      child: TextFormField(
                                        // validator: (value) {
                                        //   if (value == null || value.isEmpty) {
                                        //     return 'House/ Apartment';
                                        //   }
                                        //   return null;
                                        // },
                                        controller: homeController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Text(getTranslated(context, "Receiver's Name"),style: TextStyle(fontSize: 13),),
                                  SizedBox(height: 5,),
                                  Material(
                                    color: whiteColor,
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 1.1,
                                      height: 60,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Enter Receiver Name';
                                          }
                                          return null;
                                        },
                                        controller: recipientNameController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Text(getTranslated(context, "Receiver's Mobile Number"),style: TextStyle(fontSize: 13),),
                                  SizedBox(height: 5,),
                                  Material(
                                    color: whiteColor,
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 1.1,
                                      height: 60,
                                      child: TextFormField(
                                        maxLength: 10,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return ' Enter Receiver Phone No.';
                                          }
                                          return null;
                                        },
                                        controller: recipientMobileController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        //  hintText: "Recipient Mobile No.",
                                          counterText: '',
                                          suffixIcon: Icon(Icons.person,color: Secondry,),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Text(getTranslated(context, "Parcel Details"),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Material(
                                    color: whiteColor,
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 55,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 1.1,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        underline: Container(),
                                        value: selectedValue,
                                        hint:  Padding(
                                          padding: EdgeInsets.only(left: 5,top: 5),
                                          child: Text(getTranslated(context, "Material Category")),
                                        ),
                                        icon: Padding(
                                          padding: const EdgeInsets.only(top: 10,right: 5),
                                          child: Icon(Icons.keyboard_arrow_down,
                                              color: Secondry,size: 30,),
                                        ),
                                        items: materialCategoryModel?.data!.map((items) {
                                          return DropdownMenuItem(
                                            value: items.id.toString(),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: Text(items.title.toString()
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedValue = newValue!;
                                            print('____Som___selectedValue___${selectedValue}_________');
                                          });
                                        },
                                      ),
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 10),
                                  //   child: Card(
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //       //set border radius more than 50% of height and width to make circle
                                  //     ),
                                  //     elevation: 1,
                                  //     child: Container(
                                  //         height: 60,
                                  //         width: double.infinity,
                                  //         decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.circular(10),
                                  //             color: CustomColors.TransparentColor),
                                  //         child: DropdownButtonHideUnderline(
                                  //           child: DropdownButton<dynamic>(
                                  //             icon: Padding(
                                  //               padding: const EdgeInsets.only(top: 10,right: 5),
                                  //               child: Icon(Icons.keyboard_arrow_down,
                                  //                 color: Secondry,size: 30,),
                                  //             ),
                                  //             //hint:  Text(getTranslated(context, "State"),
                                  //             hint:  Padding(
                                  //               padding: const EdgeInsets.all(8.0),
                                  //               child: Text(
                                  //                 getTranslated(context, "Material Category"),
                                  //                 style: const TextStyle(
                                  //                     color: Colors.black54,
                                  //                     fontSize: 15),
                                  //               ),
                                  //             ),
                                  //             value: catIdString,
                                  //
                                  //             // icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:Secondry,size: 25,),
                                  //             style:  TextStyle(
                                  //                 color: Secondry,
                                  //                 fontWeight: FontWeight.bold),
                                  //             underline: Padding(
                                  //               padding: const EdgeInsets.only(
                                  //                   left: 5, top: 4),
                                  //               child: Container(
                                  //                 // height: 2,
                                  //                 color: whiteColor,
                                  //               ),
                                  //             ),
                                  //             onChanged: ( value) {
                                  //               setState(() {
                                  //                 catIdString = value!;
                                  //                 //  stateId = getCityList?.stateId;
                                  //                 //animalCountApi(animalCat!.id);
                                  //               });
                                  //             },
                                  //             items: materialCategoryModel?.data!.map((items) {
                                  //               return DropdownMenuItem(
                                  //                 value: items,
                                  //                 child: Column(
                                  //                   crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //                   mainAxisAlignment:
                                  //                   MainAxisAlignment.center,
                                  //                   children: [
                                  //                     Padding(
                                  //                       padding: const EdgeInsets.only(
                                  //                           top: 2),
                                  //                       child: Container(
                                  //                           child: Padding(
                                  //                             padding:
                                  //                             const EdgeInsets.only(
                                  //                                 top: 0,left: 10),
                                  //                             child: Text(
                                  //                               items.title.toString(),
                                  //                               overflow:
                                  //                               TextOverflow.ellipsis,
                                  //                               style: const TextStyle(
                                  //                                   color: Colors.black54),
                                  //                             ),
                                  //                           )),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               );
                                  //             }).toList(),
                                  //           ),
                                  //         )),
                                  //   ),
                                  // ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 10),
                                  //   child: Card(
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //       //set border radius more than 50% of height and width to make circle
                                  //     ),
                                  //     elevation: 1,
                                  //     child: Container(
                                  //         height: 60,
                                  //         width: double.infinity,
                                  //         decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.circular(10),
                                  //             color: CustomColors.TransparentColor),
                                  //         child: DropdownButtonHideUnderline(
                                  //           child: DropdownButton<dynamic>(
                                  //             icon: Padding(
                                  //               padding: const EdgeInsets.only(top: 10,right: 5),
                                  //               child: Icon(Icons.keyboard_arrow_down,
                                  //                 color: Secondry,size: 30,),
                                  //             ),
                                  //             //hint:  Text(getTranslated(context, "State"),
                                  //             hint:  Padding(
                                  //               padding: const EdgeInsets.all(8.0),
                                  //               child: Text(
                                  //                 getTranslated(context, "Material Category"),
                                  //                 style: const TextStyle(
                                  //                     color: Colors.black54,
                                  //                     fontSize: 15),
                                  //               ),
                                  //             ),
                                  //             value: catIdString,
                                  //
                                  //             // icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:Secondry,size: 25,),
                                  //             style:  TextStyle(
                                  //                 color: Secondry,
                                  //                 fontWeight: FontWeight.bold),
                                  //             underline: Padding(
                                  //               padding: const EdgeInsets.only(
                                  //                   left: 5, top: 4),
                                  //               child: Container(
                                  //                 // height: 2,
                                  //                 color: whiteColor,
                                  //               ),
                                  //             ),
                                  //             onChanged: ( value) {
                                  //               setState(() {
                                  //                 catIdString = value!;
                                  //
                                  //                 print('____Som______${catIdString.id}_________');
                                  //                mId = catIdString.id;
                                  //                 //animalCountApi(animalCat!.id);
                                  //               });
                                  //             },
                                  //             items: materialCategoryModel?.data!.map((items) {
                                  //               return DropdownMenuItem(
                                  //                 value: items,
                                  //                 child: Column(
                                  //                   crossAxisAlignment:
                                  //                   CrossAxisAlignment.start,
                                  //                   mainAxisAlignment:
                                  //                   MainAxisAlignment.center,
                                  //                   children: [
                                  //                     Padding(
                                  //                       padding: const EdgeInsets.only(
                                  //                           top: 2),
                                  //                       child: Container(
                                  //                           child: Padding(
                                  //                             padding:
                                  //                             const EdgeInsets.only(
                                  //                                 top: 0,left: 10),
                                  //                             child: Text(
                                  //                               items.title.toString(),
                                  //                               overflow:
                                  //                               TextOverflow.ellipsis,
                                  //                               style: const TextStyle(
                                  //                                   color: Colors.black54),
                                  //                             ),
                                  //                           )),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               );
                                  //             }).toList(),
                                  //           ),
                                  //         )),
                                  //   ),
                                  // ),
                                  const SizedBox(height: 15,),
                                  Text(getTranslated(context, "Booking Type"),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  Row(
                                    children: [
                                      Radio(
                                        value: 0,
                                        fillColor: MaterialStateColor.resolveWith(
                                                (states) => Secondry),
                                        activeColor: Secondry,
                                        groupValue: _value,
                                        onChanged: (int? value) {
                                          setState(() {

                                            _value = value??0;
                                            print('____Som_rrr_____${_value}_________');
                                            picUpController.text="";
                                            picTimeController.text="";
                                            isCurrent = false;
                                          });
                                        },
                                      ),
                                      Text(
                                        getTranslated(context, "Current Booking"),
                                        style: TextStyle(fontSize: 12),
                                      ),

                                      Radio(
                                          value: 1,
                                          fillColor: MaterialStateColor.resolveWith(
                                                  (states) => Secondry),
                                          activeColor: Secondry,
                                          groupValue: _value,
                                          onChanged: (int? value) {
                                            print("onTap");
                                            setState(() {
                                              _value = value??1;
                                              print('____Som_rrrr_____${_value}_________');
                                              isCurrent = true;
                                            });
                                          }),

                                      // SizedBox(width: 10.0,),
                                      Text(
                                        getTranslated(context, "Schedule Booking"),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),

                                  _value  == 1 ?
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(getTranslated(context, "Pickup Date and Time"),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                    onTap: () async {
                                                       DateTime? datePicked = await showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime.now().subtract(Duration(days: 0)),
                                                        lastDate: DateTime(2100),
                                                      );

                                                      if (datePicked != null) {
                                                        print('Date Selected: ${datePicked.day}-${datePicked.month}-${datePicked.year}');
                                                        String formattedDate = DateFormat('dd-MM-yyyy').format(datePicked);
                                                        setState(() {
                                                          selectedFromDate = formattedDate;
                                                        });
                                                      } else {
                                                        // Handle the case where the user canceled the date picker
                                                        print('No date selected');
                                                        // You can choose to set a default value or perform any other action.
                                                      }

                                                    },
                                                    child: Card(
                                                      elevation: 1,
                                                      child: Container(
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5),
                                                          color: Colors.white,
                                                        ),

                                                        child:  TextFormField(
                                                          readOnly: true,
                                                          onTap:
                                                              () async {
                                                                _selectDateStart();
                                                              },
                                                          controller: picUpController,
                                                          decoration:  InputDecoration(
                                                              border:InputBorder.none,
                                                              contentPadding: EdgeInsets.only(top: 13,left: 10),
                                                              suffixIcon: Icon(Icons.calendar_month,color:Secondry),
                                                              hintText: 'Date',hintStyle: TextStyle(fontSize: 15)
                                                            // border: OutlineInputBorder(
                                                            //     borderRadius: BorderRadius.circular(10)),
                                                          ),
                                                          validator: (value){
                                                            if(value==null||value.isEmpty)
                                                              return "Please enter date";
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                ),),
                                              Expanded(
                                                child: Card(
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                                                  child:
                                                  Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: TextFormField(

                                                      readOnly: true,
                                                      onTap: () async {
                                                        TimeOfDay? pickedTime = await showTimePicker(
                                                          initialTime: TimeOfDay.now(),
                                                          context: context,
                                                        );

                                                        if (pickedTime != null) {
                                                          DateTime parsedTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day,
                                                              pickedTime.hour, pickedTime.minute);

                                                          print(parsedTime); // Output: 2023-12-28 14:59:00.000

                                                          String formattedTime = DateFormat('hh:mm a').format(parsedTime);
                                                          print(formattedTime); // Output: 02:59 PM

                                                          picTimeController.text = formattedTime;
                                                        } else {
                                                          print("Time is not selected");
                                                        }
                                                      },
                                                      controller: picTimeController,
                                                      keyboardType: TextInputType.number,
                                                      maxLength: 10,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.digitsOnly
                                                      ],
                                                      decoration: InputDecoration(
                                                        suffixIcon: Icon(Icons.timer,color: Secondry,),
                                                        border: InputBorder.none,
                                                        fillColor: whiteColor,
                                                        filled: true,
                                                        hintText: "Time",
                                                        counterText: '',
                                                        labelStyle: TextStyle(color: Colors.black87),
                                                        // prefixIcon: IconButton(
                                                        //   onPressed: null,
                                                        //   icon: Icon(
                                                        //     Icons.call,
                                                        //     color: MyColorName.primaryDark,
                                                        //   ),
                                                        // ),
                                                        // enabledBorder: UnderlineInputBorder(
                                                        //   borderSide:  BorderSide(
                                                        //     color: colors.primary,
                                                        //   ),
                                                        //   borderRadius: BorderRadius.circular(8.0),
                                                        // ),
                                                        // focusedBorder: UnderlineInputBorder(
                                                        //   borderSide:  BorderSide(
                                                        //     color: colors.secondary,
                                                        //   ),
                                                        //   borderRadius: BorderRadius.circular(8.0),
                                                        // ),
                                                      ),
                                                    ),
                                                  ),

                                                ),
                                              ),
                                            ],
                                          )

                                    ],),
                                  ):SizedBox(),
                                  // isCurrent == false ? Padding(
                                  //   padding: const EdgeInsets.only(left: 0,right: 20),
                                  //   child: Row(
                                  //     children: [
                                  //       Expanded(
                                  //         child: Card(
                                  //             child: Container(
                                  //               height: 50,
                                  //                 child: Center(child: Text(formattedDateTime.substring(0,11)))),
                                  //
                                  //         ),
                                  //       ),
                                  //       Expanded(
                                  //         child: Card(
                                  //             child: Container(
                                  //                 height: 50,
                                  //                 child: Center(child: Text(formattedDateTime.substring(11,16))))
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ) :SizedBox(),
                                  SizedBox(height: 20,),
                                  InkWell(
                                      onTap: () {
                                        setState(() {

                                        });
                                        if(recipientNameController.text == ""){
                                          Fluttertoast.showToast(msg: "Please select receiver name");
                                          return;
                                        }if(recipientMobileController.text == ""|| recipientMobileController.text.length <10){
                                          Fluttertoast.showToast(msg: "Please select receiver mobile");
                                          return;
                                        }if(selectedValue  == null){
                                          Fluttertoast.showToast(msg: "Please select material category");
                                          return;
                                        }else{
                                          senParcel();
                                        }
                                        // if(receiverList.isEmpty) {
                                        //   if (_formKey.currentState!.validate()) {
                                        //    senParcel();
                                        //     // Get.to(ParceldetailsScreen());
                                        //   }
                                        // }else {
                                        //
                                        // senParcel();
                                        // }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.1,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: primaryColor
                                        ),
                                        child: isLoading == true
                                            ? const Center(
                                          child:
                                          CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                            :
                                        Text(getTranslated(context, "Confirm"), style: TextStyle(
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,),),
                                      )),
                                  SizedBox(height: 20,),
                                ],),
                            ),
                          ),

                          ///parceldetails
                          SizedBox(height: 20,),

                        //   Center(
                        //       child: Column(
                        //         children: [
                        //           const SizedBox(height: 20,),
                        //
                        //           const SizedBox(height: 20,),
                        //           // Material(
                        //           //   color: splashcolor,
                        //           //   elevation: 1,
                        //           //   borderRadius: BorderRadius.circular(10),
                        //           //   child: SizedBox(
                        //           //     height: 55,
                        //           //     width: MediaQuery
                        //           //         .of(context)
                        //           //         .size
                        //           //         .width / 1.2,
                        //           //     child: DropdownButton(
                        //           //       isExpanded: true,
                        //           //       hint: const Padding(
                        //           //         padding: EdgeInsets.all(5.0),
                        //           //         child: Text("Parcel weight"),
                        //           //       ),
                        //           //       underline: Container(),
                        //           //       value: selectedValue1,
                        //           //       icon: const Padding(
                        //           //         padding: EdgeInsets.only(left: 140),
                        //           //         child: Icon(Icons.keyboard_arrow_down,
                        //           //             color: Color(0xFFBF2331)),
                        //           //       ),
                        //           //       items: parcelWeightModel?.data?.map((items) {
                        //           //         return DropdownMenuItem(
                        //           //           value: items.weightTo,
                        //           //           child: Text(items.weightTo.toString()),
                        //           //         );
                        //           //       }).toList(),
                        //           //       onChanged: (newValue) {
                        //           //         setState(() {
                        //           //           print("new value ${newValue}");
                        //           //           selectedValue1 = newValue!;
                        //           //         });
                        //           //       },
                        //           //     ),
                        //           //   ),
                        //           // ),
                        // //           const SizedBox(height: 15,),
                        // //           Material(
                        // //             color: splashcolor,
                        // //             elevation: 1,
                        // //             borderRadius: BorderRadius.circular(10),
                        // //             child: SizedBox(
                        // //               width: MediaQuery
                        // //                   .of(context)
                        // //                   .size
                        // //                   .width / 1.2,
                        // //               height: 60,
                        // //               child: TextFormField(
                        // //                 validator: (value) {
                        // //                   if (value == null || value.isEmpty) {
                        // //                     return 'Enter Parcel value ';
                        // //                   }
                        // //                   return null;
                        // //                 },
                        // //                 controller: valueController,
                        // //                 decoration: InputDecoration(
                        // //                   border: const OutlineInputBorder(
                        // //                       borderSide: BorderSide.none
                        // //                   ),
                        // //                   hintText: "Parcel value",
                        // //                   prefixIcon: IconButton(
                        // //                       onPressed: null,
                        // //                       icon: Image.asset('assets/AuthAssets/rupeesIcon.png', color: primaryColor, height: 20,width: 20,)),
                        // //                 ),
                        // //               ),
                        // //             ),
                        // //           ),
                        // //           Container(
                        // //               padding: const EdgeInsets.symmetric(horizontal: 30),
                        // //               width: MediaQuery.of(context).size.width,
                        // //               child:  Text('We will compensate the value of lost item '
                        // //                   'within three working days according to rules. '
                        // //                   'maximum compensation -${amt}', style: const TextStyle(fontSize: 12, color: Colors.grey,),)),
                        // //           const SizedBox(height: 50,),
                        // //           InkWell(
                        // //             onTap: () {
                        // //               /* "receiver_name": "${recipientNameController
                        // //       .text}",
                        // //   "receiver_phone": "${recipientMobileController
                        // //       .text}",
                        // //   "receiver_address": "${recipientAddressCtr}",
                        // //   "receiver_latitude": "${lat2}",
                        // //   "receiver_longitude": "${long2}",
                        // //   "reciver_full_address": "${receiverfulladdressCtr
                        // //       .text}",
                        // //   "meterial_category": "${selectedValue
                        // //       .toString()}",
                        // //   "parcel_weight": "up to ${selectedValue1
                        // //       .toString()} kg",
                        // // }*/
                        // //
                        // //               if (_formKey.currentState!.validate()) {
                        // //                 setState(() {
                        // //                   receiverList.add({
                        // //                     "meterial_category":
                        // //                     "${selectedValue.toString()}",
                        // //                     "parcel_weight": "${selectedValue1.toString()}",
                        // //                     "receiver_address": "${recipientAddressCtr.text}",
                        // //                     "receiver_latitude": "${lat2}",
                        // //                     "receiver_longitude": "${long2}",
                        // //                     "receiver_name":
                        // //                     "${recipientNameController.text}",
                        // //                     "receiver_phone":
                        // //                     "${recipientMobileController.text}",
                        // //                     "reciver_full_address":
                        // //                     "${receiverfulladdressCtr.text}",
                        // //                     "pacel_value" : "${valueController.text}"
                        // //                   });
                        // //                 });
                        // //                 print("Checking Parcel ${selectedValue1.toString()}");
                        // //                 print(
                        // //                     "checking hereeeee ${receiverList.length} and ${receiverList}");
                        // //
                        // //                 recipientNameController.clear();
                        // //                 recipientnewAddressCtr.clear();
                        // //                 recipientAddressCtr.clear();
                        // //                 recipientMobileController.clear();
                        // //                 receiverfulladdressCtr.clear();
                        // //                 valueController.clear();
                        // //
                        // //               }
                        // //               // Navigator.pop(context);
                        // //               // setState(() {});
                        // //               //
                        // //               // int materialValue = 0;
                        // //               // int parcelValue = 0;
                        // //               // int recnameValue = 0;
                        // //               // int recaddValue = 0;
                        // //               // int recmobValue = 0;
                        // //               // int recfulladdValue = 0;
                        // //               //
                        // //               // setState(() {
                        // //               // });
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   materialValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Material Valueee ${materialValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   parcelValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${parcelValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   recnameValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${recnameValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   recaddValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${recaddValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   recfulladdValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${recfulladdValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //               // setState(() {});
                        // //               //
                        // //               // for(var i=0; i<receiverList.length; i++){
                        // //               //   recmobValue = int.parse(receiverList[i][''].toString());
                        // //               //   print("Parcel Details Value ${recmobValue}");
                        // //               //   setState(() {});
                        // //               // }
                        // //
                        // //               //  Get.to(MyStatefulWidget());
                        // //             },
                        // //             child: Container(
                        // //               height: 45,
                        // //               width: MediaQuery
                        // //                   .of(context)
                        // //                   .size
                        // //                   .width / 1.2,
                        // //               alignment: Alignment.center,
                        // //               decoration: BoxDecoration(
                        // //                   borderRadius: BorderRadius.circular(30),
                        // //                   color: Secondry
                        // //               ),
                        // //               child: const Text("Add More", style: TextStyle(
                        // //                 color: Colors.black,
                        // //                 fontWeight: FontWeight.bold,
                        // //                 fontSize: 14,),),
                        // //             ),
                        // //           ),
                        // //           const SizedBox(height: 20,),
                        //
                        //         ],
                        //       )),
                        //   // Center(
                        //   //   child: DropdownSearch<String>(
                        //   //     popupProps: PopupProps.menu(
                        //   //       showSelectedItems: true,
                        //   //       showSearchBox: true,
                        //   //       disabledItemFn: (String s) => s.startsWith('I'),
                        //   //     ),
                        //   //
                        //   //     items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada,'],
                        //   //     dropdownDecoratorProps: DropDownDecoratorProps(
                        //   //       dropdownSearchDecoration: InputDecoration(
                        //   //         labelText: "Menu mode",
                        //   //         hintText: "country in menu mode",
                        //   //       ),
                        //   //     ),
                        //   //     onChanged: print,
                        //   //     selectedItem: "Brazil",
                        //   //   ),
                        //   // ),
                        //   //
                        //   // DropdownSearch<String>.multiSelection(
                        //   //   items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
                        //   //   popupProps: PopupPropsMultiSelection.menu(
                        //   //     showSelectedItems: true,
                        //   //     disabledItemFn: (String s) => s.startsWith('I'),
                        //   //   ),
                        //   //   onChanged: print,
                        //   //   selectedItems: ["Brazil"],
                        //   // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),


    );
  }


  // Widget recipietCart(int index) {
  //   return
  //     Center(
  //     child: Card(
  //       elevation: 0,
  //       color: Theme.of(context).colorScheme.surfaceVariant,
  //       child: SizedBox(
  //         width: MediaQuery.of(context).size.width/ 1.2,
  //         height: 80,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //           Text("Recipient Name"),
  //           Icon(Icons.delete),
  //           Icon(Icons.edit),
  //         ],),
  //       ),
  //     ),
  //   );
  // }

 /* _getLocation1() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(
              "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
            )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result
            .locality.toString()} and ${result.country!.shortName
            .toString()} ");
    setState(() {
      senderAddressCtr.text = result.formattedAddress.toString();
      cityC.text = result.locality.toString();
      stateC.text = result.administrativeAreaLevel1!.name.toString();
      countryC.text = result.country!.name.toString();
      lat1 = result.latLng!.latitude;
      long1 = result.latLng!.longitude;
      pincodeC.text = result.postalCode.toString();
    });
  }*/

 /* _getLocation2() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker(
              "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
            )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result
            .locality.toString()} and ${result.country!.shortName
            .toString()} ");
    setState(() {
      recipientAddressCtr.text = result.formattedAddress.toString();
      cityC.text = result.locality.toString();
      stateC.text = result.administrativeAreaLevel1!.name.toString();
      countryC.text = result.country!.name.toString();
      lat2 = result.latLng!.latitude;
      long2 = result.latLng!.longitude;
      pincodeC.text = result.postalCode.toString();
    });
  }*/

   BookingSingleDataModel? bookingSingleDataModel;
   getSingleDataApi() async {
     var headers = {
       'Cookie': 'ci_session=e6e2df57a453a8be89896a5d15773749306e4f25'
     };
     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/reorder_data'));
     request.fields.addAll({
       'order_id':widget.orderId.toString()
     });
   print('____Som__fff____${request.fields}_________');
     request.headers.addAll(headers);

     http.StreamedResponse response = await request.send();

     if (response.statusCode == 200) {
       var result  = await response.stream.bytesToString();
       var finalResult =  BookingSingleDataModel.fromJson(json.decode(result));
       setState(() {
       bookingSingleDataModel =   finalResult;
       recipientNameController.text = "${bookingSingleDataModel?.data?.receiverName.toString()}";
       recipientMobileController.text = "${bookingSingleDataModel?.data?.receiverName.toString()}";
       homeController.text = "${bookingSingleDataModel?.data?.reciverFullAddress.toString()}";
       homeController.text = "${bookingSingleDataModel?.data?.reciverFullAddress.toString()}";
       widget.dropLocation = "${bookingSingleDataModel?.data?.receiverAddress.toString()}";
       picTimeController.text = "${bookingSingleDataModel?.data?.bookingTime.toString()}";
       picUpController.text = "${bookingSingleDataModel?.data?.bookingDate.toString()}";
      // _value =int.parse( "${bookingSingleDataModel?.data?.bookingType.toString()}");

       catIdString = materialCategoryModel?.data?.firstWhere((item) {
         if(item.id == bookingSingleDataModel?.data?.meterialCategory){


           return true;
         }
         else{
           return false;
         }
       });
       });
     }
     else {
     print(response.reasonPhrase);
     }

   }
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

}


class Recipient {
  String? receiver_name;
  String? receiver_phone;
  String? receiver_address;
  String? receiver_longitude;
  String? receiver_latitude;
  String? reciver_full_address;
  String? meterial_category;
  String? parcel_weight;

  Recipient(
      {this.meterial_category, this.parcel_weight, this.receiver_phone, this.receiver_name, this.receiver_address, this.receiver_latitude, this.receiver_longitude, this.reciver_full_address});


}