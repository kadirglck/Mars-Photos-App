import '../../core/manager/network_manager.dart';

class TabService {
  Future<dynamic> getPhotos(int page, String roverName, String? camera) async {
    try {
      var response = await NetworkManager.instance?.dio.get(
        '$roverName/photos?sol=100&api_key=AsEUCVgQRcuGMydM8qZX8nDh4ri0DT4ZzSZ8iPAg&page=$page${camera == null ? '' : '&camera=$camera'}',
      );
      return response!.data;
    } catch (e) {
      print(e);
    }
  }
}
