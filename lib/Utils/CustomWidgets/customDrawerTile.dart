import 'package:flutter/material.dart';
import 'package:job_dekho_app/Utils/color.dart';

class CustomDrawerTile extends StatelessWidget {
  final String tileName;
  final Widget tileIcon;
  final VoidCallback? onTap;
  const CustomDrawerTile({Key? key, required this.tileName, required this.tileIcon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: Card(
          shape: RoundedRectangleBorder(
            
            borderRadius: BorderRadius.circular(10)
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    tileIcon,
                    SizedBox(width: 15,),
                    Text(tileName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'Lora' ),)
                  ],
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                      color: backGround,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Image.asset('assets/DrawerAssets/forwardIcon.png', scale: 1.3,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
