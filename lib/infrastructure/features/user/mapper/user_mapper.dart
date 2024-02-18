import 'package:github_viewer/domain/features/user/export.dart';
import 'package:github_viewer/infrastructure/features/user/export.dart';

extension UserMapping on UserDTO {
  User toDomain() {
    return User(
      username: login,
    );
  }
}
