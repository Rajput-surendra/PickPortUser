import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_dekho_app/Jdx_screens/Dashbord.dart';
import 'package:job_dekho_app/Jdx_screens/MyProfile.dart';
import 'package:job_dekho_app/Jdx_screens/PickPort/SupportNewScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Helper/PickModel/get_city_model.dart';
import '../Helper/PickModel/get_status_model.dart';
import '../Helper/session.dart';
import '../Model/getprofilemodel.dart';
import '../Model/updateprofilemodel.dart';
import '../Utils/api_path.dart';
import '../Utils/color.dart';

class UserProfile extends StatefulWidget {
  Getprofilemodel? getprofile;

  UserProfile({this.id, this.getprofile});

  final String? id;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController gstaddressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imagefilecontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addreessController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  String genders = "";
  Updateprofilemodel? update;

  var gaurdianData;

  updateProfile() async {
    setState(() {
      isLoading =  true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userid = preferences.getString('userid');
    print('This is user id===============>${userid}');
    var headers = {
      'Cookie': 'ci_session=9aba5e78ffa799cbe054723c796d2bd8f2f7d120'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('${ApiPath.baseUrl}User_Dashboard/updateUserProfile'));
    request.fields.addAll({
      'name': '${nameController.text}',
      'email': '${emailController.text}',
      'mobile': '${mobileController.text}',
      'city_id':cityidstring.cityId.toString(),
      'state_id':stateidstring.stateId.toString(),
      'gst_number':gstController.text,
      'gst_address':gstaddressController.text,
      'user_id': userid.toString()
    });
      print('____Som______${request.fields}_________');

    request.headers.addAll(headers);
   if(imageFile != null){
     request.files.add(await http.MultipartFile.fromPath('user_image', imageFile?.path ?? ''));
   }

    http.StreamedResponse response = await request.send();
    setState(() {
      isLoading =  false;
    });
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      var userprofile = Updateprofilemodel.fromJson(jsonDecode(finalResponse));
      setState(() {
        update = userprofile;
      });

      Get.to(const MyStatefulWidget());
      Fluttertoast.showToast(msg: 'Profile Update Successfully');
      setState(() {
        isLoading =  false;
      });
    } else {
      setState(() {
        isLoading =  false;
      });
      Fluttertoast.showToast(msg: '${update?.message ?? ''}');
      print(response.reasonPhrase);
    }
  }

  var Getuserprofile;

  var filesPath;
  String? fileName;

  // void _pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  //   if (result == null) return;
  //   setState(() {
  //     filesPath = result.files.first.path ?? "";
  //     fileName = result.files.first.name;
  //     // reportList.add(result.files.first.path.toString());
  //     resumeData = null;
  //   });
  //   var snackBar = SnackBar(
  //     backgroundColor: primaryColor,
  //     content: Text('Profile upload successfully',style: TextStyle(fontFamily: 'Lora'),),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStateApi();

    emailController = TextEditingController(
        text: widget.getprofile?.data?[0].userEmail.toString());
    nameController = TextEditingController(
        text: widget.getprofile?.data?[0].userFullname.toString());
    mobileController = TextEditingController(text: widget.getprofile?.data?[0].userPhone.toString());
    gstController = TextEditingController(text: widget.getprofile?.data?[0].gstNumber.toString());
    gstaddressController = TextEditingController(text: widget.getprofile?.data?[0].gstAddress.toString());

    print('____mobileController______${widget.getprofile?.data?[0].cityName}_________');
    // stateidstring = getStatusModel?.data?.firstWhere((item) {
    //   print("${item.stateName}"+"___________________");
    //   if(item.stateName == widget.getprofile?.data?[0].stateName){
    //
    //     return true;
    //   }
    //   else{
    //     return false;
    //   }
    // });
    print('____Som______${stateidstring}_________');


  }
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  var profileImage;
  _getFromGallery() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        print('${imageFile}gggggg');
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {

    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);

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
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: const Text(
                  'No',
                  style: TextStyle(fontFamily: 'Lora'),
                ),
              ),
              ElevatedButton(
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: primaryColor,

        body:  Form(
          key: _formKey,
          child: Column(
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
                          child: const Center(child: Icon(Icons.arrow_back)),
                        ),
                      ),
                      Text(getTranslated(context, "My Profile"),style: TextStyle(color: whiteColor,fontSize: 18),),
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
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(50),)
                    ),
                    child:
                    SingleChildScrollView(
                        child:
                        // seekerProfileModel == null  || addJobDataModel == null  ? Center(child: CircularProgressIndicator(),) :
                        Column(

                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 250,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10))),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("    Take Image From",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            ListTile(
                                              leading: Image.asset(
                                                'assets/ProfileAssets/cameraicon.png',
                                                scale: 1.5,
                                              ),
                                              title: const Text('Camera',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold)),
                                              onTap: () {
                                                _getFromCamera();
                                              },
                                            ),
                                            ListTile(
                                              leading: Image.asset(
                                                'assets/ProfileAssets/galleryicon.png',
                                                scale: 1.5,
                                              ),
                                              title: const Text('Gallery',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold)),
                                              onTap: () {
                                                _getFromGallery();
                                              },
                                            ),
                                            ListTile(
                                              leading: Image.asset(
                                                'assets/ProfileAssets/cancelicon.png',
                                                scale: 1.5,
                                              ),
                                              title: const Text('Cancel',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold)),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    imageFile == null
                                        ? Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: whiteColor),
                                      child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(100),
                                          child: Image.network(
                                            "${widget.getprofile?.data?.first.userImage}",
                                            fit: BoxFit.fill,
                                          )),
                                    )
                                        :  Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: whiteColor),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        child: Image.file(
                                          imageFile ?? File(''),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      right: 10,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: Image.asset(
                                          'assets/ProfileAssets/camera_Icon.png',
                                          scale: 1.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
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
                                      readOnly: true,
                                      controller: mobileController,
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
                                                child: Icon(
                                                  Icons.location_city,
                                                  color: CustomColors.accentColor,
                                                ),
                                              )),
                                          Expanded(
                                            flex: 10,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<dynamic>(
                                                isExpanded: true,
                                                //hint:  Text(getTranslated(context, "State"),
                                                hint: const Text(
                                                  "State",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                                value: stateidstring,

                                                // icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:Secondry,size: 25,),
                                                style:  TextStyle(
                                                    color: Secondry,
                                                    fontWeight: FontWeight.bold),
                                                underline: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 0, top: 4),
                                                  child: Container(
                                                    // height: 2,
                                                    color: whiteColor,
                                                  ),
                                                ),
                                                onChanged: ( value) {
                                                  setState(() {
                                                    stateidstring = value!;
                                                    //  stateId = getCityList?.stateId;
                                                    getCityApi(value.stateId!);
                                                    //animalCountApi(animalCat!.id);
                                                  });
                                                },
                                                items: getStatusModel?.data?.map((items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              top: 2),
                                                          child: Container(
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets.only(
                                                                    top: 0),
                                                                child: Text(
                                                                  items.stateName.toString(),
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                      color: Colors.black54),
                                                                ),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
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
                                                child: Icon(Icons.location_city,color: CustomColors.accentColor,),
                                              )),
                                          Expanded(
                                            flex: 10,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton2<dynamic>(
                                                isExpanded: true,
                                                hint:  Text(getTranslated(context, "City"),
                                                  style:  const TextStyle(
                                                      color: Colors.black54,fontSize: 18
                                                  ),),
                                                value: cityidstring,

                                                // icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:Secondry,size: 25,),
                                                style:   TextStyle(color: Secondry,fontWeight: FontWeight.bold),
                                                underline: Padding(
                                                  padding: const EdgeInsets.only(left: 0,top: 4),
                                                  child: Container(

                                                    // height: 2,
                                                    color:whiteColor,
                                                  ),
                                                ),
                                                onChanged: ( value) {
                                                  setState(() {
                                                    cityidstring = value!;
                                                    //cityId =  getStateList?.cityId;
                                                    //animalCountApi(animalCat!.id);
                                                  });
                                                },
                                                items: getCityModel?.data?.map((items) {
                                                  return DropdownMenuItem<dynamic>(
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
                                                                child: Text(items.cityName.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:Colors.black54),),
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
                                      keyboardType: TextInputType.name,
                                      decoration:  InputDecoration(
                                        counterText: "",
                                        prefixIcon:  Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Image.asset("assets/gstNo.png",scale: 1.2,)
                                        ),
                                        contentPadding: const EdgeInsets.only(top: 20, left: 5),
                                        border: InputBorder.none,
                                       hintText: getTranslated(context, "GST Number"),

                                      ),
                                      validator: (value) {
                                        print('____Som______${value}_________');
                                        if (gstController.text.isNotEmpty||gstaddressController.text.isNotEmpty) {
                                          if (gstController.text.isEmpty) {
                                            return 'Please GST Number';
                                          }
                                          // else if (gstController.text.length <15) {
                                          //   return 'Please enter 15 digit';
                                          // }
                                          return null;
                                        }
                                        return null;

                                      }
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
                                      controller: gstaddressController,
                                      keyboardType: TextInputType.name,
                                      decoration:  InputDecoration(
                                        prefixIcon:  Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Image.asset("assets/gstlo.png",scale: 1.2,)
                                        ),
                                        contentPadding: const EdgeInsets.only(top: 20, left: 5),
                                        border: InputBorder.none,
                                       hintText: getTranslated(context, "GST Address"),
                                      ),
                                        validator: (value) {
                                          if (gstController.text.isNotEmpty || gstaddressController.text.isNotEmpty) {
                                            if (gstaddressController.text.isEmpty) {
                                              return 'Please Enter GST Address';
                                            }
                                            return null;
                                          }
                                          return null;
                                        }

                                    ),

                                  ),
                                ),

                              ],
                            ),
                          ),

                            const SizedBox(
                              height: 30,
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: InkWell(
                                onTap: (){
                                  if(_formKey.currentState!.validate()){
                                    updateProfile();

                                  }
                                  else {
                                    Fluttertoast.showToast(msg: "Gst is required");
                                  }
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyStatefulWidget()));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(15)),
                                    height: 55,
                                    width: MediaQuery.of(context).size.width,
                                    child:  Center(
                                      child: Text(getTranslated(context, "Save"),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // InkWell(
                            //   onTap: () {
                            //
                            //
                            //   },
                            //   child: Container(
                            //     height: 50,
                            //     width: MediaQuery.of(context).size.width / 1.4,
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(30),
                            //         color: Secondry),
                            //     child: Text(getTranslated(context, "Edit And Save"),
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //         fontWeight: FontWeight.bold,
                            //         fontSize: 14,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ))

                ),
              )

            ],
          ),
        ),



    );
  }
bool isLoading =  false;
  String? stateId;
  GetCityList? getCityList;
  GetStatusModel? getStatusModel;

  dynamic stateidstring;
  dynamic cityidstring;
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
        stateId =  widget.getprofile?.data?[0].userState.toString();
        stateidstring = getStatusModel?.data?.firstWhere((item) {
          if(item.stateName == widget.getprofile?.data?[0].stateName){
            getCityApi(item.stateId!);
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



  String? cityId;
  GetStateList? getStateList;
  GetCityModel? getCityModel;
  getCityApi(String stateId) async {
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
  print('____Som___dddd___${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult =  GetCityModel.fromJson(json.decode(result));
      setState(() {
        getCityModel = finalResult;
      });
      cityidstring = getCityModel ?.data?.firstWhere((item) {
        if(item.cityName == widget.getprofile?.data?[0].cityName){
          print("${item.cityName}"+"________fffff___________");
          print("${widget.getprofile?.data?[0].cityName}"+"________fffff___________");
          return true;
        }
        else{
          return false;
        }
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
}
