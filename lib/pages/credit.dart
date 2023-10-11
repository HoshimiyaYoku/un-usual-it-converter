import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Credit extends StatelessWidget {
  const Credit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("クレジット"),
          backgroundColor: Color.fromARGB(255, 238, 144, 2)),
      backgroundColor: Color.fromARGB(255, 238, 144, 2),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Team 五門斉',
            style: GoogleFonts.notoSerif(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Text(
            '長沼 篤典',
            style: GoogleFonts.notoSerif(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            '堀越 涼太',
            style: GoogleFonts.notoSerif(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            'チン テンニン',
            style: GoogleFonts.notoSerif(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            'セン シメイ',
            style: GoogleFonts.notoSerif(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            '井田 舜悟',
            style: GoogleFonts.notoSerif(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ]),
      ),
    );
  }
}
