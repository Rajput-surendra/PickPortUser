import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_dekho_app/Helper/session.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/select_Vehicle.dart';
import 'package:job_dekho_app/Jdx_screens/parceldetailsscreen.dart';
import 'package:job_dekho_app/Services/api.dart';
import 'package:job_dekho_app/Utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart'as http;

import '../../Model/ParcelHistoryModel.dart';
import '../../Model/Trip_Details_Model.dart';
import '../../Model/myPlanModel.dart';
import '../../Utils/api_path.dart';
import '../Dashbord.dart';


class TripDetails extends StatefulWidget {
   TripDetails({Key? key,this.oId}) : super(key: key);
  String? oId;

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {


  TripDetailsModel? tripDetailsModel;
  getDetailsApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString("userid");
    var headers = {
      'Cookie': 'ci_session=4c6d3fcced35c5677cfd284bc1c87bf4d0d91851'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}payment/parcel_details'));
    request.fields.addAll({
      'user_id':userid.toString(),
      'order_id':widget.oId.toString()
    });
  print('____Som___ggggg___${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result = await response.stream.bytesToString();
       var finalResult  =  TripDetailsModel.fromJson(json.decode(result));
       setState(() {
         tripDetailsModel =  finalResult;
       });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body:   Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration:  BoxDecoration(
                        color: splashcolor,
                        borderRadius:
                        BorderRadius.circular(100)),
                    child: InkWell(
                        onTap: () {
                         Navigator.pop(context);
                        },
                        child: Center(
                          child: Icon(Icons.arrow_back,color: primaryColor,)
                        )),
                  ),
                  Text(getTranslated(context, "Trip Details"),style: TextStyle(color: whiteColor,fontSize: 18),),
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
              tripDetailsModel == null ? Center(child: CircularProgressIndicator()):  Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("${tripDetailsModel!.data!.first.newDate}",style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.normal)),
                            tripDetailsModel!.data!.first.status == "4" ?
                            Text("Completed",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),

                            ):
                            tripDetailsModel!.data!.first.status == "0" ||  tripDetailsModel!.data!.first.status== "6"  ?
                            Text("Pending",style: TextStyle(color:Colors.yellow,fontWeight: FontWeight.bold),
                            ):
                            tripDetailsModel!.data!.first.status == "2" ?
                            Text("Accepted ",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),

                            ):

                            Text("Cancelled",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),

                            ),
                           // tripDetailsModel!.data!.first.status ==  "4" ? Text("Completed",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),) : tripDetailsModel!.data!.first.status ==  "2" ? Text("Pending",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold)) :Text("Cancelled",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            tripDetailsModel!.data!.first.uniqueId == null ?const Text("No Id Found!!"):   Text("Vehicle No: ${tripDetailsModel!.data!.first.uniqueId }",style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold)),

                            Text("₹ ${tripDetailsModel!.data!.first.totalAmount}",style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "lora"
                            ),),
                          ],
                        ),
                      ),

                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    elevation: 3,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                      height: 70,
                                      width: 70,
                                        child: Image.network("${tripDetailsModel!.data!.first.driverDetails?.cabImg}",scale: 1.3,fit: BoxFit.fill,)),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text("${tripDetailsModel!.data!.first.driverDetails!.cabName}"),

                                      Text("Vicicle Name"),

                                      Text("${tripDetailsModel!.data!.first.deliveryTimeFrom}"),
                                    ],
                                  )
                                ],
                              ),


                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,width: 30,
                                    child: Image.asset(
                                      'assets/revice.png',scale: 1.1,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(getTranslated(context, "Pickup Location"),style: TextStyle(
                                          fontSize: 15, color: primaryColor
                                      ),),
                                      Row(
                                        children: [
                                       Text("${tripDetailsModel!.data!.first.senderName}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                          Text(","),
                                          Text("${tripDetailsModel!.data!.first.phoneNo}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                        ],
                                      ),
                                      Container(
                                          width: 250,
                                          child: Text("${tripDetailsModel!.data!.first.senderFulladdress}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                    ],
                                  )

                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Dash(
                                    direction: Axis.vertical,
                                    length: 50,
                                    dashLength: 2,
                                    dashColor: primaryColor),
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 30,width: 30,
                                    child: Image.asset(
                                      'assets/send.png',scale: 1.1,
                                    ),
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(getTranslated(context, "Drop Location"),style: TextStyle(
                                          fontSize: 15, color: primaryColor
                                      ),),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Row(
                                          children: [
                                            Text("${tripDetailsModel!.data!.first.receiverName}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                            Text(","),
                                          Text("${tripDetailsModel!.data!.first.receiverPhone}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          width: 220,
                                          child: Text("${tripDetailsModel!.data!.first.receiverAddress}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),

                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text("Delivery Boys Details",style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                                tripDetailsModel!.data!.first.driverName == null ? Center(child: Text("No Delivery Boys")) :Row(
                                  children: [

                                    tripDetailsModel!.data!.first.driverDetails!.userImage == null? CircleAvatar():  Container(
                                      height: 60,
                                        width: 60,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                            child: Image.network("${tripDetailsModel!.data!.first.driverDetails!.userImage}",fit: BoxFit.fill,))),
                                    SizedBox(width: 5,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        tripDetailsModel!.data!.first.driverName == null ? Text("No Assign "):  Text("${tripDetailsModel!.data!.first.driverName}"),
                                        tripDetailsModel!.data!.first.driverPhone == null ? Text("No Assign "):   Text("${tripDetailsModel!.data!.first.driverPhone}"),
                                      ],
                                    )

                                    //tripDetailsModel!.data!.first.driverDetails!.userImage == null? CircleAvatar():  Image.network("${ApiPath.imgUrl}${tripDetailsModel!.data!.first.driverDetails!.userImage},
                                    // Column(
                                    //   children: [
                                    //     Text("${tripDetailsModel!.data!.first.driverDetails!.userFullname}"),
                                    //     Text("${tripDetailsModel!.data!.first.driverDetails!.userPhone}"),
                                    //  ]
                                    // )
                                  ]


                                )


                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Material Category",style: TextStyle(color: backColor,fontWeight: FontWeight.bold),),
                                    Text("${tripDetailsModel!.data!.first.materialInfo!.materialCatName}",),
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Parcel Weight",style: TextStyle(color: backColor,fontWeight: FontWeight.bold),),
                                    Text("${tripDetailsModel!.data!.first.materialInfo!.parcelWeight} kg",),
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Distance",style: TextStyle(color: backColor,fontWeight: FontWeight.bold),),
                                    Text("${tripDetailsModel!.data!.first.distance} km",),
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Text("Fare Details",style: TextStyle(color: backColor,fontWeight: FontWeight.bold,fontSize: 18),),
                                SizedBox(height: 3,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("Cancellation Charges",style: TextStyle(color: backColor,fontWeight: FontWeight.bold),),
                                //     Text("₹ ${tripDetailsModel!.data!.first.distance}",style: TextStyle(
                                //       fontFamily: "lora"
                                //     ),),
                                //   ],
                                // ),
                                SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total",style: TextStyle(color: backColor,fontWeight: FontWeight.bold),),
                                    Text("₹ ${tripDetailsModel!.data!.first.totalAmount}",style: TextStyle(fontFamily: "lora",fontWeight: FontWeight.bold,),),
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                     Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          Fluttertoast.showToast(msg: "After Live");
                                        },
                                        child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: primaryColor)
                                            ),
                                            child: Center(child:
                                            Text("Mail Invoice",style: TextStyle(color: primaryColor),)
                                            )
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    tripDetailsModel!.data!.first.status == "4" ?  Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SelcetVhicle(orderId: tripDetailsModel!.data!.first.orderId ?? "",)));
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                              color: primaryColor
                                          ),
                                          child: Center(child: Text("Book Again",style: TextStyle(color: whiteColor),)),
                                        ),
                                      ),
                                    ):SizedBox.shrink()
                                  ],
                                )

                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
  double lat = 0.0;
  double long = 0.0;
  int selectedSegmentVal = 0;
  void initState() {
    // TODO: implement initState
    super.initState();

    getDetailsApi();

  }
  // String radioButtonItem = 'ONE';
  int id = 0;

  List<String> myIds = [];

  bool isLoading = false ;

  String? planStatus;

  MyPlanModel? myPlanModel;
  var myPlanId;

  bool ResponseCode = false;

  ParcelhistoryModel? parcelhistory;
  String? userid;
  String orderStatus(String status ){
    print('__________${status}_____________');
    if(status == '0'){
      return 'Searching Driver';
    }else if(status == '1'){
      return 'Confirm';
    }else if(status == '2'){
      return 'Order Received';
    }else if(status == '3'){
      return 'Order Picked up';
    }else if(status == '4'){
      return 'Complete';
    }else if(status == '5'){
      return 'Order Delivered';
    }else if(status == '6'){
      return 'Order Complete';
    }else {

      return 'cancel';
    }

  }
  Widget _segmentButton() => Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(45),
      color: Colors.white,
    ),
    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 30,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 0
                        ? [primaryColor,Secondry]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(0),
              child: Text(
                getTranslated(context, "Active"),
                style:  TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14,
                    color: selectedSegmentVal == 0
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 30,
            decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: selectedSegmentVal == 1
                        ? [primaryColor, Secondry]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(1),
              child: FittedBox(
                child: Text(
                  getTranslated(context, "Complete"),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14,
                      color: selectedSegmentVal == 1
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
  setSegmentValue(int i) {
    selectedSegmentVal = i;
    String status;
    if (i == 0) {
      parcelHistory(1);
    } else if (i == 1) {
      parcelHistory(2);
    }
    setState(() {

    });
    // getOrderList(status: status);

  }
  parcelHistory(int? status) async {
    isLoading = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString("userid");
    var headers = {
      'Cookie': 'ci_session=c4d89ea1aafd386c2dd6a6d1913c38e59c817e3d'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ApiPath.baseUrl}payment/parcel_history'));
    request.fields.addAll({
      'user_id': userid.toString(),
    });
    print("111111111111111${request.fields}");
    print("${request}");

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("thi555555555555555=?>${response.statusCode}");
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
      ParcelhistoryModel.fromJson(json.decode(finalResult));
      //log("Response Here===========>${jsonResponse}");
      log("Final Result Here===========>${finalResult}");
      setState(() {
        parcelhistory = jsonResponse;
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  cancelOrder(String orderId, int i) async{
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/pickport/api/Authentication/update_parcel_status'));
    request.fields.addAll({
      'user_id': userid ?? '315',
      'order_id': orderId,
      'status': '7'
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order Cancel successfully')));

      parcelhistory?.data?.removeAt(i) ;
      setState(() {

      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
