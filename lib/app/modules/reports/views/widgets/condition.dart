import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConditionItem extends StatelessWidget {
  const ConditionItem({
    super.key,
    required this.title,
    required this.value,
    required this.endValue,
    required this.imagePath,
    required this.color,
  });

  final String title;
  final String value;
  final String endValue;
  final String imagePath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(imagePath),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 90,
                child: Text(
                  overflow: TextOverflow.fade,
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Row(
                children: [
                  Text(
                    value == '0%' ? '-' : value,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 70,
                    child: Text(
                      endValue == '' ? 'Kosong' : endValue,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
