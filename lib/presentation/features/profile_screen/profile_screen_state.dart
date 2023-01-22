import 'package:equatable/equatable.dart';

class ProfileScreenState extends Equatable {
  const ProfileScreenState({
    this.searchUserName = '',
    this.searchUserId = '',
    this.searchUserDate = '',
    this.searchUserProfession = '',
  });

  final String searchUserName;
  final String searchUserId;
  final String searchUserDate;
  final String searchUserProfession;

  @override
  List<Object> get props => [
        searchUserName,
        searchUserId,
        searchUserDate,
        searchUserProfession,
      ];

  ProfileScreenState copyWith({
    String? searchUserName,
    String? searchUserId,
    String? searchUserDate,
    String? searchUserProfession,
  }) {
    return ProfileScreenState(
      searchUserName: searchUserName ?? this.searchUserName,
      searchUserId: searchUserId ?? this.searchUserId,
      searchUserDate: searchUserDate ?? this.searchUserDate,
      searchUserProfession: searchUserProfession ?? this.searchUserProfession,
    );
  }
}
