
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SizedText extends StatelessWidget {
  final String text;
  final Color color;

  const SizedText({Key? key, required this.text, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size textSize = _textSize(text);
    return Container(
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: color,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              for(int i=0; i<textSize.width/5;i++)
                i.isEven?Container(
                  width: 5,
                  color: color,
                  height: 2,
                ):Container(
                  width: 5,
                  color: Colors.white,
                  height: 2,
                )
            ],
          )
        ],
      ),
    );
  }


  Size _textSize(String text){
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: 15,
            color: color,
            fontWeight: FontWeight.w700,
          )
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }

}
