import 'package:awesome_place_search/src/data/models/awesome_place_model.dart';
import 'package:awesome_place_search/src/data/models/lat_lng_model.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

abstract class IGetSearchRemoteDataSource {
  Future<LatLngModel> getLatLng({required String param});

  Future<GoogleGeocodingResult> getPlaceDetail({required String placeId});

  Future<AwesomePlacesSearchModel> getPlace({required ParamSearchModel param});
}
