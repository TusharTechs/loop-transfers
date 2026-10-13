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
import 'package:serverpod/serverpod.dart' as _is;

/// One run of the loop engine over an exchange.
abstract class SolverRun
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SolverRun._({
    this.id,
    required this.exchangeId,
    DateTime? at,
    required this.trigger,
    required this.activeListings,
    required this.edgeCount,
    required this.coreSize,
    required this.candidateCount,
    required this.loopsProposed,
    required this.peopleInLoops,
    required this.pairwisePeople,
    required this.elapsedMs,
  }) : at = at ?? DateTime.now();

  factory SolverRun({
    int? id,
    required int exchangeId,
    DateTime? at,
    required String trigger,
    required int activeListings,
    required int edgeCount,
    required int coreSize,
    required int candidateCount,
    required int loopsProposed,
    required int peopleInLoops,
    required int pairwisePeople,
    required int elapsedMs,
  }) = _SolverRunImpl;

  factory SolverRun.fromJson(Map<String, dynamic> jsonSerialization) {
    return SolverRun(
      id: jsonSerialization['id'] as int?,
      exchangeId: jsonSerialization['exchangeId'] as int,
      at: jsonSerialization['at'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
      trigger: jsonSerialization['trigger'] as String,
      activeListings: jsonSerialization['activeListings'] as int,
      edgeCount: jsonSerialization['edgeCount'] as int,
      coreSize: jsonSerialization['coreSize'] as int,
      candidateCount: jsonSerialization['candidateCount'] as int,
      loopsProposed: jsonSerialization['loopsProposed'] as int,
      peopleInLoops: jsonSerialization['peopleInLoops'] as int,
      pairwisePeople: jsonSerialization['pairwisePeople'] as int,
      elapsedMs: jsonSerialization['elapsedMs'] as int,
    );
  }

  static final t = SolverRunTable();

  static const db = SolverRunRepository._();

  @override
  int? id;

  int exchangeId;

  DateTime at;

  String trigger;

  int activeListings;

  int edgeCount;

  int coreSize;

  int candidateCount;

  int loopsProposed;

  int peopleInLoops;

  /// People a pairwise-only portal would have matched on the same graph.
  int pairwisePeople;

  int elapsedMs;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SolverRun]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SolverRun copyWith({
    int? id,
    int? exchangeId,
    DateTime? at,
    String? trigger,
    int? activeListings,
    int? edgeCount,
    int? coreSize,
    int? candidateCount,
    int? loopsProposed,
    int? peopleInLoops,
    int? pairwisePeople,
    int? elapsedMs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SolverRun',
      if (id != null) 'id': id,
      'exchangeId': exchangeId,
      'at': at.toJson(),
      'trigger': trigger,
      'activeListings': activeListings,
      'edgeCount': edgeCount,
      'coreSize': coreSize,
      'candidateCount': candidateCount,
      'loopsProposed': loopsProposed,
      'peopleInLoops': peopleInLoops,
      'pairwisePeople': pairwisePeople,
      'elapsedMs': elapsedMs,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SolverRun',
      if (id != null) 'id': id,
      'exchangeId': exchangeId,
      'at': at.toJson(),
      'trigger': trigger,
      'activeListings': activeListings,
      'edgeCount': edgeCount,
      'coreSize': coreSize,
      'candidateCount': candidateCount,
      'loopsProposed': loopsProposed,
      'peopleInLoops': peopleInLoops,
      'pairwisePeople': pairwisePeople,
      'elapsedMs': elapsedMs,
    };
  }

  static SolverRunInclude include() {
    return SolverRunInclude._();
  }

  static SolverRunIncludeList includeList({
    _is.WhereExpressionBuilder<SolverRunTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SolverRunTable>? orderBy,
    _is.OrderByListBuilder<SolverRunTable>? orderByList,
    SolverRunInclude? include,
  }) {
    return SolverRunIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SolverRun.t),
      orderByList: orderByList?.call(SolverRun.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SolverRunImpl extends SolverRun {
  _SolverRunImpl({
    int? id,
    required int exchangeId,
    DateTime? at,
    required String trigger,
    required int activeListings,
    required int edgeCount,
    required int coreSize,
    required int candidateCount,
    required int loopsProposed,
    required int peopleInLoops,
    required int pairwisePeople,
    required int elapsedMs,
  }) : super._(
         id: id,
         exchangeId: exchangeId,
         at: at,
         trigger: trigger,
         activeListings: activeListings,
         edgeCount: edgeCount,
         coreSize: coreSize,
         candidateCount: candidateCount,
         loopsProposed: loopsProposed,
         peopleInLoops: peopleInLoops,
         pairwisePeople: pairwisePeople,
         elapsedMs: elapsedMs,
       );

  /// Returns a shallow copy of this [SolverRun]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SolverRun copyWith({
    Object? id = _Undefined,
    int? exchangeId,
    DateTime? at,
    String? trigger,
    int? activeListings,
    int? edgeCount,
    int? coreSize,
    int? candidateCount,
    int? loopsProposed,
    int? peopleInLoops,
    int? pairwisePeople,
    int? elapsedMs,
  }) {
    return SolverRun(
      id: id is int? ? id : this.id,
      exchangeId: exchangeId ?? this.exchangeId,
      at: at ?? this.at,
      trigger: trigger ?? this.trigger,
      activeListings: activeListings ?? this.activeListings,
      edgeCount: edgeCount ?? this.edgeCount,
      coreSize: coreSize ?? this.coreSize,
      candidateCount: candidateCount ?? this.candidateCount,
      loopsProposed: loopsProposed ?? this.loopsProposed,
      peopleInLoops: peopleInLoops ?? this.peopleInLoops,
      pairwisePeople: pairwisePeople ?? this.pairwisePeople,
      elapsedMs: elapsedMs ?? this.elapsedMs,
    );
  }
}

