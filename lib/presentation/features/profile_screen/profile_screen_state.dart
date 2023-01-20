import 'package:equatable/equatable.dart';

class ProfileScreenState extends Equatable {
  const ProfileScreenState({
    this.searchUserName = '',
    this.searchUserId = '',
  });

  final String searchUserName;
  final String searchUserId;

  @override
  List<Object> get props => [searchUserName, searchUserId];

  ProfileScreenState copyWith({
    String? searchUserName,
    String? searchUserId,
  }) {
    return ProfileScreenState(
      searchUserName: searchUserName ?? this.searchUserName,
      searchUserId: searchUserId ?? this.searchUserId,
    );
  }
}
