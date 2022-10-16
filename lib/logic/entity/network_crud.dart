import 'entity.dart';
import 'network_use_case_factory.dart';

class NetworkCRUD {
  final NetworkUseCaseFactory _networkFactory;
  const NetworkCRUD(this._networkFactory);

  Uri _getURLWithId(String endpoint, String host, String id, bool includeId) =>
      Uri.https(host, endpoint + (includeId ? id : ""));
  Uri _getURL(String host, String endpoint) => Uri.https(host, endpoint);

  Creator<V> newCreator<V extends Value>({
    required String endpoint,
    required InpMapper<V> inpMap,
    required OutMapper<Entity<V>> outMap,
  }) {
    return _networkFactory.newBaseNetworkUseCase(
      inpMapper: inpMap,
      getUri: (v, host) => _getURL(endpoint, host),
      method: "POST",
      outMapper: outMap,
    );
  }

  Reader<V> newReader<V extends Value>({
    required String endpoint,
    required bool includeId,
    required OutMapper<Entity<V>> outMap,
  }) {
    return _networkFactory.newBaseNetworkUseCase(
      inpMapper: NoInpMapper(),
      getUri: (id, host) => _getURLWithId(endpoint, host, id, includeId),
      method: "GET",
      outMapper: outMap,
    );
  }

  Updater<V> newUpdater<V extends Value>({
    required String endpoint,
    required bool includeId,
    required InpMapper<Entity<V>> inpMap,
  }) {
    return _networkFactory.newBaseNetworkUseCase(
      inpMapper: inpMap,
      getUri: (Entity<V> e, String host) => _getURLWithId(
        endpoint,
        host,
        e.id,
        includeId,
      ),
      method: "PATCH",
      outMapper: NoOutMapper(),
    );
  }

  Deleter<V> newDeleter<V extends Value>({required String endpoint}) {
    return _networkFactory.newBaseNetworkUseCase(
      inpMapper: NoInpMapper(),
      getUri: (id, host) => _getURLWithId(endpoint, host, id, true),
      method: "DELETE",
      outMapper: NoOutMapper(),
    );
  }
}
