import 'package:final_project/features/location/domain/usecase/fetch_place_latlng_useCase.dart';
import 'package:final_project/features/location/domain/usecase/search_places_usecase.dart';
import 'package:final_project/features/location/presentation/cubit/location_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationCubit extends Cubit<LocationState> {
  final SearchPlacesUseCase searchPlacesUseCase;
  final FetchPlaceLatLngUseCase fetchPlaceLatLngUseCase;

  LocationCubit(
    this.searchPlacesUseCase,
    this.fetchPlaceLatLngUseCase,
  ) : super(const LocationState());

  // search places
  Future<void> search(String query) async {
    emit(state.copyWith(loading: true));

    final result = await searchPlacesUseCase(query: query);
    result.when(
      (list) => emit(
        state.copyWith(
          results: list,
          loading: false,
        ),
      ),
      (_) => emit(state.copyWith(loading: false)),
    );
  }

  // select from search
  Future<void> selectPlace(String placeId) async {
    final result = await fetchPlaceLatLngUseCase(placeId: placeId);

    result.when(
      (coords) => emit(
        state.copyWith(
          lat: coords.$1,
          lng: coords.$2,
          results: [],
        ),
      ),
      (_) {},
    );
  }

  // select manually from map
  void setManualLocation(double lat, double lng) {
    emit(
      state.copyWith(
        lat: lat,
        lng: lng,
      ),
    );
  }
}

