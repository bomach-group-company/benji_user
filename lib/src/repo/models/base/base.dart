class OffsetLimitBase {
  final List<dynamic> items;
  final int total;
  final int perPage;
  final int start;
  final int end;

  OffsetLimitBase({
    this.items = const [],
    this.total = 0,
    this.perPage = 0,
    this.start = 0,
    this.end = 0,
  });

  factory OffsetLimitBase.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return OffsetLimitBase(
      items: json['items'] ?? [],
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 0,
      start: json['start'] ?? 0,
      end: json['end'] ?? 0,
    );
  }
}
