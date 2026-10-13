/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// Outcome of one Loop Lab experiment: a synthetic cadre solved twice.
abstract class LabResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  LabResult._({
    required this.members,
    required this.districts,
    required this.choices,
    required this.maxLoopSize,
    required this.pairwisePeople,
    required this.loopPeople,
    required this.loops2,
    required this.loops3,
    required this.loops4,
    required this.candidateLoops,
    required this.elapsedMicros,
  });

  factory LabResult({
    required int members,
    required int districts,
    required int choices,
    required int maxLoopSize,
    required int pairwisePeople,
    required int loopPeople,
    required int loops2,
    required int loops3,
    required int loops4,
    required int candidateLoops,
    required int elapsedMicros,
  }) = _LabResultImpl;

  factory LabResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return LabResult(
      members: jsonSerialization['members'] as int,
      districts: jsonSerialization['districts'] as int,
      choices: jsonSerialization['choices'] as int,
      maxLoopSize: jsonSerialization['maxLoopSize'] as int,
      pairwisePeople: jsonSerialization['pairwisePeople'] as int,
      loopPeople: jsonSerialization['loopPeople'] as int,
      loops2: jsonSerialization['loops2'] as int,
      loops3: jsonSerialization['loops3'] as int,
      loops4: jsonSerialization['loops4'] as int,
      candidateLoops: jsonSerialization['candidateLoops'] as int,
      elapsedMicros: jsonSerialization['elapsedMicros'] as int,
    );
  }

  int members;

  int districts;

  int choices;

  int maxLoopSize;

  /// People a pairs-only portal would move.
  int pairwisePeople;

  /// People Loop places in proposed loops.
  int loopPeople;

  int loops2;

  int loops3;

  int loops4;

  int candidateLoops;

  int elapsedMicros;

  /// Returns a shallow copy of this [LabResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LabResult copyWith({
    int? members,
    int? districts,
    int? choices,
    int? maxLoopSize,
    int? pairwisePeople,
    int? loopPeople,
    int? loops2,
    int? loops3,
    int? loops4,
    int? candidateLoops,
    int? elapsedMicros,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LabResult',
      'members': members,
      'districts': districts,
      'choices': choices,
      'maxLoopSize': maxLoopSize,
      'pairwisePeople': pairwisePeople,
      'loopPeople': loopPeople,
      'loops2': loops2,
      'loops3': loops3,
      'loops4': loops4,
      'candidateLoops': candidateLoops,
      'elapsedMicros': elapsedMicros,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LabResult',
      'members': members,
      'districts': districts,
      'choices': choices,
      'maxLoopSize': maxLoopSize,
      'pairwisePeople': pairwisePeople,
      'loopPeople': loopPeople,
      'loops2': loops2,
      'loops3': loops3,
      'loops4': loops4,
      'candidateLoops': candidateLoops,
      'elapsedMicros': elapsedMicros,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _LabResultImpl extends LabResult {
  _LabResultImpl({
    required int members,
    required int districts,
    required int choices,
    required int maxLoopSize,
    required int pairwisePeople,
    required int loopPeople,
    required int loops2,
    required int loops3,
    required int loops4,
    required int candidateLoops,
    required int elapsedMicros,
  }) : super._(
         members: members,
         districts: districts,
         choices: choices,
         maxLoopSize: maxLoopSize,
         pairwisePeople: pairwisePeople,
         loopPeople: loopPeople,
         loops2: loops2,
         loops3: loops3,
         loops4: loops4,
         candidateLoops: candidateLoops,
         elapsedMicros: elapsedMicros,
       );

  /// Returns a shallow copy of this [LabResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LabResult copyWith({
    int? members,
    int? districts,
    int? choices,
    int? maxLoopSize,
    int? pairwisePeople,
    int? loopPeople,
    int? loops2,
    int? loops3,
    int? loops4,
    int? candidateLoops,
    int? elapsedMicros,
  }) {
    return LabResult(
      members: members ?? this.members,
      districts: districts ?? this.districts,
      choices: choices ?? this.choices,
      maxLoopSize: maxLoopSize ?? this.maxLoopSize,
      pairwisePeople: pairwisePeople ?? this.pairwisePeople,
      loopPeople: loopPeople ?? this.loopPeople,
      loops2: loops2 ?? this.loops2,
      loops3: loops3 ?? this.loops3,
      loops4: loops4 ?? this.loops4,
      candidateLoops: candidateLoops ?? this.candidateLoops,
      elapsedMicros: elapsedMicros ?? this.elapsedMicros,
    );
  }
}
