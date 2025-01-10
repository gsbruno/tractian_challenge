import 'package:tractian_challenge/core/utils/errors/local_errors.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/data/models/asset_model.dart';
import 'package:tractian_challenge/feature/asset/data/models/location_model.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/asset.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/component.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/location.dart';
import 'package:tractian_challenge/feature/asset/domain/entities/node.dart';
import 'package:tractian_challenge/feature/asset/domain/usecases/get_all_assets_usecase.dart';
import 'package:tractian_challenge/feature/asset/domain/usecases/get_all_locations_usecase.dart';
import 'package:tractian_challenge/shared/domain/usecases/usecase.dart';

final class GetAllNodesUsecase extends UseCase<Map<String, Node>, GetAllNodesUsecaseParams> {
  GetAllNodesUsecase();

  @override
  Output<Map<String, Node>> call({GetAllNodesUsecaseParams? params}) async {
    if (params == null) {
      return (NoMatchingValue('Params'), null);
    }

    final (locationError, allLocations) = await GetAllLocationsUsecase().call(
      params: GetAllLocationsUsecaseParams(companyId: params.companyId),
    );

    if (locationError != null) {
      return (locationError, null);
    }

    final nodes = _createLocationNodes(allLocations ?? []);

    final (assetError, allAssets) = await GetAllAssetsUsecase().call(
      params: GetAllAssetsUsecaseParams(companyId: params.companyId),
    );

    if (assetError != null) {
      return (assetError, null);
    }

    nodes.addAll(_createAssetNodes(allAssets ?? []));

    return (null, nodes);
  }

  Map<String, Node> _createLocationNodes(List<LocationModel> locations) {
    final nodes = <String, Node>{};

    for (var location in locations) {
      nodes[location.id] = Location(id: location.id, name: location.name);
    }

    return nodes;
  }

  Map<String, Node> _createAssetNodes(List<AssetModel> assets) {
    final nodes = <String, Node>{};

    for (var asset in assets) {
      nodes[asset.id] = asset.isComponent ? 
    Component.fromModel(asset) : Asset.fromModel(asset);
    }

    return nodes;
  }
}

final class GetAllNodesUsecaseParams extends Params {
  GetAllNodesUsecaseParams({required this.companyId});

  final String companyId;
}
