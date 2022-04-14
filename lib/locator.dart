import 'package:get_it/get_it.dart';
import 'providers/view_models.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ViewModel>(() => ViewModel());
}
abstract class LocatorService {
  static ViewModel vm() => locator<ViewModel>();

  static void reset() {
    locator.resetLazySingleton<ViewModel>();
  }
}
