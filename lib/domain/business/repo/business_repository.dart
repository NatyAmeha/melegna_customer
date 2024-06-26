import 'package:injectable/injectable.dart';
import 'package:melegna_customer/data/network/business_response.dart';
import 'package:melegna_customer/data/network/graphql/business/__generated__/business_queries.data.gql.dart';
import 'package:melegna_customer/data/network/graphql/business/__generated__/business_queries.req.gql.dart';
import 'package:melegna_customer/data/network/graphql_datasource.dart';
import 'package:melegna_customer/domain/shared/repository.intereface.dart';

abstract class IBusinessrepository extends IRepository {
  Future<BusinessResponse?> getBusinessDetails(String id);
}

@Named(BusinessRepository.injectName)
@Injectable(as: IBusinessrepository)
class BusinessRepository implements IBusinessrepository {
  static const injectName = 'BUSINESS_REPOSITORY_INJECTION';
  final IGraphQLDataSource _graphQLDataSource;

  const BusinessRepository(this._graphQLDataSource);
  @override
  Future<BusinessResponse?> getBusinessDetails(String id) async {
    final request = GGetBusinessDetailsReq((b) => b..vars.id = id);
    final result = await _graphQLDataSource.query<GGetBusinessDetailsData?>(request);
    if (result?.getBusinessDetails == null) {
      return null;
    }

    final businessResponse = BusinessResponse.fromJson(result!.getBusinessDetails!.toJson());
    return businessResponse;
  }
}
