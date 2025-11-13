typedef RouteResolverParams = Map<String, dynamic>;

abstract class RouteModelResolver<TModel> {
  Future<TModel> resolve(RouteResolverParams params);
}

class RouteResolverRegistry {
  RouteResolverRegistry._();

  static final RouteResolverRegistry instance =
      RouteResolverRegistry._();

  final Map<Type, RouteModelResolver<dynamic>> _resolvers = {};

  void register<TModel>(RouteModelResolver<TModel> resolver) {
    _resolvers[TModel] = resolver;
  }

  RouteModelResolver<TModel>? resolverFor<TModel>() {
    final resolver = _resolvers[TModel];
    if (resolver == null) {
      return null;
    }
    return resolver as RouteModelResolver<TModel>;
  }

  void unregister<TModel>() {
    _resolvers.remove(TModel);
  }

  void clear() {
    _resolvers.clear();
  }
}
