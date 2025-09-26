class TimeLabel {
  final Duration duration;

  TimeLabel({required this.duration}) {
    _init();
  }

  late String _inMinutes;
  late String _inSeconds;
  late String _inHours;

  void _init() {
    _inHours = duration.inHours.toString().padLeft(2, '0');
    _inMinutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    _inSeconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  }

  String get label {
    String _positionTime = "$_inMinutes:$_inSeconds";

    if (_inHours != "00") {
      _positionTime = "$_inHours:$_positionTime";
    }

    return _positionTime;
  }
}
