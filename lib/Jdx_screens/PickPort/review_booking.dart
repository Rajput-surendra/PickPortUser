import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';


import 'package:job_dekho_app/Jdx_screens/PickPort/select_Vehicle.dart';
import 'package:job_dekho_app/Services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/session.dart';
import '../../Model/Get_Promo_code_Model.dart';
import '../../Model/get_vehicle_model.dart';
import '../../Model/order_detail_response.dart';
import '../../Utils/api_path.dart';
import '../../Utils/color.dart';
import '../Payment method.dart';
import '../notification_Screen.dart';

class ReviewBookingScreen extends StatefulWidget {
  ReviewBookingScreen({Key? key,this.dropLocation,this.picLocation,this.fId,this.sId,this.oID}) : super(key: key);
   String ? dropLocation,picLocation,fId,sId,oID;
  @override
  State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends State<ReviewBookingScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPromoCodeApi();
    getVehicleDetalsApi();

  }
  GetVehicleModel? getVehicleModel;
  String? amount;
  String? finalAmount;
  getVehicleDetalsApi() async {
    var headers = {
      'Cookie': 'ci_session=744a8af2a1d6d0a7f1db081293517c5787cd0ed4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/api_get_vihicle_data'));
     request.fields.addAll({
     'fee_id':widget.fId ?? '',
      'sale_id':widget.sId ?? '',
       'order_id':widget.oID.toString()
    });
   print('____Som___sssss___${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
     var result  = await response.stream.bytesToString();
     var finalResult  = GetVehicleModel.fromJson(json.decode(result));
     setState(() {
       getVehicleModel = finalResult;
         recipientMobileController.text =  "${getVehicleModel?.data?.receiverPhone.toString()}";
         recipientNameController.text =  "${getVehicleModel?.data?.receiverName.toString()}";
          amount = "${getVehicleModel?.data?.feeCharge.toString()}";

     });
    }
    else {
      print(response.reasonPhrase);
    }

    // var headers = {
    //   'Cookie': 'ci_session=2b2d06ce4e99b1d5fb26a28f7b25d29c8dfc4791'
    // };
    // var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}api_get_vihicle_data'));
    // request.fields.addAll({
    //   'fee_id':widget.fId.toString(),
    //   'sale_id': widget.sId.toString()
    // });
    //
    // request.headers.addAll(headers);
    // http.StreamedResponse response = await request.send();
    // if (response.statusCode == 200) {
    //
    //  var result  = await response.stream.bytesToString();
    //  var finalResult  = GetVehicleModel.fromJson(json.decode(result));
    //  setState(() {
    //    getVehicleModel = finalResult;
    //      recipientMobileController.text =  "${getVehicleModel?.data?.receiverName.toString()}";
    //      recipientNameController.text =  "${getVehicleModel?.data?.receiverName.toString()}";
    //
    //  });
    // }
    // else {
    //   print(response.reasonPhrase);
    // }

  }
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController recipientMobileController = TextEditingController();
  TextEditingController promocouponC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    print('____Som______${widget.sId}_________');
    return Scaffold(
      backgroundColor: primaryColor,
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
                      Navigator.pop(context);
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
                  Text(getTranslated(context, "Review Booking"),style: TextStyle(color: whiteColor,fontSize: 18),),
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
              child:
              getVehicleModel == null ? Center(child: CircularProgressIndicator()):    Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    Form(
                      key: _formKey,
                      child: Container(
                        child:
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 50,width: 50,
                                              child: Image.asset(
                                                'assets/ProfileAssets/2 wheeler.png',scale: 1.1,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15,left: 5),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                               Text("${getVehicleModel?.data?.capName}",style: const TextStyle(
                                                  fontWeight: FontWeight.bold

                                              ),),
                                              InkWell(
                                                onTap: (){
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                        builder: (context, setState) {
                                                          bool testBool = true;
                                                          return Dialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(12.0),
                                                                side: BorderSide(
                                                                    color: primaryColor
                                                                )), //this right here
                                                            child: GestureDetector(
                                                              onTap: (){
                                                                print(testBool);
                                                                setState((){
                                                                  testBool = !testBool;

                                                                });
                                                                print(testBool);
                                                              },
                                                              child: Container(
                                                                height: 210,
                                                                width:double.infinity,
                                                                child:  Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(getTranslated(context, "Pickup Location"),style: TextStyle(
                                                                          color: primaryColor
                                                                      ),),
                                                                     Row(
                                                                       children: [
                                                                         Container(
                                                                             width: 250,
                                                                             child: Text(widget.picLocation.toString(),overflow: TextOverflow.ellipsis,maxLines: 3,))
                                                                       ],
                                                                     ),
                                                                      const SizedBox(height: 10,),
                                                                      Divider(color: primaryColor,),
                                                                      Text(getTranslated(context, "Drop Location"),style: TextStyle(
                                                                          color: primaryColor
                                                                      ),),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                              width: 250,
                                                                              child: Text(widget.dropLocation.toString(),overflow: TextOverflow.ellipsis,maxLines: 3,))
                                                                        ],
                                                                      )

                                                                    ],
                                                                  ),
                                                                )
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(getTranslated(context, "View Address Details"),style: TextStyle(
                                                  color: primaryColor
                                                ),),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(getTranslated(context, "Receiver's Name"),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
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
                                    readOnly: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Recipent Name';
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
                              Text(getTranslated(context, "Receiver's Mobile Number"),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
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
                                    readOnly: true,
                                    maxLength: 10,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Phone No.';
                                      }
                                      return null;
                                    },
                                    controller: recipientMobileController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      //  hintText: "Recipient Mobile No.",
                                      counterText: '',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(getTranslated(context, "Offer & Discount"),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),

                              applyPromoCode(),
                              // Container(
                              //   width: MediaQuery
                              //       .of(context)
                              //       .size
                              //       .width / 1.1,
                              //   child: Card(
                              //     shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(10)
                              //     ),
                              //     child:Row(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       children: [
                              //         Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Container(
                              //             height: 50,width: 50,
                              //             child: Image.asset(
                              //               'assets/ProfileAssets/offer.png',scale: 1.1,
                              //             ),
                              //           ),
                              //         ),
                              //         Padding(
                              //           padding: const EdgeInsets.only(top: 15,left: 5),
                              //           child: Column(
                              //             mainAxisAlignment: MainAxisAlignment.center,
                              //             crossAxisAlignment: CrossAxisAlignment.start,
                              //             children: [
                              //               const Text("2 Wheelar"),
                              //               Text(getTranslated(context, "View Address Details"),style: TextStyle(
                              //                   color: primaryColor
                              //               ),),
                              //             ],
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),

                              const SizedBox(height: 10,),
                              Text(getTranslated(context, "Parcel Details"),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Material Category"),style: const TextStyle(fontWeight: FontWeight.bold)),
                                             Align(
                                               alignment: Alignment.topRight,
                                               child: Text("${getVehicleModel?.data?.categoryName}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                             ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Parcel Weight (Total)"),style: const TextStyle(fontWeight: FontWeight.bold),),
                                            Text("${getVehicleModel?.data?.maxWeight} kg"),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Text(getTranslated(context, "Total Distance"),style: const TextStyle(fontWeight: FontWeight.bold),),
                                        //     Text("${getVehicleModel?.data?.maxAmount} km"),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              getVehicleModel?.data?.onDate == null ? SizedBox.shrink():   Text(getTranslated(context, "Schedule Booking"),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              getVehicleModel?.data?.onDate == null ? SizedBox.shrink():   Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Date",style: const TextStyle(fontWeight: FontWeight.bold)),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text("${getVehicleModel?.data?.onDate}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Time",style: const TextStyle(fontWeight: FontWeight.bold),),
                                            Text("${getVehicleModel?.data?.deliveryTime}"),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Text(getTranslated(context, "Total Distance"),style: const TextStyle(fontWeight: FontWeight.bold),),
                                        //     Text("${getVehicleModel?.data?.maxAmount} km"),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              Text(getTranslated(context, "Fare Summery"),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.1,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Trip Fare"),style: const TextStyle(fontWeight: FontWeight.normal)),
                                            Text("₹ ${getVehicleModel?.data?.feeCharge}",style: TextStyle(fontFamily: "lora")),
                                          ],
                                        ),
                                        disCountAmount == null ? SizedBox.shrink():   Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Coupon Discount"),style: const TextStyle(fontWeight: FontWeight.normal),),
                                            Text("-₹ ${disCountAmount}",style: TextStyle(fontFamily: "lora")),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(getTranslated(context, "Amount"),style: const TextStyle(fontWeight: FontWeight.bold),),
                                           changePrice ? Text("₹ ${finalAmount.toString()}",style: TextStyle(fontFamily: "lora")):

                                             Text("₹ ${amount.toString()}",style: TextStyle(fontFamily: "lora",fontWeight: FontWeight.bold),),


                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: InkWell(
                                    onTap: () {

                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentMethod1(totalAmount:finalAmount == null ?double.parse(amount.toString()):double.parse(finalAmount.toString()),amount:double.parse(amount.toString()) ,orderid: widget.oID,isCheck: changePrice,cAmount: disCountAmount,feeId: widget.fId.toString())));
                                    },
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: primaryColor
                                      ),
                                      child:  Text("Book Now", style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,),),
                                    )),
                              ),
                              const SizedBox(height: 20,)

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

        ],
      ),


    );
  }

