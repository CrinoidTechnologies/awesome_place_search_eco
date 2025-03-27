import 'package:awesome_place_search/src/core/dependencies/dependencies.dart';
import 'package:awesome_place_search/src/core/error/failures/i_failure.dart';
import 'package:awesome_place_search/src/data/models/awesome_place_model.dart';
import 'package:awesome_place_search/src/data/models/lat_lng_model.dart';
import 'package:awesome_place_search/src/presentation/controller/search_state.dart';
import 'package:dartz/dartz.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:uuid/uuid.dart';

class AwesomePlaceSearchController {
  final Dependencies dependencies;
  final List<String> countries;

  AwesomePlaceSearchController(
      {required this.dependencies, required this.countries});

  Future<Either<Failure, AwesomePlacesSearchModel>> getPlaces(
      {required String value, String? sessionToken}) async {
    final result = await dependencies.repository?.getPlace(
      param: ParamSearchModel(
        key: dependencies.key!,
        value: value,
        countries: _getCountries(),
        sessionToken: sessionToken
      ),
    );

    return result!;
  }

  Future<Either<Failure, LatLngModel>> getLatLng(
      {required String value}) async {
    final result = await dependencies.repository?.getLatLng(placeId: value);

    return result!;
  }

  Future<Either<Failure, GoogleGeocodingResult>> getPlaceDetail(
      {required String value, String? sessionToken}) async {
    final result = await dependencies.repository?.getPlaceDetail(placeId: value, sessionToken: sessionToken);

    return result!;
  }

  SearchState mapError(Failure left) {
    if (left is InvalidKeyFailure) {
      return SearchState.invalidKey;
    }

    if (left is EmptyFailure) {
      return SearchState.empty;
    }

    return SearchState.serverError;
  }

  String _getCountries() {
    List<String> result = [];

    for (var item in countries) {
      result.add("country:$item");
    }

    return result.join('|');
  }
}
