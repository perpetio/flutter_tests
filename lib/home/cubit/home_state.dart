part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {}

class HomeMainState extends HomeState {
  final CatFact? catFact;
  HomeMainState({this.catFact});

  @override
  List<Object?> get props => [catFact];
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeError extends HomeState {
  @override
  List<Object?> get props => [];
}
