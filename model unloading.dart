class UnloadingCustomer {
  String name;
  int boxes;
  double loadWeight;
  double emptyWeight;
  double netWeight;

  UnloadingCustomer({
    required this.name,
    required this.boxes,
    required this.loadWeight,
    required this.emptyWeight,
  }) : netWeight = loadWeight - emptyWeight;
}