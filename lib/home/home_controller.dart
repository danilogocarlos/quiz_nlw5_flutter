import 'package:flutter/widgets.dart';
import 'package:quiztholic/home/home_repository.dart';
import 'package:quiztholic/home/home_state.dart';
import 'package:quiztholic/shared/model/quiz_model.dart';
import 'package:quiztholic/shared/model/user_model.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;
  List<QuizModel>? quizzes;

  final repository = HomeRepository();

  fetchData() async {
    state = HomeState.loading;
    await getUser();
    await getQuizzes();
    state = HomeState.success;
  }

  Future getUser() async {
    user = await repository.getUser();
  }

  Future getQuizzes() async {
    quizzes = await repository.getQuizzes();
  }
}
