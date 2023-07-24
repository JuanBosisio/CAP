
import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding:  EdgeInsets.all(currentWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap: (){},
              child: Text(
                  'Saltar',
                  style: TextStyle(
                    fontSize: currentWidth * 1.4,
                    fontWeight: FontWeight.w600,
                  )
              )
          )
        ],
      ),
    );
  }
}