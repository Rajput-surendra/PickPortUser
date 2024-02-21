import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:job_dekho_app/Jdx_screens/Dashbord.dart';
import 'package:job_dekho_app/Jdx_screens/Editrecipentcart.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Jdx_screens/parceldetailsscreen.dart';
//import 'package:place_picker/entities/location_result.dart';
//import 'package:place_picker/widgets/place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/session.dart';
import '../../Model/MaterialCategoryModel.dart';
import '../../Model/ParcelWeightModel.dart';
import '../../Model/registerparcelmodel.dart';
import '../../Utils/api_path.dart';
import '../../Utils/color.dart';
import '../HomeScreen.dart';
import 'RegisterParcelDetails.dart';
import '../notification_Screen.dart';

class RegistParcelScreen extends StatefulWidget {
  const RegistParcelScreen({Key? key}) : super(key: key);

  @override
  State<RegistParcelScreen> createState() => _RegistParcelScreenState();
}

class _RegistParcelScreenState extends State<RegistParcelScreen> {
  // TextEditingController senderNameController = TextEditingController();
  // TextEditingController senderMobileController = TextEditingController();
   TextEditingController recipientAddressCtr = TextEditingController();
  // TextEditingController recipientnewAddressCtr = TextEditingController();
    TextEditingController senderAddressCtr = TextEditingController();
  // TextEditingController nameC = TextEditingController();
  // TextEditingController senderfulladdressCtr = TextEditingController();
  // TextEditingController recipientMobileController = TextEditingController();
  // TextEditingController pincodeC = TextEditingController();
  // TextEditingController cityC = TextEditingController();
  // TextEditingController valueController = TextEditingController();
  //
  // // TextEditingController addressC = TextEditingController();
  // TextEditingController receiverfulladdressCtr = TextEditingController();
  // TextEditingController recipientNameController = TextEditingController();
  // TextEditingController stateC = TextEditingController();
  // TextEditingController countryC = TextEditingController();
  // TextEditingController latitudeC = TextEditingController();
  // TextEditingController longitudeC = TextEditingController();

  // double lat1 = 0.0;
  // double long1 = 0.0;
  // double lat2 = 0.0;
  // double long2 = 0.0;

  // String radioButtonItem = 'ONE';
  int id = 0;

  Registerparcelmodel? parcelDetailsModel;

 List receiverList = [];

  // List<String>  selectedvalue = [];

