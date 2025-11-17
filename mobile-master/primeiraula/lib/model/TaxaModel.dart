class TaxaModel {
  final double brl;

  TaxaModel({required this.brl});

  factory TaxaModel.fromJson(Map<String, dynamic> json) {
    return TaxaModel(
      brl: (json["rates"]["BRL"] as num).toDouble(),
    );
  }
}
