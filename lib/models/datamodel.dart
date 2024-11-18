class DataModel {
  final int id;
  final String nama;
  final String code;
  final int stok;

  DataModel({
    required this.id,
    required this.nama,
    required this.code,
    required this.stok,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] ?? 0,
      nama: json['nama'] ?? '',
      code: json['code'] ?? '',
      stok: _safeGetInt(json, 'stok'),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'code': code,
    'stok': stok,
  };

  static int _safeGetInt(Map<String, dynamic> json, String key) {
    var value = json[key];
    if (value == null) {
      return 0;
    }
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }
}
