class Conversion {
  final int? id;
  final double real;
  final double dolar;
  final String timestamp;

  Conversion({
    this.id,
    required this.real,
    required this.dolar,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'real': real,
      'dolar': dolar,
      'timestamp': timestamp,
    };
  }

  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      id: map['id'],
      real: map['real'],
      dolar: map['dolar'],
      timestamp: map['timestamp'],
    );
  }
}
