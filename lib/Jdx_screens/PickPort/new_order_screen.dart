import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_dekho_app/Helper/session.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/select_Vehicle.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/trip_details_screen.dart';
import 'package:job_dekho_app/Jdx_screens/parceldetailsscreen.dart';
import 'package:job_dekho_app/Utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart'as http;

import '../../Model/ParcelHistoryModel.dart';
import '../../Model/myPlanModel.dart';
import '../../Utils/api_path.dart';
import '../Dashbord.dart';
import 'RegisterParcelDetails.dart';


class NewOrderHistroy extends StatefulWidget {
  const NewOrderHistroy({Key? key}) : super(key: key);

  @override
  State<NewOrderHistroy> createState() => _NewOrderHistroyState();
}

class _NewOrderHistroyState extends State<NewOrderHistroy> {
  TextEditingController messegeC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTranslated(context, "Orders"),style: TextStyle(color: whiteColor),),
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
            flex: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: backGround,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50))
              ),
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:parcelhistory == null ?
                Center(child: CircularProgressIndicator())
                    :
                parcelhistory!.data!.isEmpty ?
                Center(child: Text(" No Parcel History"))
                    :
                ListView.builder(
                  // reverse: true,
                  itemCount:parcelhistory?.data?.length ,
                    itemBuilder: (context,index){
                   // print(parcelhistory?.data?[parcelhistory?.data?.length??0-1-0].senderName);
                   //   var cabImage = parcelhistory!.data![index].parcelDetails!.materialInfo!.cabImage == "" ?
                   //   "https:\/\/developmentalphawizz.com\/pickport\/\/uploads\/cap\/image121.png"
                   //       :parcelhistory!.data![index].parcelDetails!.materialInfo!.cabImage.toString();
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TripDetails(oId:parcelhistory!.data![index].orderId,)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                          ListTile(
                            leading: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)
                              ),
                              elevation: 3,
                                child: Image.network("${parcelhistory!.data![index].parcelDetails!.materialInfo!.cabImage}",scale: 1.5,)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${parcelhistory!.data![index].parcelDetails!.materialInfo!.cabName}",style: TextStyle(color: backColor,fontWeight: FontWeight.bold),),
                                Text("₹ ${parcelhistory!.data![index].parcelDetails!.materialInfo!.price}",style: TextStyle(color: backColor,fontWeight: FontWeight.bold,fontFamily: "lora"),),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text("${parcelhistory!.data![index].deliveryTimeFrom}"),
                                parcelhistory!.data![index].parcelDetails!.status == "4" ?
                                      Text("Completed",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                                ):
                                parcelhistory!.data![index].parcelDetails!.status == "0" ||  parcelhistory!.data![index].parcelDetails!.status == "6"  ?
                                      Text("Pending",style: TextStyle(color:Colors.yellow,fontWeight: FontWeight.bold),

                                ): parcelhistory!.data![index].parcelDetails!.status == "2" ?
                                Text("Accepted ",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                                ):
                                      Text("Cancelled",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),

                                ),
                                SizedBox(width: 5,),

                              ],
                            )

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
                                                Text("${parcelhistory!.data![index].parcelDetails!.senderName}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                Text(","),
                                                Text("${parcelhistory!.data![index].phoneNo}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                              ],
                                            ),
                                            Container(
                                                width: 250,
                                                child: Text("${parcelhistory!.data![index].parcelDetails!.senderFulladdress}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
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
                                                  Text("${parcelhistory!.data![index].parcelDetails!.receiverName}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                Text(","),
                                                  Text("${parcelhistory!.data![index].parcelDetails!.receiverPhone}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: 260,
                                                child: Text("${parcelhistory!.data![index].parcelDetails!.receiverAddress}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        parcelhistory!.data![index].parcelDetails!.status == "2" ?
                                        Expanded(
                                          child: InkWell(
                                            onTap: (){
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    height: 150,
                                                    width: 150,
                                                    child: AlertDialog(

                                                      title: Text("Cancel Trip"),
                                                      content:
                                                        Container(
                                                          height: 50,
                                                          child: TextFormField(
                                                            controller: messegeC,
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder()
                                                            ),
                                                          ),
                                                        ),
                                                      actions: <Widget>[
                                                      Text("Are you sure you want to Cancel trip the booking?"),
                                                       Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           TextButton(
                                                             onPressed: () {
                                                               Navigator.of(context).pop(false); // Cancel exit
                                                             },
                                                             child: Text(getTranslated(context, "NO")),
                                                           ),
                                                           TextButton(
                                                             onPressed: () {
                                                               cancalBookingApi(parcelhistory!.data![index].parcelDetails!.orderId ?? "");
                                                             },
                                                             child: Text(getTranslated(context, "Yes")),
                                                           ),
                                                         ],
                                                       )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                                  color: Colors.red
                                              ),
                                              child: Center(child: Text("Cancel",style: TextStyle(color: whiteColor),)),
                                            ),
                                          ),
                                        ): SizedBox.shrink(),
                                        SizedBox(width: 5,),
                                        Expanded(
                                          child: InkWell(
                                            onTap: (){
                                              String? Name = parcelhistory!.data![index].parcelDetails!.orderId ?? "";
                                              print('____Som______${Name}_________');
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SelcetVhicle(orderId: parcelhistory!.data![index].orderId ?? "",)));
                                            },
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                                  color: primaryColor
                                              ),
                                              child: Center(child: Text("Book Again",style: TextStyle(color: whiteColor),)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ),
            ),
          )

        ],
      ),
    );
  }

  cancalBookingApi(String orderId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userid = preferences.getString("userid");
    var headers = {
      'Cookie': 'ci_session=5be087b0c4c1b35780570cfe960ca9b361d974b0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Payment/cancel_order'));
    request.fields.addAll({
      'user_id': userid.toString(),
      'order_id':orderId.toString(),
      'message':messegeC.text
    });
  print('____Som__ssssss____${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var resultFinal = jsonDecode(result);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyStatefulWidget()));
      setState(() {
        Fluttertoast.showToast(msg: "${resultFinal['message']}");
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  double lat = 0.0;
  double long = 0.0;
  int selectedSegmentVal = 0;
  void initState() {
    // TODO: implement initState
    super.initState();

    parcelHistory(1);

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
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/update_parcel_status'));
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
