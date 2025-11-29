import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/core/di/injector.config.dart';

final GetIt injector = GetIt.instance;

@InjectableInit()
Future<GetIt> configureDependencies() async => await injector.init();