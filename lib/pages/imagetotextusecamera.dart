import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unitconverter/components/globals.dart';

class ImageToTextUseCamera extends StatefulWidget {
  const ImageToTextUseCamera({Key? key}) : super(key: key);

  @override
  State<ImageToTextUseCamera> createState() => _ImageToTextState();
}

class _ImageToTextState extends State<ImageToTextUseCamera> {
  File? _pickedImage;
  String outputText = "";
  List<Offset> textPositions = [];
  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
        outputText = ""; // Clear previous output
        textPositions.clear();
      });

      final inputImage = InputImage.fromFile(_pickedImage!);
      _processImageForConversion(inputImage);
    }
  }

  Future<void> _processImageForConversion(InputImage inputImage) async {
    try {
      final textRecognizer =
      TextRecognizer(script: TextRecognitionScript.japanese);
      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);
      textList.clear();
      cornerPointsList.clear();
      for (TextBlock block in recognizedText.blocks) {
        for (TextLine line in block.lines) {
          print(line.text);
          print(line.cornerPoints);
          double centerX = (line.cornerPoints[0].x + line.cornerPoints[2].x) / 2;
          double centerY = (line.cornerPoints[0].y + line.cornerPoints[2].y) / 2;
          textPositions.add(Offset(centerX, centerY));
          textList.add(line.text);
          cornerPointsList.add(line.cornerPoints);
          print(line.cornerPoints[0].x);
          print(line.cornerPoints[0].y);
          setState(() {
            outputText += line.text + "\n";
          });
        }
      }
    } catch (e) {
      print("Image Read Error!：$e");
    }
  }

  List<String> _extractNumbersAndUnits(String input) {
    List<String> results = [];
    RegExp regExp = RegExp(r"(\d+(\.\d+)?)\s*([^0-9\s]+)");

    Iterable<Match> matches = regExp.allMatches(input);

    for (Match match in matches) {
      results.add(match.group(1)!); // Add matched number
      results.add(match.group(3)!); // Add matched unit
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    List<String> numbersAndUnits = _extractNumbersAndUnits(outputText);

    return Scaffold(
      appBar: AppBar(title: Text("Image to Text")),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: Icon(Icons.photo_camera),
      ),
      body: Column(
        children: [
          if (_pickedImage == null)
            Container(
              height: 300,
              color: Colors.black,
              width: double.infinity,
            )
          else
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.file(
                    _pickedImage!,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(child: Container()),
                for (var i = 0; i < textList.length; i++)
                  Positioned(
                    left: textPositions[i].dx, // X座標
                    top: textPositions[i].dy, // Y座標

                    child: Text(
                      textList[i],
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                  ),
                Expanded(child: Container()),
              ],
            ),
        ],
      ),
    );
  }
}