class SolverRunUpdateTable extends _is.UpdateTable<SolverRunTable> {
  SolverRunUpdateTable(super.table);

  _is.ColumnValue<int, int> exchangeId(int value) => _is.ColumnValue(
    table.exchangeId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> at(DateTime value) => _is.ColumnValue(
    table.at,
    value,
  );

  _is.ColumnValue<String, String> trigger(String value) => _is.ColumnValue(
    table.trigger,
    value,
  );

  _is.ColumnValue<int, int> activeListings(int value) => _is.ColumnValue(
    table.activeListings,
    value,
  );

  _is.ColumnValue<int, int> edgeCount(int value) => _is.ColumnValue(
    table.edgeCount,
    value,
  );

  _is.ColumnValue<int, int> coreSize(int value) => _is.ColumnValue(
    table.coreSize,
    value,
  );

  _is.ColumnValue<int, int> candidateCount(int value) => _is.ColumnValue(
    table.candidateCount,
    value,
  );

  _is.ColumnValue<int, int> loopsProposed(int value) => _is.ColumnValue(
    table.loopsProposed,
    value,
  );

  _is.ColumnValue<int, int> peopleInLoops(int value) => _is.ColumnValue(
    table.peopleInLoops,
    value,
  );

  _is.ColumnValue<int, int> pairwisePeople(int value) => _is.ColumnValue(
    table.pairwisePeople,
    value,
  );

  _is.ColumnValue<int, int> elapsedMs(int value) => _is.ColumnValue(
    table.elapsedMs,
    value,
  );
}

class SolverRunTable extends _is.Table<int?> {
  SolverRunTable({super.tableRelation}) : super(tableName: 'solver_run') {
    updateTable = SolverRunUpdateTable(this);
    exchangeId = _is.ColumnInt(
      'exchangeId',
      this,
    );
    at = _is.ColumnDateTime(
      'at',
      this,
      hasDefault: true,
    );
    trigger = _is.ColumnString(
      'trigger',
      this,
    );
    activeListings = _is.ColumnInt(
      'activeListings',
      this,
    );
    edgeCount = _is.ColumnInt(
      'edgeCount',
      this,
    );
    coreSize = _is.ColumnInt(
      'coreSize',
      this,
    );
    candidateCount = _is.ColumnInt(
      'candidateCount',
      this,
    );
    loopsProposed = _is.ColumnInt(
      'loopsProposed',
      this,
    );
    peopleInLoops = _is.ColumnInt(
      'peopleInLoops',
      this,
    );
    pairwisePeople = _is.ColumnInt(
      'pairwisePeople',
      this,
    );
    elapsedMs = _is.ColumnInt(
      'elapsedMs',
      this,
    );
  }

  late final SolverRunUpdateTable updateTable;

  late final _is.ColumnInt exchangeId;

  late final _is.ColumnDateTime at;

  late final _is.ColumnString trigger;

  late final _is.ColumnInt activeListings;

  late final _is.ColumnInt edgeCount;

  late final _is.ColumnInt coreSize;

  late final _is.ColumnInt candidateCount;

  late final _is.ColumnInt loopsProposed;

  late final _is.ColumnInt peopleInLoops;

  /// People a pairwise-only portal would have matched on the same graph.
  late final _is.ColumnInt pairwisePeople;

  late final _is.ColumnInt elapsedMs;

