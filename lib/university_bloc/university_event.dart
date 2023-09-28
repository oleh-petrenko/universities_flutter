sealed class UniversityEvent {}

class DidPressLoad extends UniversityEvent {}

class OpenUrl extends UniversityEvent {
  final String url;

  OpenUrl({
    required this.url,
  });
}
