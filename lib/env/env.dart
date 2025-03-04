import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'secret.env')
abstract class Env {
  Env();

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static String API_KEY = _Env.API_KEY;
}
