import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universitytest/Model/University.dart';
import 'package:universitytest/Repositories/http_service.dart';
import 'package:universitytest/repositories/univiersity_reposittory.dart';
import 'package:universitytest/university_bloc/university_event.dart';
import 'package:universitytest/university_bloc/university_state.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversityBloc extends Bloc<UniversityEvent, UniversityState> {
  UniversityBloc() : super(UniversityBlocInitialState()) {
    on<UniversityEvent>(_handleState);
  }

  //ЗДесь должен быть DI пока для примера пойдет
  final UniversityRepository repository = UniversityRepositoryImp(
      HttpService(baseUrl: "universities.hipolabs.com"));

  void _handleState(UniversityEvent event, Emitter emitter) async {
    if (event is DidPressLoad) {
      emitter(LoadingState(isLoading: true));
      await Future.delayed(const Duration(seconds: 3)); //for testing

      try {
        final universityModel = await repository.search('Middle');
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
