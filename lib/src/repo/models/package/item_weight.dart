class ItemWeight {
  final String id;
  final int start;
  final int end;

  ItemWeight({
    required this.id,
    required this.start,
    required this.end,
  });

  factory ItemWeight.fromJson(Map<String, dynamic> json) {
    return ItemWeight(
      id: json['id'],
      start: json['start'],
      end: json['end'],
    );
  }
}
