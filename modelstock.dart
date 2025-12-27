class UnloadingStock {
  String label;
  int boxes;
  double loadWeight;
  double emptyWeight;
  double netWeight;

  UnloadingStock({
    required this.label,
    required this.boxes,
    required this.loadWeight,
    required this.emptyWeight,
  }) : netWeight = loadWeight - emptyWeight;
}