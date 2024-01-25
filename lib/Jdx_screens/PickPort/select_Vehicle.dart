import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';

import 'package:job_dekho_app/Jdx_screens/PickPort/review_booking.dart';

import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Model/registerparcelmodel.dart';
import '../../Helper/session.dart';

import '../../Model/Vehicle_Data_Model_List.dart';
import '../../Model/get_vehicle_model.dart';
import '../../Utils/api_path.dart';
import '../../Utils/color.dart';
import '../notification_Screen.dart';

class SelcetVhicle extends StatefulWidget {
  SelcetVhicle({Key? key,this.dropLocation,this.picLocation,this.senderName,this.senderMobile,this.receiverName,this.receiverMobile,this.VichleList,this.orderId}) : super(key: key);
   String ? dropLocation,picLocation,senderName,senderMobile,receiverName,receiverMobile,orderId;
  Registerparcelmodel ? VichleList;
  @override
  State<SelcetVhicle> createState() => _SelcetVhicleState();
}

class _SelcetVhicleState extends State<SelcetVhicle> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVehicleApi();
    //getDialogDataApi("");
  }
  VehicleDataModelList? vehicleDataModelList;
  String? feeId,sellerId;

  getVehicleApi() async {
    var headers = {
      'Cookie': 'ci_session=273f516e87bc35d7471d6c241d39d5e0f5c2ee22'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/reorder_data'));
    request.fields.addAll({
      'order_id':widget.orderId.toString()
    });
  print('____Som__request.fields____${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
       var result  = await response.stream.bytesToString();
       var finalResult  = VehicleDataModelList.fromJson(json.decode(result));
       setState(() {
         vehicleDataModelList =  finalResult;
         widget.picLocation = "${vehicleDataModelList?.data?.senderAddress.toString()}";
         widget.senderName = "${vehicleDataModelList?.data?.senderName.toString()}";
         widget.senderMobile = "${vehicleDataModelList?.data?.senderPhone.toString()}";
         widget.dropLocation = "${vehicleDataModelList?.data?.receiverAddress.toString()}";
         widget.receiverName = "${vehicleDataModelList?.data?.receiverName.toString()}";
         widget.receiverMobile = "${vehicleDataModelList?.data?.receiverPhone.toString()}";
           sellerId = "${vehicleDataModelList?.data?.saleId.toString()}";
           print('____Som____sss__${sellerId}_________');

       });
    }
    else {
    print(response.reasonPhrase);
    }

  }

  final _formKey = GlobalKey<FormState>();
  int selectedIndex = -1;
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
                  Text(getTranslated(context, "Select Vchicle"),style: TextStyle(color: whiteColor,fontSize: 18),),
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
              child:
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
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
                                               Text("${widget.senderName}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                               SizedBox(width: 5,),
                                               Text("${widget.senderMobile}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                             ],
                                           ),
                                           Container(
                                               width: 280,
                                               child: Text("${widget.picLocation}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
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
                                                  Text("${widget.receiverName}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                  SizedBox(width: 5,),
                                                  Text("${widget.receiverMobile}",overflow: TextOverflow.ellipsis,maxLines: 1,),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                width: 280,
                                                child: Text("${widget.dropLocation}",overflow: TextOverflow.ellipsis,maxLines: 1,)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child:Column(
                                children: [
                                  vehicleDataModelList == null ? Center(child: CircularProgressIndicator()): Container(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: vehicleDataModelList?.deliveryFee?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = index;
                                               feeId = "${vehicleDataModelList?.deliveryFee?[index].feeId}";
                                              sellerId="${(vehicleDataModelList?.data!.saleId)}";
                                                print('____id______${feeId}____ vnvbnvbn_____');
                                                print('____id______${sellerId}____ vnvbnvbn_____');
                                              //String orderId="${widget.VichleList?.orderId}";

                                              //getDialogDataApi(vehicleDataModelList?.deliveryFee?[index].feeId ?? "");
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              elevation: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: selectedIndex == index ? whiteColor:backGround,
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: selectedIndex == index ? Border.all(color: primaryColor):null
                                                ),
                                                child:Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                     Row(

                                                       children: [
                                                         Card(
                                                             shape: RoundedRectangleBorder(
                                                                 borderRadius: BorderRadius.circular(100)
                                                             ),
                                                             elevation: 2,
                                                             child: Container(
                                                               height: 70,
                                                               width: 70,
                                                               child: ClipRRect(
                                                                   borderRadius: BorderRadius.circular(100),
                                                                   child: Image.network("${vehicleDataModelList?.deliveryFee?[index].image}",fit: BoxFit.fill,)),
                                                             )
                                                         ),
                                                         SizedBox(width: 5,),
                                                         Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [

                                                             Text("${vehicleDataModelList?.deliveryFee?[index].name}",style: const TextStyle(
                                                                 fontWeight: FontWeight.bold
                                                             ),),
                                                             InkWell(
                                                                 onTap: (){
                                                                   getDialogDataApi(vehicleDataModelList?.deliveryFee?[index].feeId);
                                                                 },
                                                                 child: Text("View Details",style: TextStyle(color: primaryColor,fontWeight: FontWeight.normal),)),
                                                           ],
                                                         ),
                                                       ],
                                                     ),
                                                      Text("₹ ${vehicleDataModelList?.deliveryFee?[index].feeCharge}",style: TextStyle(color: backColor,fontWeight: FontWeight.w500,fontFamily: "lora"),),
                                                    ],
                                                  )

                                                  // ListTile(
                                                  //   leading:  Card(
                                                  //     shape: RoundedRectangleBorder(
                                                  //         borderRadius: BorderRadius.circular(100)
                                                  //     ),
                                                  //     elevation: 2,
                                                  //     child: ClipRRect(
                                                  //         borderRadius: BorderRadius.circular(100),
                                                  //         child: Image.network("${widget.VichleList?.cap?[index].image}",fit: BoxFit.fill,))
                                                  //   ),
                                                  //   subtitle: Column(
                                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                                  //     children: [
                                                  //
                                                  //       Text("${widget.VichleList?.cap?[index].name}",style: const TextStyle(
                                                  //           fontWeight: FontWeight.bold
                                                  //       ),),
                                                  //       InkWell(
                                                  //           onTap: (){
                                                  //             showDialog(
                                                  //               context: context,
                                                  //               builder: (context) {
                                                  //                 return StatefulBuilder(
                                                  //                   builder: (context, setState) {
                                                  //                     bool testBool = true;
                                                  //                     return Dialog(
                                                  //                       shape: RoundedRectangleBorder(
                                                  //                           borderRadius:
                                                  //                           BorderRadius.circular(12.0),
                                                  //                           side: BorderSide(
                                                  //                               color: primaryColor
                                                  //                           )), //this right here
                                                  //                       child: GestureDetector(
                                                  //                         onTap: (){
                                                  //                           print(testBool);
                                                  //                           setState((){
                                                  //                             testBool = !testBool;
                                                  //
                                                  //                           });
                                                  //                           print(testBool);
                                                  //                         },
                                                  //                         child: Container(
                                                  //                             height: 200,
                                                  //                             width:double.infinity,
                                                  //                             child:  Padding(
                                                  //                               padding: const EdgeInsets.all(8.0),
                                                  //                               child: Column(
                                                  //                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                  //                                 children: [
                                                  //                                   Text(getTranslated(context, "Pickup Location"),style: TextStyle(
                                                  //                                       color: primaryColor
                                                  //                                   ),),
                                                  //                                   Row(
                                                  //                                     children: [
                                                  //                                       Container(
                                                  //                                           width: 250,
                                                  //                                           child: Text(widget.picLocation.toString(),overflow: TextOverflow.ellipsis,maxLines: 2,))
                                                  //                                     ],
                                                  //                                   ),
                                                  //                                   const SizedBox(height: 10,),
                                                  //                                   Divider(color: primaryColor,),
                                                  //                                   Text(getTranslated(context, "Drop Location"),style: TextStyle(
                                                  //                                       color: primaryColor
                                                  //                                   ),),
                                                  //                                   Row(
                                                  //                                     children: [
                                                  //                                       Container(
                                                  //                                           width: 250,
                                                  //                                           child: Text(widget.dropLocation.toString(),overflow: TextOverflow.ellipsis,maxLines: 2,))
                                                  //                                     ],
                                                  //                                   )
                                                  //
                                                  //                                 ],
                                                  //                               ),
                                                  //                             )
                                                  //                         ),
                                                  //                       ),
                                                  //                     );
                                                  //                   },
                                                  //                 );
                                                  //               },
                                                  //             );
                                                  //           },
                                                  //           child: Text("View Details",style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),)),
                                                  //     ],
                                                  //   ) ,
                                                  //   trailing: Column(
                                                  //     children: [
                                                  //       Text("₹ ${widget.VichleList?.cap?[index].feeCharge}",style: TextStyle(color: backColor,fontWeight: FontWeight.w500,fontFamily: "lora"),),
                                                  //
                                                  //     ],
                                                  //   )
                                                  // ),
                                                )
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
                                    child: InkWell(
                                        onTap: () {
                                          if(selectedIndex == -1){
                                            Fluttertoast.showToast(msg: "Please select atleast one");

                                          }else{
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewBookingScreen(dropLocation: widget.dropLocation,picLocation: widget.picLocation,
                                              sId: sellerId,fId: feeId,oID: widget.orderId,)));
                                          }
                                          // selectedIndex =


                                        },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: primaryColor
                                          ),
                                          child:  Text("Proceed", style: TextStyle(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,),),
                                        )),
                                  ),
                                  SizedBox(height: 20,)
                                ],
                              )

                            ),

                          ],
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


  String? capacity,description,distance;

  getDialogDataApi(fID) async {
    var headers = {
      'Cookie': 'ci_session=9bf5c78137dc3c73054a9e123e68dd082b4e67be'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/fee_data'));
    request.fields.addAll({

      'fee_id':fID.toString(),
      'order_id':widget.orderId.toString()
    });
  print('____Som__request.fields__gggg__${request.fields}_________');

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult  = jsonDecode(result);
      setState(() {
      capacity = finalResult['data']['capacity'];
       description = finalResult['data']['description'];
       distance = finalResult['data']['distance'];
      });
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
                      height:description == null ? 150:200,
                      width:double.infinity,
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Capacity",style: TextStyle(
                                    color: primaryColor
                                ),),
                                Text("${capacity.toString()}kg")
                              ],
                            ),
                            Divider(),


                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text("Distance",style: TextStyle(
                            //         color: primaryColor
                            //     ),),
                            //     Text("${distance.toString()}km")
                            //   ],
                            // ),
                            // Divider(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Distance",style: TextStyle(
                                    color: primaryColor
                                ),),
                                Text("${distance.toString()}km")
                              ],
                            ),
                            Divider(),

                            Text("Description",style: TextStyle(
                                color: primaryColor
                            ),),

                            description == null ? Text("No Description "):  Text("${description.toString()}")

                          ],
                        ),
                      )
                  ),
                ),
              );
            },
          );
        }
      );
    }
    else {
    print(response.reasonPhrase);
    }

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

}
