import 'package:tractian_challenge/core/network/server_urls.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/data/models/location_model.dart';
import 'package:tractian_challenge/shared/data/remote_data_source.dart';

final class LocationRemoteDataSource extends RemoteDataSource<LocationModel> {
  LocationRemoteDataSource({super.dio});

  @override
  ServerUrls get serverUrl => ServerUrls.locations;

  @override
  Output<List<LocationModel>> getAllById({required String id}) async {
    try {
      final response = await callGetAllById(id: id);

      final locations = response.map((e) => LocationModel.from(e)).toList();

      return (null, locations);
    } catch (e) {
      return errorTreatment(e);
    }
  }
}
