import 'package:auto_route/auto_route.dart';
part 'router_sevice.gr.dart';

@AutoRouterConfig()
class RouterService extends _$RouterService{
  @override
  List<AutoRoute> get routes => {
    AutoRoute(page:  HomeRoute.page, initial: true),
    AutoRoute(page: DetailsRoute.page),
  };
}