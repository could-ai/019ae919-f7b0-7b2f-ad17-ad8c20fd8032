
import 'package:couldai_user_app/models/gps_point.dart';

class Project {
  String id;
  String name;
  List<GpsPoint> points;
  DateTime createdAt;

  Project({
    required this.id,
    required this.name,
    this.points = const [],
    required this.createdAt,
  });
}