  // senParcel() async {
  //  if(receiverList.isEmpty){
  //    receiverList.add(
  //        {"meterial_category": "${selectedValue.toString()}",
  //          "parcel_weight": "${selectedValue1.toString()}",
  //          "receiver_address": "${recipientAddressCtr.text}",
  //          "receiver_latitude": "${lat2}",
  //          "receiver_longitude": "${long2}",
  //          "receiver_name": "${recipientNameController.text}",
  //          "receiver_phone": "${recipientMobileController.text}",
  //          "reciver_full_address": "${receiverfulladdressCtr.text}",
  //          "pacel_value" : "${valueController.text}"
  //        });
  //  }
  //
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? userid = prefs.getString('userid');
  //   String? orderid = prefs.getString("orderid");
  //
  //   print("User Id ${userid.toString()}");
  //   // print("this is my order id>>>>>>>>>>>>>>${orderid}");
  //   print("Register and Sender Parcel");
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Cookie': 'ci_session=1b21f643064e1ac4622693b37863ecfa449561dd',
  //   };
  //   var request = http.Request(
  //       'POST', Uri.parse('${ApiPath.baseUrl}payment/send_parcel'));
  //   request.body = json.encode({
  //     "sender_name": senderNameController.text,
  //     "sender_address": senderAddressCtr.text,
  //     "sender_phone": senderMobileController.text,
  //     "sender_latitude": lat1.toString(),
  //     "sender_longitude": long1.toString(),
  //     "sender_fulladdress": senderfulladdressCtr.text,
  //     "user_id": "${userid}",
  //     "data_arr": receiverList,
  //   });
  //   print("This is request here>>>>>>>>${request.body}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print("Working Now Here");
  //     var finalResult = await response.stream.bytesToString();
  //     final jsonResponse = Registerparcelmodel.fromJson(json.decode(finalResult));
  //     String orderid = jsonResponse.orderId.toString();
  //     prefs.setString('orderid', orderid.toString());
  //     print("thiss is order id=========>${orderid}");
  //     // String? orderid = preferences.getString("orderid");
  //     print("Result here Now@@@@@@ ${finalResult.toString()}");
  //     // print("Result Noww@@@@@@ ${finalResult}");
  //     setState(() {
  //       parcelDetailsModel = jsonResponse;
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => ParceldetailsScreen(orderid: orderid, isFromParcelHistory: false,)));
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
    senderAddressCtr.text  =  addressC.text;

    _getCompensationAmmount();

  }

  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  String? selectedValue1;
  String? amt;
  double? latSender;
  double? longSender;
  double? latReceiver;
  double? longReceiver;

  @override
  Widget build(BuildContext context) {
    // Data data = materialCategoryModel!.data![0].title;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   backgroundColor: primaryColor,
      //   /*leading: GestureDetector(
      //     onTap: () {
      //       Get.to(MyStatefulWidget());
      //     },
      //     child: Icon(Icons.arrow_back, color: whiteColor, size: 20),
      //     //Icon(Icons.arrow_back_ios, color: whiteColor, size: 22),
      //   ),*/
      //   title: Text('Register Parcel', style: TextStyle(color: whiteColor,
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //       fontFamily: 'Lora'),),
      //   // actions: [
      //   //   Padding(
      //   //     padding: EdgeInsets.only(right: 10),
      //   //     child: InkWell(
      //   //         onTap: () {
      //   //           Navigator.push(context, MaterialPageRoute(
      //   //               builder: (context) => NotificationScreen()));
      //   //         },
      //   //         child: Icon(Icons.notifications, color: Colors.white,)),
      //   //   ),
      //   // ],
      // ),
      bottomSheet:  Padding(
        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20),
        child: InkWell(

          onTap: (){
            if(senderAddressCtr.text == ""){
              Fluttertoast.showToast(msg: "Select Please PickUp Location");
              return;
            }if(recipientAddressCtr.text == ""){
              Fluttertoast.showToast(msg: "Select Please Drop Location");
            }else{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterParcelDetails(dropLocation: recipientAddressCtr.text,picLocation: senderAddressCtr.text,lat1: latSender,long1: longSender,lat2: latReceiver,long2: longReceiver,)));
            }

          },
          child: Container(
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15)),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child:  Center(
                child: Text(
                  getTranslated(context, "Next"),
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
      ),
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
                 Text("Location",style: TextStyle(color: whiteColor,fontSize: 18),),
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
                       // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///senderdetails
                          Center(
                            child: Column(
                              children: [
                                // _addressField(context),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 30,width: 30,
                                        child: Image.asset(
                                          'assets/ProfileAssets/pickup location.png',scale: 1.3,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(getTranslated(context, "Pickup Location"))
                                    ],
                                  ),
                                ),
                                Material(
                                  color: whiteColor,
                                  elevation: 1,
                                  borderRadius: BorderRadius.circular(10),
                                  child: SizedBox(

                                  width: MediaQuery.of(context).size.width / 1.2,
                                    child: TextFormField(

                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please Enter Sender Address';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                      controller: senderAddressCtr,
                                      maxLines: 2,
                                      onTap: () {
                                        //_getLocation1();

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PlacePicker(
                                              hintText:getTranslated(context, "Pickup Location"),
                                              apiKey: Platform.isAndroid
                                                  ? "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY"
                                                  : "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY",
                                              onPlacePicked: (result) {
                                                print(result.formattedAddress);
                                                setState(() {
                                                  senderAddressCtr.text =
                                                      result.formattedAddress.toString();
                                                  latSender = result.geometry!.location.lat;
                                                  longSender = result.geometry!.location.lng;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              initialPosition: LatLng(22.719568,75.857727),
                                              useCurrentLocation: true,
                                            ),
                                          ),
                                        );
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none
                                        ),
                                        //hintText: "Sender Address",

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 30,width: 30,
                                        child: Image.asset(
                                          'assets/ProfileAssets/drop location.png',scale: 1.3,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Text(getTranslated(context, "Drop Location"))
                                    ],
                                  ),
                                ),
                                Material(
                                  color: whiteColor,
                                  elevation: 1,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.2,
                                    // height: 60,
                                    child: TextFormField(

                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Recipient Address';
                                        }
                                        return null;
                                      },
                                      readOnly: true,
                                      controller: recipientAddressCtr,
                                        maxLines: 2,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PlacePicker(
                                              hintText: "Drop Location",
                                              apiKey: Platform.isAndroid
                                                  ? "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY"
                                                  : "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY",
                                              onPlacePicked: (result) {
                                                print(result.formattedAddress);
                                                setState(() {
                                                  recipientAddressCtr.text =
                                                      result.formattedAddress.toString();
                                                  latReceiver = result.geometry!.location.lat;
                                                  longReceiver = result.geometry!.location.lng;
                                                });
                                                Navigator.of(context).pop();
                                              },
                                              initialPosition: const LatLng(
                                                  22.719568,75.857727),
                                              useCurrentLocation: true,
                                            ),
                                          ),
                                        );

                                        //_getLocation2();
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration:  InputDecoration(
                                        hintText: getTranslated(context, "Search Your Drop Location"),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                              ],),
                          ),
                          ///recipentdetails


                          ///parceldetails

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