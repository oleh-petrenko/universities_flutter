import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universitytest/Model/University.dart';
import 'package:universitytest/Repositories/HttpService.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'UniversityBlocEvent.dart';
import 'UniversityBlocState.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversityBloc extends Bloc<UniversityBlocEvent, UniversityBlocState> {
  UniversityBloc() : super(UniversityBlocInitialState()) {
    _httpService = HttpService(baseUrl: "universities.hipolabs.com");
    on<UniversityBlocEvent>(_handleState);
  }

  late final HttpService _httpService;

  void _handleState(UniversityBlocEvent event, Emitter emitter) async {
    if (event is DidPressLoad) {
      emitter(LoadingState(isLoading: true));
      await Future.delayed(const Duration(seconds: 3)); //for testing

      try {
        final data = await _httpService.request(endpoint: "search",
            method: HttpMethod.get,
            queryParams: {"name": "Middle"});
        final universityModel = UniversityModel.fromJson(data);
        emitter(UniversitiesLoadedState(universityModel: universityModel));
      } catch (error) {
        emitter(UniversitiesLoadedState(universityModel: null));
      }
      emitter(LoadingState(isLoading: false));
    } else if (event is OpenUrl) {
      final uri = Uri.parse(event.url);
      _launchInBrowser(uri);
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}