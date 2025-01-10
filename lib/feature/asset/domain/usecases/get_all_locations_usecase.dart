import 'package:tractian_challenge/core/utils/errors/local_errors.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/data/data_sources/location_remote_data_source.dart';
import 'package:tractian_challenge/feature/asset/data/models/location_model.dart';
import 'package:tractian_challenge/shared/domain/usecases/usecase.dart';

final class GetAllLocationsUsecase
    extends UseCase<List<LocationModel>, GetAllLocationsUsecaseParams> {
  GetAllLocationsUsecase();

  @override
  Output<List<LocationModel>> call({GetAllLocationsUsecaseParams? params}) async {
    if (params == null) {
      return (NoMatchingValue('Params'), null);
    }

    final dataSource = LocationRemoteDataSource();

    return await dataSource.getAllById(id: params.companyId);
  }
}

final class GetAllLocationsUsecaseParams extends Params {
  GetAllLocationsUsecaseParams({required this.companyId});

  final String companyId;
}
