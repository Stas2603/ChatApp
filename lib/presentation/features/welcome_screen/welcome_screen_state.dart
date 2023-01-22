import 'package:equatable/equatable.dart';

class WelcomeScreenState extends Equatable {
  const WelcomeScreenState({
    this.name = '',
    this.id = '',
    this.profession = '',
  });

  final String name;
  final String id;
  final String profession;

  @override
  List<Object> get props => [name, id, profession];

  WelcomeScreenState copyWith({
    String? name,
    String? id,
    String? profession,
  }) {
    return WelcomeScreenState(
      name: name ?? this.name,
      id: id ?? this.id,
      profession: profession ?? this.profession,
    );
  }
}
