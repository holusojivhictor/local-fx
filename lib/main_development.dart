import 'package:local_fx/bootstrap.dart';
import 'package:local_fx/firebase_options_dev.dart';
import 'package:local_fx/src/app.dart';

void main() {
  bootstrap(
    () => const LocalFXApp(),
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
