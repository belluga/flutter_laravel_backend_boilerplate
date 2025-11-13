import 'package:belluga_boilerplate/application/router/resolvers/route_model_resolver.dart';
import 'package:flutter/material.dart';
import 'package:get_it_modular_with_auto_route/get_it_modular_with_auto_route.dart';

typedef ResolverErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
  VoidCallback retry,
);

abstract class ResolverRoute<TModel, TModule extends ModuleContract>
    extends StatelessWidget {
  const ResolverRoute({super.key});

  @protected
  RouteResolverParams get resolverParams => const {};

  Future<TModel> resolve(BuildContext context) {
    final resolver =
        RouteResolverRegistry.instance.resolverFor<TModel>();
    if (resolver == null) {
      throw StateError(
        'No RouteModelResolver registered for $TModel. '
        'Register one or override resolve() in ${runtimeType.toString()}.',
      );
    }
    return resolver.resolve(resolverParams);
  }

  Widget buildScreen(BuildContext context, TModel model);

  Widget buildLoading(BuildContext context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );

  ResolverErrorBuilder get errorBuilder => (context, error, retry) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Algo deu errado'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: retry,
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ModuleScope<TModule>(
      child: _ResolverBuilder<TModel>(
        resolver: () => resolve(context),
        builder: buildScreen,
        loadingBuilder: buildLoading,
        errorBuilder: errorBuilder,
      ),
    );
  }
}

class _ResolverBuilder<T> extends StatefulWidget {
  const _ResolverBuilder({
    required this.resolver,
    required this.builder,
    required this.loadingBuilder,
    required this.errorBuilder,
  });

  final Future<T> Function() resolver;
  final Widget Function(BuildContext, T) builder;
  final Widget Function(BuildContext) loadingBuilder;
  final ResolverErrorBuilder errorBuilder;

  @override
  State<_ResolverBuilder<T>> createState() => _ResolverBuilderState<T>();
}

class _ResolverBuilderState<T> extends State<_ResolverBuilder<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _resolve();
  }

  void _resolve() {
    _future = widget.resolver();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return widget.loadingBuilder(context);
        }

        if (snapshot.hasError) {
          return widget.errorBuilder(
            context,
            snapshot.error!,
            () => setState(_resolve),
          );
        }

        final data = snapshot.data;
        if (data == null) {
          return widget.errorBuilder(
            context,
            StateError('Resolver returned null'),
            () => setState(_resolve),
          );
        }

        return widget.builder(context, data);
      },
    );
  }
}
