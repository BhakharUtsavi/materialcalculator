class InventoryItem {
  String name;
  double quantity;
  String unit;

  InventoryItem({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory InventoryItem.fromMap(Map<String, dynamic> map) {
    return InventoryItem(
      name: map['name'] ?? '',
      quantity: (map['quantity'] as num).toDouble(),
      unit: map['unit'] ?? '',
    );
  }
}
