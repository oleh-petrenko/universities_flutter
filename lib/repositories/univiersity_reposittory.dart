import 'package:universitytest/Model/University.dart';
import 'package:universitytest/Repositories/http_service.dart';

abstract class UniversityRepository {

  Future<UniversityModel> search(String name);
}

class UniversityRepositoryImp extends UniversityRepository {
  final HttpService _httpService;

  UniversityRepositoryImp(this._httpService);



  Future<UniversityModel> search(String name) async {
    final data = await _httpService.request(
        endpoint: "search",
        method: HttpMethod.get,
        queryParams: {"name": "Middle"});
    return UniversityModel.fromJson(data);
  }
}
