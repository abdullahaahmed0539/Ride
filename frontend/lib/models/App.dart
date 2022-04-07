// ignore_for_file: file_names
class App {
  String _appMode;

  App(this._appMode);

  void setAppMode(String mode) {
    _appMode = mode;
  }

  String getAppMode() {
    return _appMode;
  }
}