  @override
  List<_is.Column> get columns => [
    id,
    exchangeId,
    at,
    trigger,
    activeListings,
    edgeCount,
    coreSize,
    candidateCount,
    loopsProposed,
    peopleInLoops,
    pairwisePeople,
    elapsedMs,
  ];
}

class SolverRunInclude extends _is.IncludeObject {
  SolverRunInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SolverRun.t;
}

class SolverRunIncludeList extends _is.IncludeList {
  SolverRunIncludeList._({
    _is.WhereExpressionBuilder<SolverRunTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SolverRun.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SolverRun.t;
}

class SolverRunRepository {
  const SolverRunRepository._();

  /// Returns a list of [SolverRun]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<SolverRun>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SolverRunTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SolverRunTable>? orderBy,
    _is.OrderByListBuilder<SolverRunTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SolverRun>(
      where: where?.call(SolverRun.t),
      orderBy: orderBy?.call(SolverRun.t),
      orderByList: orderByList?.call(SolverRun.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SolverRun] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<SolverRun?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SolverRunTable>? where,
    int? offset,
    _is.OrderByBuilder<SolverRunTable>? orderBy,
    _is.OrderByListBuilder<SolverRunTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SolverRun>(
      where: where?.call(SolverRun.t),
      orderBy: orderBy?.call(SolverRun.t),
      orderByList: orderByList?.call(SolverRun.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SolverRun] by its [id] or null if no such row exists.
  Future<SolverRun?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SolverRun>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SolverRun]s in the list and returns the inserted rows.
  ///
  /// The returned [SolverRun]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SolverRun>> insert(
    _is.DatabaseSession session,
    List<SolverRun> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SolverRun>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SolverRun] and returns the inserted row.
  ///
  /// The returned [SolverRun] will have its `id` field set.
  Future<SolverRun> insertRow(
    _is.DatabaseSession session,
    SolverRun row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SolverRun>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SolverRun]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [SolverRun]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SolverRun>> upsert(
    _is.DatabaseSession session,
    List<SolverRun> rows, {
    required _is.ColumnSelections<SolverRunTable> conflictColumns,
    _is.ColumnSelections<SolverRunTable>? updateColumns,
    _is.WhereExpressionBuilder<SolverRunTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SolverRun>(
      rows,
      conflictColumns: conflictColumns(SolverRun.t),
      updateColumns: updateColumns?.call(SolverRun.t),
      updateWhere: updateWhere?.call(SolverRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SolverRun] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [SolverRun] will have its `id` field set.
  Future<SolverRun?> upsertRow(
    _is.DatabaseSession session,
    SolverRun row, {
    required _is.ColumnSelections<SolverRunTable> conflictColumns,
    _is.ColumnSelections<SolverRunTable>? updateColumns,
    _is.WhereExpressionBuilder<SolverRunTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SolverRun>(
      row,
      conflictColumns: conflictColumns(SolverRun.t),
      updateColumns: updateColumns?.call(SolverRun.t),
      updateWhere: updateWhere?.call(SolverRun.t),
      transaction: transaction,
    );
  }

  /// Updates all [SolverRun]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SolverRun>> update(
    _is.DatabaseSession session,
    List<SolverRun> rows, {
    _is.ColumnSelections<SolverRunTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SolverRun>(
      rows,
      columns: columns?.call(SolverRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SolverRun]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SolverRun> updateRow(
    _is.DatabaseSession session,
    SolverRun row, {
    _is.ColumnSelections<SolverRunTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SolverRun>(
      row,
      columns: columns?.call(SolverRun.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SolverRun] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SolverRun?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SolverRunUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SolverRun>(
      id,
      columnValues: columnValues(SolverRun.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SolverRun]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SolverRun>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SolverRunUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SolverRunTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SolverRunTable>? orderBy,
    _is.OrderByListBuilder<SolverRunTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SolverRun>(
      columnValues: columnValues(SolverRun.t.updateTable),
      where: where(SolverRun.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SolverRun.t),
      orderByList: orderByList?.call(SolverRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SolverRun]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SolverRun>> delete(
    _is.DatabaseSession session,
    List<SolverRun> rows, {
    _is.OrderByBuilder<SolverRunTable>? orderBy,
    _is.OrderByListBuilder<SolverRunTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SolverRun>(
      rows,
      orderBy: orderBy?.call(SolverRun.t),
      orderByList: orderByList?.call(SolverRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SolverRun].
  Future<SolverRun> deleteRow(
    _is.DatabaseSession session,
    SolverRun row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SolverRun>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SolverRun>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SolverRunTable> where,
    _is.OrderByBuilder<SolverRunTable>? orderBy,
    _is.OrderByListBuilder<SolverRunTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SolverRun>(
      where: where(SolverRun.t),
      orderBy: orderBy?.call(SolverRun.t),
      orderByList: orderByList?.call(SolverRun.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SolverRunTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SolverRun>(
      where: where?.call(SolverRun.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SolverRun] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SolverRunTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SolverRun>(
      where: where(SolverRun.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
