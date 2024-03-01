import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';

final _get => GetIt.I.get;

MoviesManager get moviesManager => _get<moviesManager>();
RouterService get routerService => _get<routerService>();

