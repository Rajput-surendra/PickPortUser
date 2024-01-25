import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_dekho_app/Helper/session.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Jdx_screens/parceldetailsscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/ParcelHistoryModel.dart';
import '../Model/myPlanModel.dart';
import 'package:http/http.dart'as http;
import '../Utils/api_path.dart';
import '../Utils/color.dart';
import 'notification_Screen.dart';

class OrderHistrry extends StatefulWidget {
  const OrderHistrry({Key? key}) : super(key: key);

  @override
  State<OrderHistrry> createState() => _OrderHistrryState();
}

class _OrderHistrryState extends State<OrderHistrry> {
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
                  Text(getTranslated(context, "orders"),style: TextStyle(color: whiteColor),),
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
                child: ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text(
                         getTranslated(context, "Parcel Details"),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        /*InkWell(
                            onTap: () {
                              Get.to(const ParcelHistory());
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: primaryColor),
                            )),*/
                      ],
                    ),
                    _segmentButton(),
                    SizedBox(

                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : parcelhistory?.data?.isEmpty ??false
                              ? const Center(
                                  child: Text(
                                    "Not any order",
                                    style: TextStyle(fontFamily: 'Lora'),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: parcelhistory?.data?.length ?? 0
                                      ,
                                  itemBuilder: (c, i) {
                                    return  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 0),
                                      child: InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             ParceldetailsScreen(
                                          //               orderid: parcelhistory!
                                          //                   .data![i].orderId,isFromParcelHistory: true,
                                          //             )));
                                        },
                                        child: Card(
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10)),
                                          child: Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                 CircleAvatar(
                                                   backgroundColor: whiteColor,
                                                  radius: 40,
                                                  child: Image.asset('assets/order.png',),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    const Text(
                                                      "Order ID",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                          fontFamily:
                                                              'Lora'),
                                                    ),
                                                    Text(
                                                      "${parcelhistory!.data![i].orderId}",
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Lora'),
                                                    ),

                                                    // Text("202",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
                                                    const Text(
                                                      "Total Amount",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                          fontFamily:
                                                              'Lora'),
                                                    ),
                                                    Text(
                                                      "${parcelhistory!.data![i].orderAmount}",
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Lora'),
                                                    ),
                                                    const Text(
                                                      "Order Status",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          fontFamily:
                                                          'Lora'),
                                                    ),
                                                    SizedBox(height: 5,),

                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    const Text(
                                                      "Parcel Count",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                          fontFamily:
                                                              'Lora'),
                                                    ),
                                                    Text(
                                                      "${parcelhistory!.data![i].parcelDetails}",
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Lora'),
                                                    ),
                                                    const Text(
                                                      "Order Date",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                          fontFamily:
                                                              'Lora'),
                                                    ),
                                                    Text(
                                                      "${parcelhistory!.data![i].onDate.toString().substring(0, 10)}",
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w600,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'Lora'),
                                                    ),
                                                     Text(
                                                      orderStatus(parcelhistory!.data![i].orderStatus ?? 'cancel'),
                                                      style: const TextStyle(
                                                          color: Colors
                                                              .black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          fontFamily:
                                                          'Lora'),
                                                    ),
                                                    const SizedBox(height: 5,),
                                           parcelhistory!.data![i].orderStatus == '7' ? InkWell(
                                                      onTap: (){
                                                        cancelOrder(parcelhistory!.data![i].orderId ?? '44', i);
                                                      },
                                                      child: Container(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            top: 2,
                                                            bottom: 2),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                            color: primaryColor),
                                                        child: const Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ) : SizedBox.shrink()
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                    )
                  ],
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
      'status': status.toString()
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
