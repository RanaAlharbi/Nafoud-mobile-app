import 'package:dart_mappable/dart_mappable.dart';
import 'package:final_project/features/authentication/domain_layer/entity/authentication_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_model.mapper.dart';

@MappableClass()
class AuthenticationModel extends AuthenticationEntity
    with AuthenticationModelMappable {
  AuthenticationModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthenticationModel.fromSession(Session session) {
    return AuthenticationModel(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken ?? '',
    );
  }
}