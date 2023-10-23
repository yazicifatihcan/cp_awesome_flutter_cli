import '../command/base_command/commands.dart';

class AppException implements Exception {
  String? _message;

  AppException([this._message]);

  @override
  String toString() {
    _message ??= '❌ ❌ ❌ Error ❌ ❌ ❌';
    return _message!;
  }
}

class NotFountCommand extends AppException {
  NotFountCommand() : super(getAllCommandStr());
}
