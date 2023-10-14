import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:unitconverter/components/side.txt';
//import 'package:unitconverter/components/botton.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  //const HomePage({super.key});
  HomePage({Key? key}) : super(key: key);

  var sidebarKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sidebarKey,
      backgroundColor: Color.fromARGB(255, 238, 144, 2),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonBar(
              children: [
                MaterialButton(
                  onPressed: () {
                    sidebarKey.currentState!.openEndDrawer();
                  },
                  elevation: 0,
                  color: Color.fromARGB(255, 238, 144, 2),
                  child: Icon(Icons.menu),
                  padding: EdgeInsets.all(16),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  //shape: CircleBorder(),
                ),
              ],
            ),
            //const SizedBox(height: 5),

            //Application title アプリのタイトル
            Text(
              'Unit Converter 単位変換',
              style: GoogleFonts.notoSerif(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),

            const SizedBox(
              height: 15,
            ),

            //icon 必要があれば
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                width: 300,
                height: 300,
//                    clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Logo.png'),
                  ),
                  border: Border.all(
                      color: Color.fromARGB(255, 219, 250, 248), width: 5),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              //child: Image.asset('assets/images/Logo.png')),
            ),

            //subtitle 紹介の文章など
            //Text('単位変換のツールです。')

            const SizedBox(height: 20),
            //button

            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    MaterialButton(
                      elevation: 7,
                      onPressed: () {
                        Navigator.pushNamed(context, '/imagetotextusecamera');
                      },
                      child: Icon(
                        Icons.photo_camera,
                      ),
                      padding: EdgeInsets.all(16),
                      color: Color.fromARGB(255, 8, 117, 90),
                      textColor: Colors.white,
                      shape: CircleBorder(),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'カメラから変換',
                      style: GoogleFonts.notoSerif(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    MaterialButton(
                      elevation: 7,
                      onPressed: () {
                        Navigator.pushNamed(context, '/imagetotexttest');
                      },
                      child: Icon(
                        Icons.image,
                      ),
                      padding: EdgeInsets.all(16),
                      color: Color.fromARGB(255, 8, 117, 90),
                      textColor: Colors.white,
                      shape: CircleBorder(),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '画像から変換',
                      style: GoogleFonts.notoSerif(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(width: 40),
            // Mybotton(
            //   text: 'アルバムから選んで変換する',
            //   //ボタンに表示するメーセージ
            //   onTap: () {
            //     //画像認識ページに移動する
            //     Navigator.pushNamed(context, '/imagetotext');
            //   },
            // ),

            // const SizedBox(height: 20),
            // //button
            // Mybotton(
            //   text: '写真を撮って変換する',
            //   //ボタンに表示するメーセージ
            //   onTap: () {
            //     //画像認識ページに移動する
            //     Navigator.pushNamed(context, '/imagetotext');
            //   },
            // ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("バージョン"),
              subtitle: const Text("v1.00"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("クレジット"),
              onTap: () {
                Navigator.pushNamed(context, '/credit');
              },
            ),
            ListTile(
              title: const Text("HACK U"),
              subtitle: const Text("https://hacku.yahoo.co.jp/dendai2023/"),
              onTap: () async {
                launchUrl(Uri.parse('https://hacku.yahoo.co.jp/dendai2023/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
