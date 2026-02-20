// Conditional export: use web implementation when building for web, otherwise use IO stub.
export 'player_io.dart' if (dart.library.html) 'player_web.dart';
