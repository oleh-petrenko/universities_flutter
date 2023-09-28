import '../Model/University.dart';

sealed class UniversityBlocState {}

class UniversityBlocInitialState extends UniversityBlocState {}

class LoadingState extends UniversityBlocState {
  final bool isLoading;
  LoadingState({required this.isLoading});
}

class UniversitiesLoadedState extends UniversityBlocState {
  final UniversityModel? universityModel;
  UniversitiesLoadedState({required this.universityModel});
}