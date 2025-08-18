class NextVideoButtonController {
  final double _startFadeAtPercentage = 0.9;
  final double _startOpacity = 0.5;

  double get _endingSize => (1 - _startFadeAtPercentage);
  double get _opacityRange => 1 - _startOpacity;

  double _getEndingPercentage(double totalVideoPercentage) {
    final double _remainingPercentage = (1 - totalVideoPercentage);
    return (_endingSize - _remainingPercentage) / _endingSize;
  }

  double _getCurrentOpacity(double totalVideoPercentage) {
    final double _percentageOfEndingPlayed =
        _getEndingPercentage(totalVideoPercentage);
    return _startOpacity + (_percentageOfEndingPlayed * _opacityRange);
  }

  double getButtonOpacity(double videoPercentage) {
    if (videoPercentage < _startFadeAtPercentage) {
      return 0.0;
    }

    if (videoPercentage == 1) {
      return 1.0;
    }

    return _getCurrentOpacity(videoPercentage);
  }
}
