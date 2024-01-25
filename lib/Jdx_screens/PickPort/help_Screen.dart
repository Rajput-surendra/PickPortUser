import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Model/NewContectModel.dart';
import 'package:job_dekho_app/Utils/api_path.dart';
import 'package:job_dekho_app/Utils/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../Helper/session.dart';
import '../../Model/Get_help_model.dart';




class HelpScreen extends StatefulWidget {

  const HelpScreen({Key? key}) : super(key: key);


  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  void initState() {
    // TODO: implement initState
    super.initState();
    getHelp();
  }
GetHelpModel? getHelpModel;
  // getHeplApi() async {
  //   var headers = {
  //     'Cookie': 'ci_session=e664e18a8c1eab77c4e0e1d8f3c29c616e85d57f'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/our_activities'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result  = await response.stream.bytesToString();
  //     var finalResult  = GetHelpModel.fromJson(json.decode(result));
  //     setState(() {
  //
  //       getHelpModel =  finalResult;
  //     });
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  // }
  String? emailAddress;
  String? phoneNumber;
  String? url;
  String? description;
  getOurActivityApi() async {

    // print('____Som______________');
    // var headers = {
    //   'Cookie': 'ci_session=a5bdf0fa0910366f0bff353d95b4d349cfbedafd'
    // };
    var request = http.MultipartRequest('GET', Uri.parse('${ApiPath.baseUrl}Authentication/our_activities'));
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetHelpModel.fromJson(jsonDecode(result));
      setState(() {
        getHelpModel =  finalResult;
        print('____Som______${getHelpModel!.data!.first.video}_________');
      });
      // _vController.add(VideoPlayerController.network(finalResult.data![0].video.toString())..initialize().then((value){
      //   print('____Som___ffff___${_vController}_________');
      //   setState(() {
      //   });
      // }));
      // for(var i=0;i<finalResult.data!.length;i++){
      //
      //   isPlayed.add(false);
      //   print("video controller length ${_vController.length}----------${_vController}");
      // }

    }
    else {
      print(response.reasonPhrase);
    }

  }

  NewContectModel? newContectModel;

  get() async {
    var headers = {
      'Cookie': 'ci_session=f9248f94280271245402dd0f5f7a337996575439'
    };
    var request = http.MultipartRequest('GET', Uri.parse('https://developmentalphawizz.com/pickport/api/payment/contact_setting'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalREsult  = NewContectModel.fromJson(json.decode(result));
      setState(() {
        newContectModel =  finalREsult;
        emailAddress = newContectModel?.data?.email.toString();
        phoneNumber = newContectModel?.data?.phoneNo.toString();
      });
      print('____Som______${phoneNumber}_________');
    }
    else {
      print(response.reasonPhrase);
    }

  }
  getHelp() async {
    var headers = {
      'Cookie': 'ci_session=521e7894daca5e3189ecd3dd2cd31fd3c14d22c9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}Authentication/get_user_help'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var result=jsonDecode(finalResponse);
      if(result['status']==true){

        setState(() {
          url = result['data']['url'].toString();
          description = result['data']['description'].toString();
          print('____Som______${url}_________');
        });
      }


    } else {
      print(response.reasonPhrase);
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,

            body:  Column(
              children: [
                SizedBox(height: 10,),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Expanded(child: SizedBox(
                          child: Center(child: Text(getTranslated(context, "GET_HELP"),style: TextStyle(color: whiteColor),)),
                        )),

                        // Container(
                        //   height: 40,
                        //   width: 40,
                        //   decoration:  BoxDecoration(
                        //       color: splashcolor,
                        //       borderRadius:
                        //       BorderRadius.circular(100)),
                        //   child: InkWell(
                        //       onTap: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                 const NotificationScreen()));
                        //       },
                        //       child: Center(
                        //         child: Image.asset(
                        //           'assets/ProfileAssets/support.png',scale: 1.3,
                        //         ),
                        //       )),
                        // ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: Container(
                    width: double.infinity,
                      decoration: BoxDecoration(
                          color: backGround,
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(50))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(description??""),
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: (){
                                _launchUrl(Uri.parse('$url'));
                              },
                                child: Text(url??"",style: TextStyle(color: Colors.blue),)),


                          ],
                        ),
                      ),
                )
                )
              ],
            ),

    ));
  }

  late List<VideoPlayerController> _vController = [];
  List<bool> isPlayed = [];


  getVideoList(model, int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height:MediaQuery.of(context).size.height/3,
        margin: const EdgeInsets.only(bottom: 10),
        child:
        Stack(
          alignment: Alignment.center,
          children: [
            Container( decoration: BoxDecoration(
              color: Secondry,
              borderRadius: BorderRadius.circular(10),
            ),
              height:MediaQuery.of(context).size.height/3,
              child: Column(
                children: [
                  Container(
                      height:MediaQuery.of(context).size.height/3.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AspectRatio(aspectRatio: _vController[0].value.aspectRatio,child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: VideoPlayer(_vController[0])),)),
                  const SizedBox(height: 10,),

                ],
              ),
            ),
            Positioned(
                left: 1,right: 1,
                top: -10,
                bottom: 1,
                //alignment: Alignment.center,
                child: isPlayed[0] == true ? InkWell(
                    onTap: (){
                      setState(() {
                        isPlayed[0] = false;
                        _vController[0].pause();
                      });
                    },
                    child: Icon(Icons.pause,color: Colors.white,)) : InkWell(
                    onTap: (){
                      setState(() {
                        isPlayed[0] = true;
                        _vController[0].play();
                      });
                    },
                    child: Icon(Icons.play_arrow,color: Colors.white,))),
            // VideoPlayer(_vController[index]),

          ],
        ),


        // Stack(
        //   children: [
        //     // _showThumbnail ==  true
        //     //     ? Image.network(
        //     //   'https://developmentalphawizz.com/dr_booking/uploads/media/2023/Is-Sensodyne-world’s-no-1-sensitivity-toothpaste-2_(1).jpg',
        //     //   // Replace 'thumbnail_url_here' with the actual URL of the thumbnail image
        //     //   width: double.infinity,
        //     //   height: double.infinity,
        //     //   fit: BoxFit.cover,
        //     // ):
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Container(
        //           width: MediaQuery.of(context).size.width,
        //           height: 220,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10),
        //             color: colors.secondary,
        //           ),
        //           child: Column(
        //             children: [
        //               Container(
        //                   height:180,
        //                   width: MediaQuery.of(context).size.width,
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(10),
        //                   ),
        //                   child: AspectRatio(aspectRatio: _vController[index].value.aspectRatio,child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(10),
        //                       child: VideoPlayer(_vController[index])),)),
        //              const SizedBox(height: 10,),
        //              Column(
        //                crossAxisAlignment: CrossAxisAlignment.start,
        //                children: [
        //                  Text("${getAwareNess?.data.video?[index].title}",style: const TextStyle(color: colors.whiteTemp),),
        //
        //                ],
        //              )
        //
        //             ],
        //           )),
        //     ),
        //     Positioned(
        //         left: 1,right: 1,
        //         top: 0,
        //         bottom: 1,
        //         //alignment: Alignment.center,
        //         child: isPlayed[index] == true ? InkWell(
        //             onTap: (){
        //               setState(() {
        //                 isPlayed[index] = false;
        //                 _vController[index].pause();
        //               });
        //             },
        //             child: Icon(Icons.pause,color: Colors.white,)) : InkWell(
        //             onTap: (){
        //               setState(() {
        //                 isPlayed[index] = true;
        //                 _vController[index].play();
        //               });
        //             },
        //             child: Icon(Icons.play_arrow,color: Colors.white,))),
        //
        //   ],
        // ),
      ),
    );
  }

  _launchUrl(id) async {
    if (await launchUrl(id)) {
      throw Exception('Could not launch $id');
    }
  }
}

