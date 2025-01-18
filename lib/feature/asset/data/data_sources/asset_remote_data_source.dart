import 'package:tractian_challenge/core/network/server_urls.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/asset/data/models/asset_model.dart';
import 'package:tractian_challenge/shared/data/remote_data_source.dart';

final class AssetRemoteDataSource extends RemoteDataSource<AssetModel> {
  AssetRemoteDataSource({super.dio});

  @override
  ServerUrls get serverUrl => ServerUrls.assets;

  @override
  FutureOutput<List<AssetModel>> getAllById({required String id}) async {
    try {
      final response = await callGetAllById(id: id);

      final assets = response.map((e) => AssetModel.from(e)).toList();

      return (null, assets);
    } catch (e) {
      return errorTreatment(e);
    }
  }
}
