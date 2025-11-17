class ApiEndpoint {
  static const String baseUrl = "https://api.open-meteo.com/v1/forecast?latitude=-27.2992&longitude=-49.7903&hourly=temperature_2m&models=metno_seamless&current=temperature_2m&temperature_unit=fahrenheit";

  static String getTaxa() {
    return "$baseUrl/taxa";
  }
}
