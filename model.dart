class LoadingEntry {
  double emptyWeight;
  double loadWeight;
  double netWeight;

  LoadingEntry({
    required this.emptyWeight,
    required this.loadWeight,
  }) : netWeight = loadWeight - emptyWeight;
}