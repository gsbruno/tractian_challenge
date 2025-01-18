import 'package:tractian_challenge/core/utils/errors/local_errors.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/data/data_sources/asset_remote_data_source.dart';
import 'package:tractian_challenge/feature/asset/data/models/asset_model.dart';
import 'package:tractian_challenge/shared/domain/usecases/usecase.dart';

final class GetAllAssetsUsecase
    extends UseCase<List<AssetModel>, GetAllAssetsUsecaseParams> {
  GetAllAssetsUsecase();

  @override
  FutureOutput<List<AssetModel>> call(
      {GetAllAssetsUsecaseParams? params}) async {
    if (params == null) {
      return (NoMatchingValue('Params'), null);
    }

    final dataSource = AssetRemoteDataSource();

    return await dataSource.getAllById(id: params.companyId);
  }
}

final class GetAllAssetsUsecaseParams extends Params {
  GetAllAssetsUsecaseParams({required this.companyId});

  final String companyId;
}
