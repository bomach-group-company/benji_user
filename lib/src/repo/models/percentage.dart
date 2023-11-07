import 'package:benji/src/repo/utils/constant.dart';

class Percentage {
  final String id;
  final double riderPercentage;
  final double agentPercentage;
  final double stateCoordinatorPercentage;

  Percentage({
    required this.id,
    required this.riderPercentage,
    required this.agentPercentage,
    required this.stateCoordinatorPercentage,
  });

  factory Percentage.fromJson(Map<String, dynamic>? json) {
    json ??= {};
    return Percentage(
      id: json['id'] ?? notAvailable,
      riderPercentage: (json['rider_percentage'] ?? 0).toDouble(),
      agentPercentage: (json['agent_percentage'] ?? 0).toDouble(),
      stateCoordinatorPercentage:
          (json['stateCoordinator_percentage'] ?? 0).toDouble(),
    );
  }
}
