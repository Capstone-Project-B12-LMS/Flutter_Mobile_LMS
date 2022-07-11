import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'hexcolor_widget.dart';

Widget loadingInScreen() {
  Color secColor = HexColor('#415A80');
  Color thColor = HexColor('#9EC9E2');
  return Center(
    child: SizedBox(
      width: 50,
      child: LoadingIndicator(
          indicatorType: Indicator.ballPulse,
          colors: [secColor, thColor, secColor],
          strokeWidth: 2,
          backgroundColor: Colors.transparent,
          pathBackgroundColor: Colors.transparent),
    ),
  );
}


