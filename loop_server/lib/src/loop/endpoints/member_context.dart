import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../generated/protocol.dart';

/// Resolves the signed-in user's [Member] profile.
Future<Member?> currentMember(Session session) async {
  final auth = session.authenticated;
  if (auth == null) return null;
  final authUserId = auth.authUserId;
  return Member.db.findFirstRow(
    session,
    where: (t) => t.authUserId.equals(authUserId),
  );
}

Future<Member> requireMember(Session session) async {
  final member = await currentMember(session);
  if (member == null) {
    throw LoopException(
      code: LoopErrorCode.profileRequired,
      message: 'Create your profile first.',
    );
  }
  return member;
}

LoopException invalid(String message) =>
    LoopException(code: LoopErrorCode.invalidInput, message: message);
