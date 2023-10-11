import 'data.dart';
import 'package:unitconverter/pages/testcamera.dart';

String conversion(String beforenumber, String beforeunit, String afterunit) {

  double? number = double.tryParse(beforenumber);
  if (number == null) {
    print('number error');
    return 'error';
  }

  Map<String, DoublePair>? unitMap = conversionData[beforeunit];
  if (unitMap == null || !unitMap.containsKey(afterunit)) {
    print('unit error');
    return 'error';
  }

  DoublePair value = unitMap[afterunit]!;
  double result = number * value.doubleValue;
  afterunit = value.stringValue;

  int digit = 5;
  String formattedResult = result.toStringAsExponential(digit);
  int index = int.parse(formattedResult.substring(formattedResult.indexOf('e')+2, formattedResult.length));

  if((formattedResult.contains('e-') && index > 3) || (formattedResult.contains('e+') && index > digit)){
    int point = formattedResult.indexOf('.');
    while(true){
      if((formattedResult.contains('.') && formattedResult[point+digit] == '0') || (formattedResult[point+digit] == '.')){
        formattedResult = formattedResult.substring(0, point+digit) + formattedResult.substring(point+digit+1);
        digit--;
        continue;
      }
      break;
    }
  }else{
    if(formattedResult.contains('e-')){
      formattedResult = result.toStringAsFixed(digit+index);
    }else{
      formattedResult = result.toStringAsFixed(digit-index);
    }

    while (formattedResult.endsWith('0') && formattedResult.contains('.')) {
      formattedResult = formattedResult.substring(0, formattedResult.length - 1);
    }   

    if (formattedResult.endsWith('.')) {
      formattedResult = formattedResult.substring(0, formattedResult.length - 1);
    }
  }

  return '$formattedResult $afterunit';
    
  }