String? amt;
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


  applyPromoCode() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Container(

          height: 60,
          //width: MediaQuery.of(context).size.width * 10,
          decoration: BoxDecoration(
              // border: Border.all(
              //   color: primaryColor,
              //   width: 1,
              // ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white54
            //color: Colors.white54
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextField(

                    readOnly: true,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder: (BuildContext context,
                                StateSetter setState /*You can rename this!*/) {
                              return Card(

                                child: getPromoCodeModel!.data!.isEmpty ? Center(child: Text("No Promo Code!!")): ListView.builder(
                                    itemCount: getPromoCodeModel?.data?.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          height:getPromoCodeModel!.data!.isEmpty ? 20: 90,
                                          child: Card(
                                            elevation: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children:  [
                                                          Text(
                                                            "Promo Code :",
                                                            style: TextStyle(
                                                                color: backColor),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "Discount Price :",
                                                            style: TextStyle(
                                                                color: backColor,
                                                                fontSize: 15),
                                                          )
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "${getPromoCodeModel?.data?[index].couponCode}",
                                                            style:  TextStyle(
                                                                color: backColor),

                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),



                                                          Text(
                                                            "₹ ${getPromoCodeModel?.data?[index].discountValue}",
                                                            style:  TextStyle(
                                                                color: backColor,fontFamily: "lora"),
                                                          )
                                                        ],
                                                      ),
                                                      Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              right: 5,
                                                              top: 10),
                                                          child: InkWell(
                                                            onTap: () {
                                                              promocouponC.text = getPromoCodeModel?.data?[index].couponCode ??
                                                                      "";
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              height: 35,
                                                              width: 120,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      10),
                                                                  color: primaryColor),
                                                              child:
                                                               Center(
                                                                  child:
                                                                  Text(
                                                                    'Add PromoCode',
                                                                    style: TextStyle(
                                                                        color: whiteColor,fontSize: 12),
                                                                  )),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    }),
                              );
                            });
                          });
                    },
                    controller: promocouponC,
                    maxLines: 1,
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                        prefixIcon: Container(
                          height: 50,width: 50,
                          child: Image.asset(
                            'assets/ProfileAssets/offer.png',scale: 1.1,
                          ),
                        ),
                        hintText: 'Have You PromoCode ...'),style: TextStyle(
                    fontSize: 15
                  ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      if (promocouponC.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Select PromoCode!!");
                      } else {
                        applyPromoCodeApi(promocouponC.text);
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor),
                      child:  Center(
                          child: Text(
                            'Apply',
                            style: TextStyle(color: whiteColor),
                          )),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  bool changePrice = false;
  String? disCountAmount;
  applyPromoCodeApi(String? promoCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userid');
    var headers = {
      'Cookie': 'ci_session=629571a1020b37a590e0fe192aaf92d876eff397'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Payment/apply_promo_code'));
    request.fields.addAll({
      'promo_code':promoCode.toString(),
      'user_id':userId.toString()
    });
    print('____Som______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      setState(() {
        disCountAmount = finalResult['data']['discount_value'];
         finalAmount =  (double.parse(amount ?? '0.0') - double.parse(disCountAmount.toString())).toString();
        changePrice = true;
        print("aaaaaaaaaaaaaaa$finalAmount");
      });
    } else {

      print(response.reasonPhrase);
    }

  }

  GetPromoCodeModel? getPromoCodeModel;
  getPromoCodeApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userid');
    var headers = {
      'Cookie': 'ci_session=dab74b0957d0c3dd0a1615809e57a81f03b8162c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Payment/add_promo_code'));
    request.fields.addAll({
      'user_id':userId.toString()
    });
  print('____Som______${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetPromoCodeModel.fromJson(json.decode(result));
      setState(() {
        getPromoCodeModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }

  }
  // getPromoCodeApi() async {
  //   var headers = {
  //     'Cookie': 'ci_session=0bea62107d42e7a22b6f4f536f8aab0e1ae87c3b'
  //   };
  //   var request =
  //   http.Request('POST', Uri.parse('${ApiPath.baseUrl}add_promo_code'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result = await response.stream.bytesToString();
  //     var finalResult = GetPromoCodeModel.fromJson(json.decode(result));
  //     setState(() {
  //       getPromoCodeModel = finalResult;
  //     });
  //     print('_____checkPromoCode_____${finalResult}_________');
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
}
