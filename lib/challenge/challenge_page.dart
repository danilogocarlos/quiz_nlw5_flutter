import 'package:flutter/material.dart';
import 'package:quiztholic/challenge/challenge_controller.dart';
import 'package:quiztholic/challenge/next_button/next_button_widget.dart';
import 'package:quiztholic/challenge/widgets/question_idicator/question_indicator_idget.dart';
import 'package:quiztholic/challenge/widgets/quiz/quiz_widget.dart';
import 'package:quiztholic/result/result_page.dart';
import 'package:quiztholic/shared/model/question_model.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  const ChallengePage({
    Key? key,
    required this.questions,
    required this.title,
  }) : super(key: key);
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void onSelected(bool value) {
    if (value) {
      controller.rightAnswers++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            ValueListenableBuilder<int>(
              valueListenable: controller.currentPageNotifier,
              builder: (context, value, _) => QuestionIndicatorWidget(
                currentPage: value,
                length: widget.questions.length,
              ),
            ),
          ],
        )),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map((e) => QuizWidget(
                  question: e,
                  onSelected: onSelected,
                ))
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifier,
            builder: (context, value, _) => value != widget.questions.length
                ? NextButtonWidget.white(
                    label: "Próxima",
                    onTap: nextPage,
                  )
                : NextButtonWidget.green(
                    label: "Confirmar",
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                            title: widget.title,
                            length: widget.questions.length,
                            result: controller.rightAnswers,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
