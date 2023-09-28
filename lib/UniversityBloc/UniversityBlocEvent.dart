sealed class UniversityBlocEvent {}

class DidPressLoad extends UniversityBlocEvent {}

class OpenUrl extends UniversityBlocEvent {
  final String url;
  OpenUrl({required this.url});
}