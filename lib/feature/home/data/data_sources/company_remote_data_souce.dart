import 'package:tractian_challenge/core/network/server_urls.dart';
import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/home/data/models/company_model.dart';
import 'package:tractian_challenge/shared/data/remote_data_source.dart';

final class CompanyRemoteDataSource extends RemoteDataSource<CompanyModel> {
  CompanyRemoteDataSource({super.dio});

  @override
  ServerUrls get serverUrl => ServerUrls.companies;

  @override
  FutureOutput<List<CompanyModel>> getAll() async {
    try {
      final response = await callGetAll();

      final companies = response.map((e) => CompanyModel.from(e)).toList();

      return (null, companies);
    } catch (e) {
      return errorTreatment(e);
    }
  }
}
