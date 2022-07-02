import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'hexcolor_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color secColor = HexColor('#415A80');
    Color thColor = HexColor('#9EC9E2');
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: LoadingIndicator(
              indicatorType: Indicator.ballPulse,
              colors: [secColor, thColor, secColor],
              strokeWidth: 2,
              backgroundColor: Colors.transparent,
              pathBackgroundColor: Colors.transparent),
        ),
      ),
    );
  }
}
