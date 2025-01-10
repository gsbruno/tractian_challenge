import 'package:tractian_challenge/core/utils/types/types.dart';
import 'package:tractian_challenge/feature/home/data/data_sources/company_remote_data_souce.dart';
import 'package:tractian_challenge/feature/home/data/models/company_model.dart';
import 'package:tractian_challenge/shared/domain/usecases/usecase.dart';

final class GetAllCompaniesUsecase
    extends UseCase<List<CompanyModel>, Params> {
  GetAllCompaniesUsecase();

  @override
  Output<List<CompanyModel>> call({Params? params}) async {
    
    final dataSource = CompanyRemoteDataSource();

    return await dataSource.getAll();
  }
}
