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
import '../../loop/models/loop_status.dart' as _ipcz1n71;

/// A proposed or settled cycle of swaps.
abstract class SwapLoop
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SwapLoop._({
    this.id,
    required this.exchangeId,
    _ipcz1n71.LoopStatus? status,
    required this.size,
    required this.score,
    this.publicCode,
    DateTime? createdAt,
    required this.deadline,
    this.resolvedAt,
  }) : status = status ?? _ipcz1n71.LoopStatus.proposed,
       createdAt = createdAt ?? DateTime.now();

  factory SwapLoop({
    int? id,
    required int exchangeId,
    _ipcz1n71.LoopStatus? status,
    required int size,
    required double score,
    String? publicCode,
    DateTime? createdAt,
    required DateTime deadline,
    DateTime? resolvedAt,
  }) = _SwapLoopImpl;

  factory SwapLoop.fromJson(Map<String, dynamic> jsonSerialization) {
    return SwapLoop(
      id: jsonSerialization['id'] as int?,
      exchangeId: jsonSerialization['exchangeId'] as int,
      status: jsonSerialization['status'] == null
          ? null
          : _ipcz1n71.LoopStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      size: jsonSerialization['size'] as int,
      score: (jsonSerialization['score'] as num).toDouble(),
      publicCode: jsonSerialization['publicCode'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      deadline: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['deadline'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  static final t = SwapLoopTable();

  static const db = SwapLoopRepository._();

  @override
  int? id;

  int exchangeId;

  _ipcz1n71.LoopStatus status;

  int size;

  double score;

  /// Public verification code, shown only once the loop is confirmed.
  String? publicCode;

  DateTime createdAt;

  DateTime deadline;

  DateTime? resolvedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SwapLoop]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SwapLoop copyWith({
    int? id,
    int? exchangeId,
    _ipcz1n71.LoopStatus? status,
    int? size,
    double? score,
    String? publicCode,
    DateTime? createdAt,
    DateTime? deadline,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SwapLoop',
      if (id != null) 'id': id,
      'exchangeId': exchangeId,
      'status': status.toJson(),
      'size': size,
      'score': score,
      if (publicCode != null) 'publicCode': publicCode,
      'createdAt': createdAt.toJson(),
      'deadline': deadline.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SwapLoop',
      if (id != null) 'id': id,
      'exchangeId': exchangeId,
      'status': status.toJson(),
      'size': size,
      'score': score,
      'createdAt': createdAt.toJson(),
      'deadline': deadline.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  static SwapLoopInclude include() {
    return SwapLoopInclude._();
  }

  static SwapLoopIncludeList includeList({
    _is.WhereExpressionBuilder<SwapLoopTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SwapLoopTable>? orderBy,
    _is.OrderByListBuilder<SwapLoopTable>? orderByList,
    SwapLoopInclude? include,
  }) {
    return SwapLoopIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwapLoop.t),
      orderByList: orderByList?.call(SwapLoop.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SwapLoopImpl extends SwapLoop {
  _SwapLoopImpl({
    int? id,
    required int exchangeId,
    _ipcz1n71.LoopStatus? status,
    required int size,
    required double score,
    String? publicCode,
    DateTime? createdAt,
    required DateTime deadline,
    DateTime? resolvedAt,
  }) : super._(
         id: id,
         exchangeId: exchangeId,
         status: status,
         size: size,
         score: score,
         publicCode: publicCode,
         createdAt: createdAt,
         deadline: deadline,
         resolvedAt: resolvedAt,
       );

  /// Returns a shallow copy of this [SwapLoop]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SwapLoop copyWith({
    Object? id = _Undefined,
    int? exchangeId,
    _ipcz1n71.LoopStatus? status,
    int? size,
    double? score,
    Object? publicCode = _Undefined,
    DateTime? createdAt,
    DateTime? deadline,
    Object? resolvedAt = _Undefined,
  }) {
    return SwapLoop(
      id: id is int? ? id : this.id,
      exchangeId: exchangeId ?? this.exchangeId,
      status: status ?? this.status,
      size: size ?? this.size,
      score: score ?? this.score,
      publicCode: publicCode is String? ? publicCode : this.publicCode,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}

class SwapLoopUpdateTable extends _is.UpdateTable<SwapLoopTable> {
  SwapLoopUpdateTable(super.table);

  _is.ColumnValue<int, int> exchangeId(int value) => _is.ColumnValue(
    table.exchangeId,
    value,
  );

  _is.ColumnValue<_ipcz1n71.LoopStatus, _ipcz1n71.LoopStatus> status(
    _ipcz1n71.LoopStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> size(int value) => _is.ColumnValue(
    table.size,
    value,
  );

  _is.ColumnValue<double, double> score(double value) => _is.ColumnValue(
    table.score,
    value,
  );

  _is.ColumnValue<String, String> publicCode(String? value) => _is.ColumnValue(
    table.publicCode,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> deadline(DateTime value) =>
      _is.ColumnValue(
        table.deadline,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> resolvedAt(DateTime? value) =>
      _is.ColumnValue(
        table.resolvedAt,
        value,
      );
}

class SwapLoopTable extends _is.Table<int?> {
  SwapLoopTable({super.tableRelation}) : super(tableName: 'swap_loop') {
    updateTable = SwapLoopUpdateTable(this);
    exchangeId = _is.ColumnInt(
      'exchangeId',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    size = _is.ColumnInt(
      'size',
      this,
    );
    score = _is.ColumnDouble(
      'score',
      this,
    );
    publicCode = _is.ColumnString(
      'publicCode',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    deadline = _is.ColumnDateTime(
      'deadline',
      this,
    );
    resolvedAt = _is.ColumnDateTime(
      'resolvedAt',
      this,
    );
  }

  late final SwapLoopUpdateTable updateTable;

  late final _is.ColumnInt exchangeId;

  late final _is.ColumnEnum<_ipcz1n71.LoopStatus> status;

  late final _is.ColumnInt size;

  late final _is.ColumnDouble score;

  /// Public verification code, shown only once the loop is confirmed.
  late final _is.ColumnString publicCode;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime deadline;

  late final _is.ColumnDateTime resolvedAt;

  @override
  List<_is.Column> get columns => [
    id,
    exchangeId,
    status,
    size,
    score,
    publicCode,
    createdAt,
    deadline,
    resolvedAt,
  ];
}

class SwapLoopInclude extends _is.IncludeObject {
  SwapLoopInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SwapLoop.t;
}

class SwapLoopIncludeList extends _is.IncludeList {
  SwapLoopIncludeList._({
    _is.WhereExpressionBuilder<SwapLoopTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SwapLoop.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SwapLoop.t;
}

class SwapLoopRepository {
  const SwapLoopRepository._();

  /// Returns a list of [SwapLoop]s matching the given query parameters.
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
  Future<List<SwapLoop>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SwapLoopTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SwapLoopTable>? orderBy,
    _is.OrderByListBuilder<SwapLoopTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SwapLoop>(
      where: where?.call(SwapLoop.t),
      orderBy: orderBy?.call(SwapLoop.t),
      orderByList: orderByList?.call(SwapLoop.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SwapLoop] matching the given query parameters.
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
  Future<SwapLoop?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SwapLoopTable>? where,
    int? offset,
    _is.OrderByBuilder<SwapLoopTable>? orderBy,
    _is.OrderByListBuilder<SwapLoopTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SwapLoop>(
      where: where?.call(SwapLoop.t),
      orderBy: orderBy?.call(SwapLoop.t),
      orderByList: orderByList?.call(SwapLoop.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SwapLoop] by its [id] or null if no such row exists.
  Future<SwapLoop?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SwapLoop>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SwapLoop]s in the list and returns the inserted rows.
  ///
  /// The returned [SwapLoop]s will have their `id` fields set.
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
  Future<List<SwapLoop>> insert(
    _is.DatabaseSession session,
    List<SwapLoop> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SwapLoop>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SwapLoop] and returns the inserted row.
  ///
  /// The returned [SwapLoop] will have its `id` field set.
  Future<SwapLoop> insertRow(
    _is.DatabaseSession session,
    SwapLoop row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SwapLoop>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SwapLoop]s in the list and returns the resulting rows.
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
  /// The returned [SwapLoop]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SwapLoop>> upsert(
    _is.DatabaseSession session,
    List<SwapLoop> rows, {
    required _is.ColumnSelections<SwapLoopTable> conflictColumns,
    _is.ColumnSelections<SwapLoopTable>? updateColumns,
    _is.WhereExpressionBuilder<SwapLoopTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SwapLoop>(
      rows,
      conflictColumns: conflictColumns(SwapLoop.t),
      updateColumns: updateColumns?.call(SwapLoop.t),
      updateWhere: updateWhere?.call(SwapLoop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SwapLoop] and returns the resulting row.
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
  /// The returned [SwapLoop] will have its `id` field set.
  Future<SwapLoop?> upsertRow(
    _is.DatabaseSession session,
    SwapLoop row, {
    required _is.ColumnSelections<SwapLoopTable> conflictColumns,
    _is.ColumnSelections<SwapLoopTable>? updateColumns,
    _is.WhereExpressionBuilder<SwapLoopTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SwapLoop>(
      row,
      conflictColumns: conflictColumns(SwapLoop.t),
      updateColumns: updateColumns?.call(SwapLoop.t),
      updateWhere: updateWhere?.call(SwapLoop.t),
      transaction: transaction,
    );
  }

  /// Updates all [SwapLoop]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SwapLoop>> update(
    _is.DatabaseSession session,
    List<SwapLoop> rows, {
    _is.ColumnSelections<SwapLoopTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SwapLoop>(
      rows,
      columns: columns?.call(SwapLoop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SwapLoop]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SwapLoop> updateRow(
    _is.DatabaseSession session,
    SwapLoop row, {
    _is.ColumnSelections<SwapLoopTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SwapLoop>(
      row,
      columns: columns?.call(SwapLoop.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SwapLoop] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SwapLoop?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SwapLoopUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SwapLoop>(
      id,
      columnValues: columnValues(SwapLoop.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SwapLoop]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SwapLoop>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SwapLoopUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SwapLoopTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SwapLoopTable>? orderBy,
    _is.OrderByListBuilder<SwapLoopTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SwapLoop>(
      columnValues: columnValues(SwapLoop.t.updateTable),
      where: where(SwapLoop.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SwapLoop.t),
      orderByList: orderByList?.call(SwapLoop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SwapLoop]s in the list and returns the deleted rows.
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
  Future<List<SwapLoop>> delete(
    _is.DatabaseSession session,
    List<SwapLoop> rows, {
    _is.OrderByBuilder<SwapLoopTable>? orderBy,
    _is.OrderByListBuilder<SwapLoopTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SwapLoop>(
      rows,
      orderBy: orderBy?.call(SwapLoop.t),
      orderByList: orderByList?.call(SwapLoop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SwapLoop].
  Future<SwapLoop> deleteRow(
    _is.DatabaseSession session,
    SwapLoop row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SwapLoop>(
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
  Future<List<SwapLoop>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SwapLoopTable> where,
    _is.OrderByBuilder<SwapLoopTable>? orderBy,
    _is.OrderByListBuilder<SwapLoopTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SwapLoop>(
      where: where(SwapLoop.t),
      orderBy: orderBy?.call(SwapLoop.t),
      orderByList: orderByList?.call(SwapLoop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SwapLoopTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SwapLoop>(
      where: where?.call(SwapLoop.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SwapLoop] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SwapLoopTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SwapLoop>(
      where: where(SwapLoop.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
