import 'package:flutter/material.dart';

import 'package:quiztholic/challenge/widgets/answer/answer_widget.dart';
import 'package:quiztholic/core/core.dart';
import 'package:quiztholic/shared/model/answer_model.dart';
import 'package:quiztholic/shared/model/question_model.dart';

class QuizWidget extends StatefulWidget {
  final QuestionModel question;
  final ValueChanged<bool> onSelected;
  const QuizWidget({
    Key? key,
    required this.question,
    required this.onSelected,
  }) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int selectedIndex = -1;
  AnswerModel answer(int index) => widget.question.answers[index];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 64),
          Text(
            widget.question.title,
            style: AppTextStyles.heading,
          ),
          SizedBox(height: 24),
          for (var i = 0; i < widget.question.answers.length; i++)
            AnswerWidget(
              answer: answer(i),
              disabled: selectedIndex != -1,
              isSelected: selectedIndex == i,
              onTap: (value) {
                selectedIndex = i;
                widget.onSelected(value);
                setState(() {});
              },
            ),
        ],
      ),
    );
  }
}
