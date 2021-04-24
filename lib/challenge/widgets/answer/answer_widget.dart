import 'package:flutter/material.dart';

import 'package:quiztholic/core/core.dart';
import 'package:quiztholic/shared/model/answer_model.dart';

class AnswerWidget extends StatelessWidget {
  final AnswerModel answer;
  final bool isSelected;
  final bool disabled;
  final Function onTap;
  const AnswerWidget({
    Key? key,
    required this.answer,
    this.isSelected = false,
    required this.disabled,
    required this.onTap,
  }) : super(key: key);

  Color get _selectedColor =>
      answer.isRight ? AppColors.darkGreen : AppColors.darkRed;
  Color get _selectedBorder =>
      answer.isRight ? AppColors.lightGreen : AppColors.lightRed;
  Color get _selectedColorCard =>
      answer.isRight ? AppColors.lightGreen : AppColors.lightRed;
  TextStyle get _selectedTextStyle =>
      answer.isRight ? AppTextStyles.bodyDarkGreen : AppTextStyles.bodyDarkRed;
  IconData get _selectedIcon => answer.isRight ? Icons.check : Icons.close;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: GestureDetector(
        onTap: () {
          onTap(answer.isRight);
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? _selectedColorCard : AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.fromBorderSide(
              BorderSide(
                  color: isSelected ? _selectedBorder : AppColors.border),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  answer.title,
                  style: isSelected ? _selectedTextStyle : AppTextStyles.body,
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? _selectedColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(500),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: isSelected ? _selectedBorder : Colors.transparent,
                    ),
                  ),
                ),
                child: isSelected
                    ? Icon(
                        _selectedIcon,
                        size: 16,
                        color: Colors.white,
                      )
                    : SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
