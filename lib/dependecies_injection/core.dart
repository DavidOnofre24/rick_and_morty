import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

configureCore(GetIt getIt) {
  GetIt.I.registerFactory<Client>(() => Client());
}
