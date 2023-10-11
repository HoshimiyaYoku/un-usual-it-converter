import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unitconverter/components/conversion.dart'; // 导入单位转换的相关代码
import 'package:unitconverter/components/data.dart';
import 'package:unitconverter/components/globals.dart';


class ImageToTextTest extends StatefulWidget {
  const ImageToTextTest({Key? key}) : super(key: key);

  @override
  State<ImageToTextTest> createState() => _ImageToTextStateTest();
}

class _ImageToTextStateTest extends State<ImageToTextTest> {
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
          //print('単位');
          print(line.text);
          //print('座標');
          //print(line.cornerPoints);
          double centerX = (line.cornerPoints[0].x + line.cornerPoints[2].x) / 2;
          double centerY = (line.cornerPoints[0].y + line.cornerPoints[2].y) / 2;
          textPositions.add(Offset(centerX, centerY));
          textList.add(line.text);
          cornerPointsList.add(line.cornerPoints);
          //print(line.cornerPoints[0].x);
          //print(line.cornerPoints[0].y);
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
      appBar: AppBar(
        title: Text("カメラから変換"),
        backgroundColor: Color.fromARGB(255, 238, 144, 2),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: Icon(Icons.photo_camera),
        backgroundColor: Color.fromARGB(255, 8, 117, 90),
      ),
      body: Column(
        children: [
          if (_pickedImage == null)
            Container(
              height: 300,
              color: Color.fromARGB(255, 255, 240, 210),
              width: double.infinity,
            )
          else
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.file(
                _pickedImage!,
                fit: BoxFit.fill,
              ),
            ),
/*          Column(
            children: numbersAndUnits.map((item) {
              return Text(
                item,
                style: TextStyle(fontSize: 18),
              );
            }).toList(),
          ),
          Expanded(child: Container()),
*/
          Expanded(
            child: ListView.builder(
            itemCount: numbersAndUnits.length ~/ 2,
            itemBuilder: (context, index) {
              String inputnumber = numbersAndUnits[index * 2];
              String inputunit = numbersAndUnits[index * 2 + 1];
              return TextConversion(inputnumber: inputnumber, inputunit: inputunit);
            },
            ),
          )
        ]
      ),
    );
  }
}

class DoublePair {
  final double doubleValue;
  final String stringValue;

  DoublePair(this.doubleValue, this.stringValue);
}

class TextConversion extends StatefulWidget {
  final String inputnumber;
  final String inputunit;

  const TextConversion({Key? key, required this.inputnumber, required this.inputunit}) : super(key: key);

  @override
  State<TextConversion> createState() => _TextConversionState();
}

class _TextConversionState extends State<TextConversion> {
  late Map<String, DoublePair>? itemsMap;
  late String outputunit;
  late String selectedItem;


  @override
  void initState() {
    super.initState();
    itemsMap = conversionData[widget.inputunit]?.cast<String, DoublePair>();
    if (itemsMap != null) {
      selectedItem = itemsMap!.keys.first;
      outputunit = selectedItem;
    } else {
      // 处理无效单位的情况
      selectedItem = "Unit";
      outputunit = selectedItem;
    }
  }

  /*@override
  void didUpdateWidget(TextConversion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.numbersAndUnits != widget.numbersAndUnits) {
      _updateInputValues();
    }
  }*/

  /*void _updateInputValues() {
    if (widget.numbersAndUnits.isNotEmpty) {
      inputnumber = widget.numbersAndUnits[0];
      inputunit = widget.numbersAndUnits[1];
    } else {
      // Set default values if numbersAndUnits is empty
      inputnumber = "0";
      inputunit = "cm"; // Set a default unit here
    }

    itemsMap = conversionData[inputunit]?.cast<String, DoublePair>();
    outputunit = itemsMap!.keys.first;
    selectedItem = itemsMap!.keys.first;
  }*/

   @override
  Widget build(BuildContext context) {
    String outputtext = conversion(widget.inputnumber, widget.inputunit, outputunit);

    final List<String> items = itemsMap?.keys.toList() ?? [];

    return Column(
      children: [
        DropdownButton(
          value: selectedItem,
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedItem = newValue;
                outputunit = newValue;
              });
            }
          },
          items: items.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit),
            );
          }).toList(),
        ),
        Text(
          widget.inputnumber + widget.inputunit,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        Text(
          outputtext,
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        Divider(),
      ],
    );
  }
}