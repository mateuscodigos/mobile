class Conversion {
  int? id;
  double real;
  double dolar;
  String timestamp;

  Conversion({
    this.id,
    required this.real,
    required this.dolar,
    required this.timestamp,
  });

  // Converte de Map (do banco) para objeto
  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      id: map['id'] as int?,
      real: map['real'] as double,
      dolar: map['dolar'] as double,
      timestamp: map['timestamp'] as String,
    );
  }

  // Converte para Map (para salvar no banco)
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'real': real,
      'dolar': dolar,
      'timestamp': timestamp,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
