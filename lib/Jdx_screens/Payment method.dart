// import 'dart:convert';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dash/flutter_dash.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
// import 'package:job_dekho_app/Model/WalletHistoryModel.dart';
// import 'package:job_dekho_app/Views/payment_success_screen.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../Helper/session.dart';
// import '../Utils/api_path.dart';
// import '../Utils/color.dart';
// import 'MyProfile.dart';
// import 'PickPort/booking_Confirm.dart';
// import 'notification_Screen.dart';
// class PaymentMethod1 extends StatefulWidget {
//   String? orderid,cAmount,feeId;
//   double? totalAmount,amount;
//   bool? isCheck;
//    PaymentMethod1({Key? key, this.orderid, this.totalAmount,this.isCheck,this.amount,this.cAmount,this.feeId}) : super(key: key);
//
//   @override
//   State<PaymentMethod1> createState() => _PaymentMethod1State();
// }
// class _PaymentMethod1State extends State<PaymentMethod1> {
//
//   paymentType(String type) async{
//     isLoading = true;
//     setState(() {
//
//     });
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userid = preferences.getString('userid');
//
//     var headers = {
//       'Cookie': 'ci_session=c2b9ec387d53f2644408cb4191cab39d16906144'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Payment/pay_now'));
//     request.fields.addAll({
//       'paymenttype': type,
//       'user_id': userid.toString(),
//       'order_id':widget.orderid.toString(),
//       'subtotal': widget.isCheck == true ? widget.amount.toString(): widget.totalAmount.toString(),
//       'coupan_amount':widget.cAmount == null ? "0.0":widget.cAmount.toString(),
//      'fee_id':widget.feeId.toString()
//     });
//     print("Param ${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//       isLoading = false;
//      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaymentSuccessfulScreen(),));
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BookingConfirmScreen()));
//       Fluttertoast.showToast(msg: 'Payment Successfully ') ;
//       setState(() {
//
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//   List<Payments> paymentTypeList = [
//     Payments(type: 'Cash On Payment', image: 'assets/cod.png'),
//     Payments(type: 'Online Payment', image: 'assets/online.png'),
//     Payments(type: 'Wallet', image: 'assets/wallet.png'),
//   ];
//
//   bool isLoading = false ;
//
//    @override
//    void initState() {
//      walletHistroy();
//      _razorpay = Razorpay();
//      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//     super.initState();
//
//    }
//
//   //List<String> paymenttypelist =["Cash On Delivery", "Online Payment", "Wallet"];
//
//   WalletHistoryModel? walletHistoryModel;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: Column(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20,right: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: (){
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                             color: whiteColor,
//                             borderRadius: BorderRadius.circular(100)
//                         ),
//                         child: Center(child: Icon(Icons.arrow_back)),
//                       ),
//                     ),
//                     Text(getTranslated(context, "Payment"),style: TextStyle(color: whiteColor),),
//                     Container(
//                       height: 40,
//                       width: 40,
//                       decoration:  BoxDecoration(
//                           color: splashcolor,
//                           borderRadius:
//                           BorderRadius.circular(100)),
//                       child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                     const SupportNewScreen()));
//                           },
//                           child: Center(
//                             child: Image.asset(
//                               'assets/ProfileAssets/support.png',scale: 1.3,
//                             ),
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 11,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: backGround,
//                     borderRadius: BorderRadius.only(topRight: Radius.circular(50))
//                 ),
//                 child: Container(
//                   child: Column(
//                     children: [
//                       ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemCount: paymentTypeList.length,
//                           itemBuilder: (c,i){
//                             return Padding(
//                               padding: EdgeInsets.only(bottom: 0),
//                               child: InkWell(
//
//                                   onTap: (){
//                                     print('_____Wallet______${walletHistoryModel?.wallet}');
//                                     final value = double.parse(walletHistoryModel?.wallet ?? '0.0') ;
//
//                                     if(paymentTypeList[i].type.toString() == "Wallet") {
//                                       if (value >= double.parse("${widget.totalAmount}" ??"0.0")) {
//                                         paymentType(paymentTypeList[i].type ??'');
//
//                                       }else {
//                                         Fluttertoast.showToast(msg: " you have not enough balance in your wallet for the order");
//                                       }
//                                     }else if(paymentTypeList[i].type.toString() == "Cash On Payment"){
//                                       print('__________Cash On Payment_________');
//                                       paymentType(paymentTypeList[i].type ??'');
//
//                                     }else{
//                                       openCheckout();
//                                       print('__________online_________');
//
//                                       Fluttertoast.showToast(msg: paymentTypeList[i].type ?? 'online');
//                                     }
//
//
//
//                                     //
//                                     //
//                                     // Get.to(ParceldetailsScreen());
//                                   },
//                                   child: Card(
//                                       elevation: 4,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(10)
//                                       ),
//                                       child: Container(
//                                           padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10),
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               CircleAvatar(
//                                                 backgroundImage: AssetImage(paymentTypeList[i].image?? ''),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Dash(
//                                                       direction: Axis.vertical,
//                                                       length: 50,
//                                                       dashLength: 2,
//                                                       dashColor: primaryColor),
//                                                   Padding(
//                                                       padding: const EdgeInsets.all(10.0),
//                                                       child: Text(
//                                                           paymentTypeList[i].type ?? 'null',
//                                                           style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500))),
//                                                 ],
//                                               ),
//                                               const SizedBox(height: 10),
//                                               Row(
//                                                   mainAxisAlignment: MainAxisAlignment.end,
//                                                   // mainAxisSize: MainAxisSize.max,
//                                                   children: [
//                                                     Container(
//                                                         height: 50,width: 50,
//                                                         decoration: BoxDecoration(
//                                                             color: backGround,
//                                                             borderRadius: BorderRadius.circular(100)
//                                                         ),
//                                                         child: Center(child: Image.asset("assets/DrawerAssets/forwardIcon.png", color: primaryColor,)))
//                                                   ]),
//
//                                             ],
//                                           )))),
//                             );
//                           }),
//                       SizedBox(height: 80,),
//                       // InkWell(
//                       //     onTap: () {
//                       //
//                       //
//                       //     },
//                       //     child: Container(
//                       //       height: 50,
//                       //       width: MediaQuery
//                       //           .of(context)
//                       //           .size
//                       //           .width / 1.1,
//                       //       alignment: Alignment.center,
//                       //       decoration: BoxDecoration(
//                       //           borderRadius: BorderRadius.circular(10),
//                       //           color: primaryColor
//                       //       ),
//                       //       child:  Text("Done", style: TextStyle(
//                       //         color: whiteColor,
//                       //         fontWeight: FontWeight.bold,
//                       //         fontSize: 14,),),
//                       //     )),
//
//                       // Column(
//                       //   mainAxisAlignment: MainAxisAlignment.start,
//                       //   crossAxisAlignment: CrossAxisAlignment.start,
//                       //   children: [
//                       //     Text("Order ID",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
//                       //     Text("${parcelhistory!.data![i].orderId}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Lora'),),
//                       //
//                       //     // Text("202",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
//                       //     Text("Total Amount",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
//                       //     Text("${parcelhistory!.data![i].orderAmount}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Lora'),),
//                       //   ],
//                       // ),
//                       // Column(
//                       //   mainAxisAlignment: MainAxisAlignment.start,
//                       //   crossAxisAlignment: CrossAxisAlignment.start,
//                       //   children: [
//                       //     Text("Parcel Count",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
//                       //     Text("${parcelhistory!.data![i].userId}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Lora'),),
//                       //     Text("Order Date",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
//                       //     Text("${parcelhistory!.data![i].onDate}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Lora'),),
//                       //
//                       //
//                       //   ],)
//                     ],
//                   )
//
//
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.all(8.0),
//                 //   child: Column(
//                 //     // shrinkWrap: true,
//                 //     // physics: const ScrollPhysics(),
//                 //     children: [
//                 //
//                 //      // isLoading ? const Center(child: CircularProgressIndicator(),) : SizedBox()
//                 //     ],
//                 //   ),
//                 // ),
//               ),
//             )
//
//
//
//           ],
//       ),
//     );
//   }
//
//   walletHistroy() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userid = preferences.getString('userid');
//
//     var headers = {
//       'Content-Type': 'application/json',
//       'Cookie': 'ci_session=fa798ca5ff74e60a6d79d768d0be8efac030321a'
//     };
//     var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}Payment/wallet_history'));
//     request.body = json.encode({
//       "user_id": userid.toString(),
//     });
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       print('Userr Id@@@@@@@${userid}');
//       var finalResult = await response.stream.bytesToString();
//       final jsonResponse = WalletHistoryModel.fromJson(json.decode(finalResult));
//       setState((){
//         walletHistoryModel = jsonResponse;
//         print('₹ ${walletHistoryModel?.wallet?? '---'}');
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//   String? pricerazorpayy;
//   late Razorpay _razorpay;
//
//   void openCheckout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? email = prefs.getString('email');
//     String? phone = prefs.getString('phone');
//     int amt = widget.totalAmount!.toInt() ;
//
//
// print('${email}_______________');
// print('${phone}_______________');
// print('${widget.totalAmount.toString()}_______________');
// print('${amt}_______________');
//
//       var options = {
//         'key': 'rzp_test_1DP5mmOlF5G5ag',
//         'amount': amt*100,
//         'name': 'pick Port',
//         'description': 'pick Port',
//       "currency": "INR",
//         'prefill': {'contact': '$phone', 'email': '$email'},
//         'external': {
//           'wallets': ['paytm']
//         }
//       };
//       try {
//         _razorpay.open(options);
//       } catch (e) {
//         debugPrint('Error: $e');
//       }
//     }
//
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     // RazorpayDetailApi();
//     // Order_cash_ondelivery();
//     /* advancePayment( widget.data.quotation!.id
//         .toString(),
//         widget.data.quotation!
//             .assignmentId
//             .toString(),
//         response.paymentId);*/
//
//     Fluttertoast.showToast(
//         msg: "Successful",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0);
//     // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));
//         paymentType('Online Payment');
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Fluttertoast.showToast(
//     //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
//     //     toastLength: Toast.LENGTH_SHORT);
//
//     print('${response.error}________error_________');
//     print('${response.code}________code_________');
//     Fluttertoast.showToast(
//         msg: "Payment cancelled by user",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName!,
//         toastLength: Toast.LENGTH_SHORT);
//   }
//
//   }
// class Payments {
//   String? type, image;
//
//   Payments({this.type, this.image});
//
// }

import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_dekho_app/Jdx_screens/Dashbord.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:job_dekho_app/Model/WalletHistoryModel.dart';
import 'package:job_dekho_app/Views/payment_success_screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper/session.dart';
import '../Utils/api_path.dart';
import '../Utils/color.dart';
import 'MyProfile.dart';
import 'PickPort/booking_Confirm.dart';
import 'notification_Screen.dart';

class PaymentMethod1 extends StatefulWidget {
  String? orderid,cAmount,feeId;
  double? totalAmount,amount;
  bool? isCheck;
  PaymentMethod1({Key? key, this.orderid, this.totalAmount,this.isCheck,this.amount,this.cAmount,this.feeId}) : super(key: key);

  @override
  State<PaymentMethod1> createState() => _PaymentMethod1State();
}

class _PaymentMethod1State extends State<PaymentMethod1> {

  paymentType(String type) async{
    setState(() {
      isLoading = true;
    });


    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userid = preferences.getString('userid');

    var headers = {
      'Cookie': 'ci_session=c2b9ec387d53f2644408cb4191cab39d16906144'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Payment/pay_now'));
    request.fields.addAll({
      'paymenttype': type,
      'user_id': userid.toString(),
      'order_id':widget.orderid.toString(),
      'subtotal': widget.isCheck == true ? widget.amount.toString(): widget.totalAmount.toString(),
      'coupan_amount':widget.cAmount == null ? "0.0":widget.cAmount.toString(),
      'fee_id':widget.feeId.toString()
    });
    print("Param ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    isLoading = false;
    setState(() {

    });
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalRsult  =  jsonDecode(result);
      if(type == 'Cash On Delivery'){
        Fluttertoast.showToast(msg: 'Booking successfully') ;
      }else{
        Fluttertoast.showToast(msg: '${finalRsult['message']}') ;
      }

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (context) => BookingConfirmScreen(picLocation: widget.orderid.toString(),)), (MyStatefulWidget) => false);
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingConfirmScreen(picLocation: widget.orderid.toString(),)));
      isLoading = false;
      setState(() {

      });
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) =>
      //           PaymentSuccessfulScreen(),
      //     ));

      setState(() {
        isLoading = false;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  List<Payments> paymentTypeList = [
    Payments(type: 'Cash On Delivery', image: 'assets/cod.png'),
    Payments(type: 'Online Payment', image: 'assets/online.png'),
    Payments(type: 'PickPort Wallet', image: 'assets/wallet.png'),
  ];

  bool isLoading = false ;

  @override
  void initState() {
    walletHistroy();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();

  }

  //List<String> paymenttypelist =["Cash On Delivery", "Online Payment", "Wallet"];

  WalletHistoryModel? walletHistoryModel;


  @override
  Widget build(BuildContext context) {
    print('____Som______${widget.orderid}_________');
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
                  Text(getTranslated(context, "Payment"),style: TextStyle(color: whiteColor,fontSize: 16),),
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
              isLoading  == true ?Center(child: CircularProgressIndicator()):
              Container(
                  child: Column(
                    children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: paymentTypeList.length,
                          itemBuilder: (c,i){
                            return Padding(
                              padding: EdgeInsets.only(bottom: 0),
                              child: InkWell(

                                  onTap: (){
                                    isLoading = true;
                                    setState(() {

                                    });
                                    print('_____Wallet______${paymentTypeList[i].type}__________');
                                    final value = double.parse(walletHistoryModel?.wallet ?? '0.0') ;

                                    if(paymentTypeList[i].type.toString() == "PickPort Wallet") {
                                      if (value >= widget.totalAmount!.toDouble()) {
                                        paymentType(paymentTypeList[i].type ??'');

                                      }else {
                                        Fluttertoast.showToast(msg: " you have not enough balance in your wallet for the order");
                                      }
                                    }else if(paymentTypeList[i].type.toString() == "Cash On Delivery"){
                                      print('__________Cash On Payment_________');
                                      paymentType(paymentTypeList[i].type ??'');

                                    }else{
                                      openCheckout();
                                      print('__________online_________');

                                      Fluttertoast.showToast(msg: paymentTypeList[i].type ?? 'online');
                                    }



                                    //
                                    //
                                    // Get.to(ParceldetailsScreen());
                                  },
                                  child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: ListTile(
                                              leading:  CircleAvatar(
                                                backgroundImage: AssetImage(paymentTypeList[i].image?? ''),
                                              ),

                                              subtitle:Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Row(
                                                    children: [
                                                      Dash(
                                                          direction: Axis.vertical,
                                                          length: 50,
                                                          dashLength: 2,
                                                          dashColor: primaryColor),
                                                      Padding(
                                                          padding: const EdgeInsets.all(10.0),
                                                          child: Text(
                                                              paymentTypeList[i].type ?? 'null',
                                                              style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500))),
                                                    ],
                                                  ),



                                                ],
                                              ),
                                              trailing:  Container(
                                                  height: 50,width: 50,
                                                  decoration: BoxDecoration(
                                                      color: backGround,
                                                      borderRadius: BorderRadius.circular(100)
                                                  ),
                                                  child: Center(child: Image.asset("assets/DrawerAssets/forwardIcon.png", color: primaryColor,))),

                                            )





                                        ),
                                      ))),
                            );
                          }),
                      SizedBox(height: 80,),
                      // InkWell(
                      //     onTap: () {
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingConfirmScreen()));
                      //
                      //     },
                      //     child: Container(
                      //       height: 50,
                      //       width: MediaQuery
                      //           .of(context)
                      //           .size
                      //           .width / 1.1,
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           color: primaryColor
                      //       ),
                      //       child:  Text("Done", style: TextStyle(
                      //         color: whiteColor,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 14,),),
                      //     )),

                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text("Order ID",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
                      //     Text("${parcelhistory!.data![i].orderId}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Lora'),),
                      //
                      //     // Text("202",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
                      //     Text("Total Amount",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
                      //     Text("${parcelhistory!.data![i].orderAmount}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Lora'),),
                      //   ],
                      // ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text("Parcel Count",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
                      //     Text("${parcelhistory!.data![i].userId}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Lora'),),
                      //     Text("Order Date",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Lora'),),
                      //     Text("${parcelhistory!.data![i].onDate}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Lora'),),
                      //
                      //
                      //   ],)
                    ],
                  )


              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     // shrinkWrap: true,
              //     // physics: const ScrollPhysics(),
              //     children: [
              //
              //      // isLoading ? const Center(child: CircularProgressIndicator(),) : SizedBox()
              //     ],
              //   ),
              // ),
            ),
          )



        ],
      ),
    );
  }

  walletHistroy() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userid = preferences.getString('userid');

    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=fa798ca5ff74e60a6d79d768d0be8efac030321a'
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}Payment/wallet_history'));
    request.body = json.encode({
      "user_id": userid.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print('Userr Id@@@@@@@${userid}');
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = WalletHistoryModel.fromJson(json.decode(finalResult));
      setState((){
        walletHistoryModel = jsonResponse;
        print('₹ ${walletHistoryModel?.wallet?? '---'}');
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  String? pricerazorpayy;
  late Razorpay _razorpay;

  void openCheckout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? phone = prefs.getString('phone');
    double amt =  double.parse("${ widget.totalAmount}") ;


    print('${email}_______________');
    print('${phone}_______________');
    print('${widget.totalAmount.toString()}_______________');
    print('${amt}_______________');

    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amt*100,
      'name': 'Pick Port',
      'description': 'Pick Port',
      "currency": "INR",
      'prefill': {'contact': '$phone', 'email': '$email'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    paymentType('Online Payment');
    // RazorpayDetailApi();
    // Order_cash_ondelivery();
    /* advancePayment( widget.data.quotation!.id
        .toString(),
        widget.data.quotation!
            .assignmentId
            .toString(),
        response.paymentId);*/

    Fluttertoast.showToast(
        msg: "Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoardScreen()));

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
    //     toastLength: Toast.LENGTH_SHORT);

    print('${response.error}________error_________');
    print('${response.code}________code_________');
    Fluttertoast.showToast(
        msg: "Payment cancelled by user",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

}





class Payments {
  String? type, image;

  Payments({this.type, this.image});

}