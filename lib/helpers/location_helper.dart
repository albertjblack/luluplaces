import 'package:http/http.dart' as http;

const googleApi = "AIzaSyBg_SeRnCIOfQLA_CHrprJYy6XOxMPB1DE";

class LocationHelper {
  static String getLocationPreview(
      {required double latitude, required double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleApi';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    return "";
  }
}
