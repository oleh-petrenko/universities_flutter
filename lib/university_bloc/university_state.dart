import '../Model/University.dart';

sealed class UniversityState {}

class UniversityBlocInitialState extends UniversityState {}

class LoadingState extends UniversityState {
  final bool isLoading;

  LoadingState({
    required this.isLoading,
  });
}

class UniversitiesLoadedState extends UniversityState {
  final UniversityModel? universityModel;

  UniversitiesLoadedState({
    required this.universityModel,
  });
}
