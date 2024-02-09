
import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Helper/session.dart';
import 'package:job_dekho_app/Jdx_screens/privacypolicy_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/signin_Screen.dart';
import 'package:job_dekho_app/Jdx_screens/termsandcondition_Screen.dart';
import 'package:job_dekho_app/Utils/color.dart';

import '../Helper/PickModel/get_city_model.dart';
import '../Helper/PickModel/get_status_model.dart';
import '../Model/animal_cat_model_response.dart';
import '../Utils/api_path.dart';
import 'Dashbord.dart';
import 'PickPort/help_Screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  //singUpModel? information;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
  TextEditingController referalController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController gstAddressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  double? lat;
  double? long;
  bool? isLoading = false;
  signUpApi() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=c59791396657a1155df9f32cc7d7b547a40d648c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/registration'));
    request.fields.addAll({
      'user_fullname':nameController.text,
      'user_phone':mobController.text,
      'user_email':emailController.text,
      'user_state':stateId.toString(),
      'user_city':cityId.toString(),
      'user_password':passController.text,
      'referral_code':referalController.text,
      'gst_type':_value.toString(),
      'gst_number':gstController.text,
      'gst_address':gstAddressController.text,
      'firebaseToken': ''
    });
     print('____Som______${ request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     var result =   await response.stream.bytesToString();
     var finalResult =  jsonDecode(result);
     setState(() {
       isLoading = false;
     });
     if(finalResult['status'] == true) {
       setState(() {
         // Fluttertoast.showToast(msg: "${finalResult['message']}");
         Fluttertoast.showToast(
             msg: "Sign Up successfully , please login to continue");
       });
     }
     if(finalResult['status'] == false){
       Fluttertoast.showToast(msg: "${finalResult['message']}");
     }else{
       Navigator.pop(context);

     }
    // Navigator.push(context, MaterialPa
      // geRoute(builder: (context)=>))
    }
    else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }

  }

  // signUpApi() async {
  //   var headers = {
  //     'Cookie': 'ci_session=441db6d062b9f121348edb7be09465992a51c601'
  //   };
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           'https://developmentalphawizz.com/pickport/api/Authentication/deliveryBoyRegistration'));
  //
  //   request.fields.addAll({
  //     'user_fullname': nameController.text,
  //     'user_email': emailController.text,
  //     'user_password': passController.text,
  //     'user_phone': mobController.text,
  //     'firebaseToken': '4',
  //     'aadhaar_card_no': aadharController.text,
  //     'vehicle_type': VhicletypeController.text,
  //     'vehicle_no': VhicleController.text,
  //     'driving_licence_no': LicenceController.text,
  //     'account_holder_name': '5',
  //     'account_number': '7',
  //     'ifsc_code': '4',
  //     'user_image': '',
  //     'address': addressController.text,
  //     'lat': '${lat}',
  //     'lang': '${long}'
  //   });
  //
  //   request.files.add(await http.MultipartFile.fromPath(
  //       'driving_licence_photo', imageFile?.path ?? ''));
  //   print(
  //       " thos sonsafsdfds=>${Urls.baseUrl}Authentication/deliveryBoyRegistration}");
  //   print('Data is-------${request.fields}');
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   print(" mthis is  Re=---=>${response.statusCode}");
  //   if (response.statusCode == 200) {
  //     final str = await response.stream.bytesToString();
  //     var finalData = json.decode(str);
  //     print('this is a reso========>${finalData}');
  //     Fluttertoast.showToast(msg: "${finalData['message']}");
  //
  //     setState(() {
  //       nameController.clear();
  //       emailController.clear();
  //       mobController.clear();
  //       passController.clear();
  //       VhicleController.clear();
  //       VhicletypeController.clear();
  //       LicenceController.clear();
  //       aadharController.clear();
  //     });
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }



  String? stateId;
  GetCityList? getCityList;
  GetStatusModel? getStatusModel;
  getStateApi() async {
    var headers = {
      'Cookie': 'ci_session=72caa85cedaa1a0d8ccc629445189f73af6a9946'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/api_get_state'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult =  GetStatusModel.fromJson(json.decode(result));
      setState(() {
        getStatusModel =  finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }



  String? cityId;
  GetStateList? getStateList;
  GetCityModel? getCityModel;
  getCityApi( String stateId) async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=c59791396657a1155df9f32cc7d7b547a40d648c'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/api_get_city'));
    request.fields.addAll({
      'state_id':stateId.toString()
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult =  GetCityModel.fromJson(json.decode(result));
      setState(() {
        getCityModel = finalResult;
      });
      setState(() {
       // Fluttertoast.showToast(msg: "${finalResult['message']}");
      });
    }
    else {
      setState(() {
        setState(() {
          isLoading = false;
        });
      });
      print(response.reasonPhrase);
    }

  }

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  _getFromGallery() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _getFromCamera();
                },
                //return false when click on "NO"
                child: const Text('Camera'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  _getFromGallery();
                  // Navigator.pop(context,true);
                  // Navigator.pop(context,true);
                },
                //return true when click on "Yes"
                child: const Text('Gallery'),
              ),
            ],
          )),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

  Position? location;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStateApi();
    //inIt();
  }
  bool isVisible = false;
  bool isVisible1 = false;
  bool isTerm = false;
  int  selected =  0;
  int _value = 0;
  bool isNonAvailable = false;
  bool isAvailable = false;
  inIt() async {
    //location = await getUserCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                //  padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                //decoration: const BoxDecoration(color: primaryColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated(context, "Sign Up"),
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Text(
                              getTranslated(context, "GET_HELP"),
                              style:
                              TextStyle(color: primaryColor, fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     Text(
                        getTranslated(context, "Welcome to PickPort"),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                padding:  const EdgeInsets.symmetric(horizontal: 15,),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: backGround,
                  borderRadius:  const BorderRadius.only(
                      topRight: Radius.circular(50)),
                ),
                child: ListView(
                  shrinkWrap: true,
                 // physics: NeverScrollableScrollPhysics(),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.TransparentColor),
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          decoration:  InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Icon(
                                Icons.person,
                                color: CustomColors.accentColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(top: 20, left: 5),
                            border: InputBorder.none,
                            hintText: getTranslated(context, "Name"),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Name is required";
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.TransparentColor),
                        child: TextFormField(
                          maxLength: 10,
                          controller: mobController,
                          keyboardType: TextInputType.phone,
                          decoration:  InputDecoration(
                            counterText: "",
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Icon(
                                Icons.call,
                                color: CustomColors.accentColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(top: 18, left: 5),
                            border: InputBorder.none,
                            hintText: getTranslated(context, "ENTER_MOBILE"),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Mobile Number is required";
                            }
                            if (v.length != 10) {
                              return "Mobile Number must be of 10 digit";
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.TransparentColor),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration:  InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Icon(
                                Icons.email,
                                color: CustomColors.accentColor,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(top: 18, left: 5),
                            border: InputBorder.none,
                            hintText: getTranslated(context, "Entre_Email"),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Email id is required";
                            }
                            if (!v.contains("@")) {
                              return "Enter Valid Email Id";
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      elevation: 1,
                      child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColors.TransparentColor),
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 13),
                                    child: Icon(Icons.location_city,color: CustomColors.accentColor,size: 28,),
                                  )),
                              Expanded(
                                flex: 10,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<GetCityList>(
                                    isExpanded: true,
                                    hint:  Text(getTranslated(context, "State"),
                                      style: const TextStyle(
                                          color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 18

                                      ),),
                                    value: getCityList,

                                    // icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:Secondry,size: 25,),
                                    style:   TextStyle(color: Secondry,fontWeight: FontWeight.bold),
                                    underline: Padding(
                                      padding: const EdgeInsets.only(left: 0,top: 4),
                                      child: Container(

                                        // height: 2,
                                        color:whiteColor,
                                      ),
                                    ),
                                    onChanged: (GetCityList? value) {
                                      setState(() {
                                        getCityList = value!;
                                        stateId =  getCityList?.stateId;
                                        getCityApi(stateId!);
                                        //animalCountApi(animalCat!.id);
                                      });
                                    },
                                    items: getStatusModel?.data?.map((items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child:  Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2),
                                              child: Container(

                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 0),
                                                    child: Text(items.stateName.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:Colors.black),),
                                                  )),
                                            ),

                                          ],
                                        ),
                                      );
                                    })
                                        .toList(),
                                  ),

                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      elevation: 1,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.TransparentColor),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 13),
                                  child: Icon(Icons.location_city,color: CustomColors.accentColor,size: 28,),
                                )),
                            Expanded(
                              flex: 10,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<GetStateList>(
                                  isExpanded: true,
                                  hint:  Text(getTranslated(context, "City"),
                                    style:  const TextStyle(
                                      color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 18
                                    ),),
                                  value: getStateList,

                                  // icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:Secondry,size: 25,),
                                  style:   TextStyle(color: Secondry,fontWeight: FontWeight.bold),
                                  underline: Padding(
                                    padding: const EdgeInsets.only(left: 0,top: 4),
                                    child: Container(

                                      // height: 2,
                                      color:whiteColor,
                                    ),
                                  ),
                                  onChanged: (GetStateList? value) {
                                    setState(() {
                                      getStateList = value!;
                                      cityId =  getStateList?.cityId;
                                      //animalCountApi(animalCat!.id);
                                    });
                                  },
                                  items: getCityModel?.data?.map((items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Container(

                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child: Text(items.cityName.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:Colors.black),),
                                                )),
                                          ),

                                        ],
                                      ),
                                    );
                                  })
                                      .toList(),
                                ),

                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.TransparentColor),
                        child: TextFormField(
                         obscureText: isVisible ? false : true,
                          controller: passController,

                          decoration: InputDecoration(

                            contentPadding:
                            EdgeInsets.only(top: 8),
                            border:  OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: getTranslated(
                                context, "Password"),
                            prefixIcon: Image.asset(
                              'assets/AuthAssets/Icon ionic-ios-lock.png',
                              scale: 1.3,
                              color: Secondry,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible ? isVisible = false : isVisible = true;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                color: Colors.green,
                              ),
                            ),

                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Password is required";
                            }
                          },

                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.TransparentColor),
                        child: TextFormField(
                          controller: cPassController,
                          obscureText: isVisible1 ? false : true,

                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.only(top: 8),
                            border:  OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: getTranslated(
                                context, "confirmPassword"),
                            prefixIcon: Image.asset(
                              'assets/AuthAssets/Icon ionic-ios-lock.png',
                              scale: 1.3,
                              color: Secondry,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible1 ? isVisible1 = false : isVisible1 = true;
                                });
                              },
                              icon: Icon(
                                isVisible1
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                color: Colors.green,
                              ),
                            ),

                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            } else if (value != passController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },

                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: CustomColors.TransparentColor),
                        child: TextFormField(
                          controller: referalController,
                          decoration:  InputDecoration(
                            prefixIcon:  Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Image.asset("assets/refercode.png",height: 90,)
                            ),
                            contentPadding: const EdgeInsets.only(top: 22, left: 5),
                            border: InputBorder.none,
                            hintText: getTranslated(context, "Referral Code (Optional"),
                          ),

                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(getTranslated(context, "GST Number (Optional)")),
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
                              _value = value!;
                              isAvailable = false;
                            });
                          },
                        ),
                        Text(
                          getTranslated(context, "Non Available Available"),
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Radio(
                            value: 1,
                            fillColor: MaterialStateColor.resolveWith(
                                    (states) => Secondry),
                            activeColor: Secondry,
                            groupValue: _value,
                            onChanged: (int? value) {
                              setState(() {
                                _value = value!;
                                isAvailable = true;
                              });
                            }),
                        // SizedBox(width: 10.0,),
                        Text(
                          getTranslated(context, "Available"),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),

                    isAvailable == true ?  Row(
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.TransparentColor),
                              child: TextFormField(
                                maxLength: 15,
                                controller: gstController,
                                validator: (value) {
                                  if (value != gstAddressController.text.isEmpty /*&& gstController.text.isEmpty*/ ) {
                                    return 'Please GST Number';
                                  }
                                  // else if (gstController.text.length <15) {
                                  //   return 'Please enter 15 digit';
                                  // }
                                  return null;
                                },
                                decoration:  InputDecoration(
                                    counterText: "",
                                  contentPadding: const EdgeInsets.only(top: 20, left: 8),
                                  border: InputBorder.none,
                                  hintText: getTranslated(context, "GST Number"),
                                ),

                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.TransparentColor),
                              child: TextFormField(
                                controller: gstAddressController,
                                keyboardType: TextInputType.name,
                                decoration:  InputDecoration(

                                  contentPadding: const EdgeInsets.only(top: 20, left: 5),
                                  border: InputBorder.none,
                                  hintText: getTranslated(context, "GST Address"),
                                ),
                                validator: (value) {
                                  if (value != gstController.text && gstAddressController.text.isEmpty) {
                                    return 'Please Enter GST Address';
                                  }
                                  return null;
                                },

                              ),
                            ),
                          ),
                        ),
                      ],
                    ):SizedBox.shrink(),
                    selected == 0
                        ? Container(
                      child: Row(children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isTerm = !isTerm;
                            });
                          },
                          child: Icon(
                            isTerm
                                ? Icons.check_box_outlined
                                : Icons.check_box_outline_blank,
                            color: Secondry,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'I agree to all ',
                          style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditionScreen()));
                          },
                          child: Text(
                            getTranslated(context, "Terms and Conditions"),
                            style:TextStyle(fontSize:11,fontWeight: FontWeight.bold, color: primaryColor,),
                          ),
                        ),
                        const SizedBox(width: 2,),
                        const Text(
                          '&',
                          style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),
                        ),

                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyScreen()));
                          },
                          child: Text(
                            getTranslated(context, "Privacy Policy"),
                            style: TextStyle(fontSize:11,fontWeight:FontWeight.bold, color:primaryColor,),
                          ),
                        ),
                      ]),
                    )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (){
                       //  if(_formKey.currentState!.validate()){
                       //
                       //  }else if(stateId == null || cityId == null){
                       //    Fluttertoast.showToast(msg: "please select state and city");
                       //  }else if(isTerm == null ){
                       //    Fluttertoast.showToast(msg: "please select i agree");
                       //  }else{
                       //    Fluttertoast.showToast(msg: "All Field is ");
                       //
                       //  }
                       // // Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyStatefulWidget()));
                      // if(nameController.text== "" ){
                      //   Fluttertoast.showToast(msg: "Name is required");
                      //   return;
                      // }if(mobController.text == ""){
                      //   Fluttertoast.showToast(msg: "Mobile is required");
                      //     return;
                      // }if(mobController.text.length<10){
                      //   Fluttertoast.showToast(msg: "Please Enter 10 Digit Mobile Number");
                      //   return;
                      // }
                      // if(emailController.text == ""){
                      //   Fluttertoast.showToast(msg: "Email is required");
                      //      return;
                      // }if(passController.text== "" ){
                      //   Fluttertoast.showToast(msg: "Password is required");
                      //   return;
                      // }if(cPassController.text== "" ){
                      //   Fluttertoast.showToast(msg: "Confirm Pass is required");
                      //   return;
                      // }
                        if(_formKey.currentState!.validate()){
                          if(stateId == null || cityId == null){
                            Fluttertoast.showToast(msg: "State & City is required");
                            return;
                          }
                          if(isTerm == false){
                            Fluttertoast.showToast(msg: " Please agree to all T&C and Privacy Policy");
                            // return;
                          }
                          else{
                            signUpApi();
                          }

                        }

                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child:  Center(
                            child: Text(getTranslated(context, "Sign Up"),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(getTranslated(context, "Already have an accounting"),style: const TextStyle(
                           fontSize: 12,fontWeight: FontWeight.bold
                         ),),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignInScreen()));
                            },
                            child: Text(
                              getTranslated(context, "LOGIN"),
                              style: TextStyle(color: Secondry,fontSize: 14,fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MediaQuery.of(context).viewInsets.bottom !=0 ? SizedBox(height: 200,) : const SizedBox()
                  ],
                ),
              ),
            ),

          ],
        )
      ),
    );
  }




}
