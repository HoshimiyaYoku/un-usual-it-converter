import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mybotton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const Mybotton({
    super.key,
    required this.text,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 214, 241, 255), borderRadius: BorderRadius.circular(30.0),),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text ボタンの表示メーセージ
            Text(text,
            style: GoogleFonts.notoSerif(
              color: Color.fromARGB(255, 78, 128, 255),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              ),),
    
            const SizedBox(width: 20,),
    
            Icon(Icons.arrow_forward, color: Color.fromARGB(255, 78, 128, 255),),
          ],
        ),
      ),
    );
  }
}