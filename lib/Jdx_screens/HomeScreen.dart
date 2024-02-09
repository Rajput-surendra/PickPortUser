import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Helper/session.dart';
import 'package:job_dekho_app/Jdx_screens/Mywallet.dart';
import 'package:job_dekho_app/Jdx_screens/parcel_history.dart';
import 'package:job_dekho_app/Jdx_screens/parceldetailsscreen.dart';
import 'package:job_dekho_app/Model/slider_response.dart';
import 'package:permission_handler/permission_handler.dart';

//import 'package:place_picker/entities/location_result.dart';
//import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/ParcelHistoryModel.dart';
import '../Model/bannerModel.dart';
import '../Model/myPlanModel.dart';
import '../Utils/api_path.dart';
import '../Utils/color.dart';
import 'PickPort/RegisterParcel.dart';
import 'PickPort/SupportNewScreen.dart';
import 'PickPort/booking_Confirm.dart';
import 'notification_Screen.dart';
import 'signup_Screen.dart';
String? senderLocation;
double ?latSender,longSender;
TextEditingController addressC = TextEditingController();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameC = TextEditingController();
  TextEditingController mobileC = TextEditingController();
  TextEditingController pincodeC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController stateC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  double lat = 0.0;
  double long = 0.0;
  int selectedSegmentVal = 0;

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

   updateLoction()
   async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.getString("location") == null ? _getLocation():locallocation();
   setState(() {

   });
   }
   locallocation() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     addressC.text = prefs.getString("location")??"";
     setState(() {

     });
   }
  void initState() {
    // TODO: implement initState
    super.initState();
      parcelHistory(1);
      getbanner();
    updateLoction();



  }

  final CarouselController carouselController = CarouselController();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   PushNotificationService pushNotificationService = new PushNotificationService(context: context);
  //   pushNotificationService.initialise();
  //   super.initState();
  //   Future.delayed(Duration(milliseconds: 300),(){
  //   });
  //
  //   // Future.delayed(Duration(seconds: 1),(){
  //   //   return getParentCheckStudent();
  //   // });
  //
  //l
  //
  //   Future.delayed(Duration(milliseconds: 500),(){
  //     return getbanner();
  //   });
  //   Future.delayed(Duration(milliseconds: 300),(){
  //   });
  // }

  // GetSliderModel? getSliderModel;
  // getSliderApi() async {
  //   var headers = {
  //     'Cookie': 'ci_session=223c99b9154d8e484937219b2e76683b956e9a89'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/delivery_bannerList'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result  = await response.stream.bytesToString();
  //     var finalResult = GetSliderModel.fromJson(json.decode(result));
  //     setState(() {
  //       getSliderModel =  finalResult;
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }
  int _currentPost = 0;
  _buildDots() {
    List<Widget> dots = [];
    if (bannerModel == null) {
    } else {
      for (int i = 0; i < bannerModel!.amount!.length; i++) {
        dots.add(
          Container(
            margin: const EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ?  primaryColor :Secondry,
            ),
          ),
        );
      }
    }
    return dots;
  }



  SliderResponse? bannerModel;

  getbanner() async {
    var headers = {
      'Cookie': 'ci_session=cf3c69364b479a1553327c57f04f890a05359969'
    };
    var request = http.Request('GET', Uri.parse('${ApiPath.baseUrl}Payment/slider?type=2'));
  print('____Som______${request}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = SliderResponse.fromJson(json.decode(finalResult));
      setState(() {
        bannerModel = jsonResponse;
        print('__________${bannerModel?.amount}___banner__________');
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  int? currentindex;

  showChildDialog() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
    if (result == true) {
      //  getbanner();
    }
  }

  Future _refreshLocalGallery() async {
    getbanner();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Exit App',
              style: TextStyle(fontFamily: 'Lora'),
            ),
            content: const Text(
              'Do you want to exit an App?',
              style: TextStyle(fontFamily: 'Lora'),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: const Text(
                  'No',
                  style: TextStyle(fontFamily: 'Lora'),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {
                  exit(0);
                  // Navigator.pop(context,true);
                  // Navigator.pop(context,true);
                },
                //return true when click on "Yes"
                child: const Text(
                  'Yes',
                  style: TextStyle(fontFamily: 'Lora'),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  String _location = 'Unknown';
  Future<void> _getLocation() async {

    var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      // Location permission granted, now get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);


        List<Placemark> placemarks = await placemarkFromCoordinates(
          latSender = position.latitude,
          longSender = position.longitude,

        );
        Placemark place = placemarks[0];
        setState(() {
          addressC.text = '${place.street}, ${place.locality}, ${place
              .administrativeArea}, ${place.country}';
          senderLocation = addressC.text;
        });
      } catch (e) {
        print("Error getting location: $e");
        setState(() {
          _location = 'Error getting location';
        });
      }
      // Now you have the current location in the `position` variable
      print('Current Location: ${position.latitude}, ${position.longitude}');


    }
    else {
    // Location permission denied
    // Handle accordingly (e.g., show a message to the user)
    }
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshLocalGallery,
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20,),
                          SizedBox(
                            height: 20,
                            child: TextField(

                              readOnly: true,
                              maxLines: 1,
                              onTap: () {
                                //_getLocation();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlacePicker(
                                      apiKey: Platform.isAndroid
                                          ? "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY"
                                          : "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY",
                                      onPlacePicked: (result) async {
                                        print(result.formattedAddress);
                                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                                              prefs.setString('location',  result.formattedAddress.toString());

                                        setState(() {
                                          addressC.text =
                                              result.formattedAddress.toString();
                                          latSender = result.geometry!.location.lat;
                                          longSender = result.geometry!.location.lng;
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      initialPosition: const LatLng(
                                          22.719568,75.857727),
                                      useCurrentLocation: true,
                                    ),
                                  ),
                                );
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                hintText: getTranslated(context, "Current Location"),
                                hintStyle:
                                TextStyle(fontWeight: FontWeight.bold,color: whiteColor),
                                prefixIcon: Image.asset(
                                  'assets/ProfileAssets/locationIcon.png',scale: 1.3,
                                  color: Secondry,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                                width: 250,
                                child: Text("${addressC.text}",overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(color: whiteColor),)),
                          )


                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                        child: Row(
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const NotificationScreen()));
                                  },
                                  child: Center(
                                    child: Image.asset(
                                      'assets/ProfileAssets/notification.png',scale: 1.3,

                                    ),
                                  )),
                            ),
                            const SizedBox(width: 5,),
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
                        )
                    ),

                    // Expanded(
                    //   flex: 1,
                    //   child: InkWell(
                    //     onTap: (){
                    //       Navigator.push(context, MaterialPageRoute(builder: (context) => MyWallet()));
                    //     },
                    //     child: Container(
                    //         padding: const EdgeInsets.only(right: 10),
                    //         height: 50,
                    //
                    //         decoration:  BoxDecoration(
                    //             color: splashcolor,
                    //             borderRadius:
                    //             const BorderRadius.only(topRight: Radius.circular(10),bottomRight:Radius.circular(10) )),
                    //         child: Icon(Icons.account_balance_wallet, color: primaryColor,)),
                    //   ),
                    // )

                  ],
                ),
              ),
              Expanded(
                flex: 9,
                child: Container(
                  decoration: BoxDecoration(
                      color: backGround,
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(50))
                  ),
                  child:
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            bannerModel == null ? const Center(child: CircularProgressIndicator()):  bannerModel?.amount?.isEmpty ?? false ?Center(child: Text("No Banner Found!!")):  CarouselSlider(
                                items: bannerModel?.amount?.map(
                                      (item) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 6,right: 6),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          "${item.sliderImage}",
                                                        ),
                                                        fit: BoxFit.fill)),
                                              )
                                          ),
                                        ),
                                      ]),
                                ).toList(),
                                carouselController: carouselController,
                                options: CarouselOptions(
                                    height: 150,
                                    scrollPhysics: const BouncingScrollPhysics(),
                                    autoPlay: true,
                                    aspectRatio: 1.8,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentPost = index ;
                                      });

                                    })),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildDots(),),
                            // sliderPointers (items , currentIndex),

                          ],),
                        // SizedBox(
                        //   height: 150,
                        //   width: MediaQuery.of(context).size.width/1.2,
                        //   child:bannerModel== null ?  Center(child: CircularProgressIndicator(color: splashcolor,)) :  ClipRRect(
                        //       borderRadius: BorderRadius.circular(10),
                        //       child: Image.network(
                        //          '${ApiPath.imgUrl}${bannerModel?.amount}',
                        //         fit: BoxFit.fill,
                        //       )),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                          Text(getTranslated(context, "Bookings")),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  _dialogBuilder(context);
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5,),
                                      Container(
                                       height: 80,width: 100,
                                        child: Image.asset(
                                          'assets/ProfileAssets/2 wheeler.png',height: 40,width: 40,
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(getTranslated(context, "2 Wheeler")),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistParcelScreen()));
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5,),
                                      Container(
                                        height: 80,width: 100,
                                        child: Image.asset(
                                          'assets/ProfileAssets/3 wheeler.png',height: 50,width: 50,
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(getTranslated(context, "3 Wheeler")),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistParcelScreen()));
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5,),
                                      Container(
                                        height: 80,width: 100,
                                        child: Image.asset(
                                          'assets/ProfileAssets/tata ace.png',height: 50,width: 50,
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(getTranslated(context, "Tata Ace")),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistParcelScreen()));
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5,),
                                      Container(
                                        height: 90,width: 100,
                                        child: Image.asset(
                                          'assets/ProfileAssets/mahindra pickup.png',height: 50,width: 50,
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(getTranslated(context, "Mahindra Pickup")),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistParcelScreen()));
                                },
                                child: Card(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5,),
                                      Container(
                                        height: 90,width: 100,
                                        child: Image.asset(
                                          'assets/ProfileAssets/total 407.png',height: 50,width: 50,
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(getTranslated(context, "Tato 407")),
                                      const SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 8,),
                        Container(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/ProfileAssets/home1111111.png',
                          ),
                        ),
                        const SizedBox(height: 40,),

                      ],
                    ),
                  ),
                ),
              )

            ],
          ),
    )
      )
    );
  }

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

 /* _getLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
            )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
    setState(() {
      addressC.text = result.formattedAddress.toString();
      cityC.text = result.locality.toString();
      stateC.text = result.administrativeAreaLevel1!.name.toString();
      countryC.text = result.country!.name.toString();
      lat = result.latLng!.latitude;
      long = result.latLng!.longitude;
      pincodeC.text = result.postalCode.toString();
    });
  }*/

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
                        ? [primaryColor, Colors.redAccent]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(0),
              child: Text(
                'Active',
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
                        ? [primaryColor, Colors.redAccent]
                        : [Colors.transparent, Colors.transparent])),
            child: MaterialButton(
              shape: const StadiumBorder(),
              onPressed: () => setSegmentValue(1),
              child: FittedBox(
                child: Text(
                  'Complete',
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
    print("qqqqqqqqqqqqq${request.fields}");
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order Cancel successfully')));

      parcelhistory?.data?.removeAt(i) ;
      setState(() {

      });
    }
    else {
    print(response.reasonPhrase);
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(

          child: AlertDialog(
            backgroundColor:  whiteColor  ,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            title:  const Text(""),
            content:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,

                width: double.infinity  ,
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistParcelScreen()));
                        },
                        child: Card(
                          elevation: 2,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Container(
                                height: 90,width: 80,
                                child: Image.asset(
                                  'assets/ProfileAssets/Gear Vehicle.png',height: 50,width: 50,
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(getTranslated(context, "Gear Vehicle")),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistParcelScreen()));
                        },
                        child: Card(
                          elevation: 2,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Container(
                                height: 90,width: 80,
                                child: Image.asset(
                                  'assets/ProfileAssets/non gear.png',height: 50,width: 50,
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Text(getTranslated(context, "Non Gear Vehicle")),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

          ),
        );
      },
    );
  }


}
