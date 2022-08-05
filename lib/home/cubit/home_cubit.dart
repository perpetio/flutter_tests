import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tests/models/cat_fact.dart';
import 'package:flutter_tests/repositories/cat_fact_repository.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  CatfactRepository catFactRepository;
  HomeCubit(this.catFactRepository) : super(HomeMainState());

  Future<void> loadCatFact() async {
    emit(HomeLoading());
    CatFact? catFact = await catFactRepository.getCatFact();
    emit(catFact != null ? HomeMainState(catFact: catFact) : HomeError());
  }
}
