import 'package:ferry/ferry.dart';
import 'package:melegna_customer/data/network/datasource.interface.dart';

abstract class IGraphQLDataSource extends IDataSource {
  Future<dynamic> query(OperationRequest<dynamic, dynamic> request);
  Future<dynamic> mutation(String mutation, {Map<String, dynamic> variables});
}

class GraphqlDatasource implements IGraphQLDataSource {
  final Client graphQlClient;
  const GraphqlDatasource(this.graphQlClient);
  @override
  Future delete(String url) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String url) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future mutation(String mutation, {Map<String, dynamic>? variables}) {
    // TODO: implement mutation
    throw UnimplementedError();
  }

  @override
  Future post(String url, data) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future put(String url, data) {
    // TODO: implement put

    throw UnimplementedError();
  }

  @override
  Future<dynamic> query(OperationRequest<dynamic, dynamic> request) async {
    try {
      var response = await graphQlClient.request(request).first;
      print(
          "response ${response?.hasErrors} ${response.linkException} ${response.hashCode} ${response.data?.getBusinessDetails?.toJson().toString()}");
      if (response.hasErrors) {
        throw Exception(response.graphqlErrors?.toString());
      }
      final item = response.data;
      return item;
    } catch (e) {
      return Future.error("error occured $e");
    }
  }
}