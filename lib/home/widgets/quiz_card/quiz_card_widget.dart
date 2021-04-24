import 'package:flutter/material.dart';

import 'package:quiztholic/core/core.dart';
import 'package:quiztholic/shared/progress_indicator/progress_indicator_widget.dart';

class QuizCardWidget extends StatelessWidget {
  final String title;
  final String image;
  final String completed;
  final double percent;
  final VoidCallback onTap;
  const QuizCardWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.completed,
    required this.percent,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(color: AppColors.border),
          ),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              child: Image.asset(image),
            ),
            Text(
              title,
              style: AppTextStyles.heading15,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(completed, style: AppTextStyles.body11),
                ),
                Expanded(
                  flex: 7,
                  child: ProgressIndicatorWidget(value: percent),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
