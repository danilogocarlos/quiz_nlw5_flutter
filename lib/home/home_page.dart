import 'package:flutter/material.dart';
import 'package:quiztholic/challenge/challenge_page.dart';
import 'package:quiztholic/core/core.dart';
import 'package:quiztholic/home/home_controller.dart';
import 'package:quiztholic/home/home_state.dart';
import 'package:quiztholic/home/widgets/app_bar/app_bar_widget.dart';
import 'package:quiztholic/home/widgets/level_button/level_button_widget.dart';
import 'package:quiztholic/home/widgets/quiz_card/quiz_card_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.fetchData();
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.success) {
      return Scaffold(
        appBar: AppBarWidget(user: controller.user!),
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 20),
                    LevelButtonWidget(label: 'Fácil'),
                    SizedBox(width: 5),
                    LevelButtonWidget(label: 'Médio'),
                    SizedBox(width: 5),
                    LevelButtonWidget(label: 'Difícil'),
                    SizedBox(width: 5),
                    LevelButtonWidget(label: 'Perito'),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.8),
                  children: controller.quizzes!
                      .map(
                        (quiz) => QuizCardWidget(
                          title: quiz.title,
                          image: 'assets/images/${quiz.imagem}.png',
                          completed:
                              "${quiz.questionAnswered} de ${quiz.questions.length}",
                          percent:
                              quiz.questionAnswered / quiz.questions.length,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChallengePage(
                                    questions: quiz.questions,
                                    title: quiz.title),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.green),
          ),
        ),
      );
    }
  }
}
