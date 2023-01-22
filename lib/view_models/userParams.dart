import 'package:equatable/equatable.dart';

class UserParams extends Equatable {
  final String id;
  final String date;
  final String name;
  final String profession;

  const UserParams({
    required this.id,
    required this.date,
    required this.name,
    required this.profession,
  });

  @override
  List<Object?> get props => [id, date, name, profession];
}
