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
import '../../loop/models/loop_event_kind.dart' as _i66as2so;

/// Audit timeline of a loop.
abstract class LoopEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  LoopEvent._({
    this.id,
    required this.loopId,
    required this.kind,
    this.seatPosition,
    DateTime? at,
  }) : at = at ?? DateTime.now();

  factory LoopEvent({
    int? id,
    required int loopId,
    required _i66as2so.LoopEventKind kind,
    int? seatPosition,
    DateTime? at,
  }) = _LoopEventImpl;

  factory LoopEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoopEvent(
      id: jsonSerialization['id'] as int?,
      loopId: jsonSerialization['loopId'] as int,
      kind: _i66as2so.LoopEventKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      seatPosition: jsonSerialization['seatPosition'] as int?,
      at: jsonSerialization['at'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['at']),
    );
  }

  static final t = LoopEventTable();

  static const db = LoopEventRepository._();

  @override
  int? id;

  int loopId;

  _i66as2so.LoopEventKind kind;

  int? seatPosition;

  DateTime at;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [LoopEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LoopEvent copyWith({
    int? id,
    int? loopId,
    _i66as2so.LoopEventKind? kind,
    int? seatPosition,
    DateTime? at,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoopEvent',
      if (id != null) 'id': id,
      'loopId': loopId,
      'kind': kind.toJson(),
      if (seatPosition != null) 'seatPosition': seatPosition,
      'at': at.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LoopEvent',
      if (id != null) 'id': id,
      'loopId': loopId,
      'kind': kind.toJson(),
      if (seatPosition != null) 'seatPosition': seatPosition,
      'at': at.toJson(),
    };
  }

  static LoopEventInclude include() {
    return LoopEventInclude._();
  }

  static LoopEventIncludeList includeList({
    _is.WhereExpressionBuilder<LoopEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LoopEventTable>? orderBy,
    _is.OrderByListBuilder<LoopEventTable>? orderByList,
    LoopEventInclude? include,
  }) {
    return LoopEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LoopEvent.t),
      orderByList: orderByList?.call(LoopEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LoopEventImpl extends LoopEvent {
  _LoopEventImpl({
    int? id,
    required int loopId,
    required _i66as2so.LoopEventKind kind,
    int? seatPosition,
    DateTime? at,
  }) : super._(
         id: id,
         loopId: loopId,
         kind: kind,
         seatPosition: seatPosition,
         at: at,
       );

  /// Returns a shallow copy of this [LoopEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LoopEvent copyWith({
    Object? id = _Undefined,
    int? loopId,
    _i66as2so.LoopEventKind? kind,
    Object? seatPosition = _Undefined,
    DateTime? at,
  }) {
    return LoopEvent(
      id: id is int? ? id : this.id,
      loopId: loopId ?? this.loopId,
      kind: kind ?? this.kind,
      seatPosition: seatPosition is int? ? seatPosition : this.seatPosition,
      at: at ?? this.at,
    );
  }
}

class LoopEventUpdateTable extends _is.UpdateTable<LoopEventTable> {
  LoopEventUpdateTable(super.table);

  _is.ColumnValue<int, int> loopId(int value) => _is.ColumnValue(
    table.loopId,
    value,
  );

  _is.ColumnValue<_i66as2so.LoopEventKind, _i66as2so.LoopEventKind> kind(
    _i66as2so.LoopEventKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<int, int> seatPosition(int? value) => _is.ColumnValue(
    table.seatPosition,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> at(DateTime value) => _is.ColumnValue(
    table.at,
    value,
  );
}

class LoopEventTable extends _is.Table<int?> {
  LoopEventTable({super.tableRelation}) : super(tableName: 'loop_event') {
    updateTable = LoopEventUpdateTable(this);
    loopId = _is.ColumnInt(
      'loopId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    seatPosition = _is.ColumnInt(
      'seatPosition',
      this,
    );
    at = _is.ColumnDateTime(
      'at',
      this,
      hasDefault: true,
    );
  }

  late final LoopEventUpdateTable updateTable;

  late final _is.ColumnInt loopId;

  late final _is.ColumnEnum<_i66as2so.LoopEventKind> kind;

  late final _is.ColumnInt seatPosition;

  late final _is.ColumnDateTime at;

  @override
  List<_is.Column> get columns => [
    id,
    loopId,
    kind,
    seatPosition,
    at,
  ];
}

class LoopEventInclude extends _is.IncludeObject {
  LoopEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => LoopEvent.t;
}

class LoopEventIncludeList extends _is.IncludeList {
  LoopEventIncludeList._({
    _is.WhereExpressionBuilder<LoopEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LoopEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => LoopEvent.t;
}

class LoopEventRepository {
  const LoopEventRepository._();

  /// Returns a list of [LoopEvent]s matching the given query parameters.
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
  Future<List<LoopEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LoopEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LoopEventTable>? orderBy,
    _is.OrderByListBuilder<LoopEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LoopEvent>(
      where: where?.call(LoopEvent.t),
      orderBy: orderBy?.call(LoopEvent.t),
      orderByList: orderByList?.call(LoopEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LoopEvent] matching the given query parameters.
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
  Future<LoopEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LoopEventTable>? where,
    int? offset,
    _is.OrderByBuilder<LoopEventTable>? orderBy,
    _is.OrderByListBuilder<LoopEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LoopEvent>(
      where: where?.call(LoopEvent.t),
      orderBy: orderBy?.call(LoopEvent.t),
      orderByList: orderByList?.call(LoopEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LoopEvent] by its [id] or null if no such row exists.
  Future<LoopEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LoopEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LoopEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [LoopEvent]s will have their `id` fields set.
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
  Future<List<LoopEvent>> insert(
    _is.DatabaseSession session,
    List<LoopEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LoopEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LoopEvent] and returns the inserted row.
  ///
  /// The returned [LoopEvent] will have its `id` field set.
  Future<LoopEvent> insertRow(
    _is.DatabaseSession session,
    LoopEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LoopEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LoopEvent]s in the list and returns the resulting rows.
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
  /// The returned [LoopEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LoopEvent>> upsert(
    _is.DatabaseSession session,
    List<LoopEvent> rows, {
    required _is.ColumnSelections<LoopEventTable> conflictColumns,
    _is.ColumnSelections<LoopEventTable>? updateColumns,
    _is.WhereExpressionBuilder<LoopEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LoopEvent>(
      rows,
      conflictColumns: conflictColumns(LoopEvent.t),
      updateColumns: updateColumns?.call(LoopEvent.t),
      updateWhere: updateWhere?.call(LoopEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LoopEvent] and returns the resulting row.
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
  /// The returned [LoopEvent] will have its `id` field set.
  Future<LoopEvent?> upsertRow(
    _is.DatabaseSession session,
    LoopEvent row, {
    required _is.ColumnSelections<LoopEventTable> conflictColumns,
    _is.ColumnSelections<LoopEventTable>? updateColumns,
    _is.WhereExpressionBuilder<LoopEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LoopEvent>(
      row,
      conflictColumns: conflictColumns(LoopEvent.t),
      updateColumns: updateColumns?.call(LoopEvent.t),
      updateWhere: updateWhere?.call(LoopEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [LoopEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LoopEvent>> update(
    _is.DatabaseSession session,
    List<LoopEvent> rows, {
    _is.ColumnSelections<LoopEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LoopEvent>(
      rows,
      columns: columns?.call(LoopEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LoopEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LoopEvent> updateRow(
    _is.DatabaseSession session,
    LoopEvent row, {
    _is.ColumnSelections<LoopEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LoopEvent>(
      row,
      columns: columns?.call(LoopEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LoopEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LoopEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LoopEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LoopEvent>(
      id,
      columnValues: columnValues(LoopEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LoopEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LoopEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LoopEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LoopEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LoopEventTable>? orderBy,
    _is.OrderByListBuilder<LoopEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LoopEvent>(
      columnValues: columnValues(LoopEvent.t.updateTable),
      where: where(LoopEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LoopEvent.t),
      orderByList: orderByList?.call(LoopEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LoopEvent]s in the list and returns the deleted rows.
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
  Future<List<LoopEvent>> delete(
    _is.DatabaseSession session,
    List<LoopEvent> rows, {
    _is.OrderByBuilder<LoopEventTable>? orderBy,
    _is.OrderByListBuilder<LoopEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LoopEvent>(
      rows,
      orderBy: orderBy?.call(LoopEvent.t),
      orderByList: orderByList?.call(LoopEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LoopEvent].
  Future<LoopEvent> deleteRow(
    _is.DatabaseSession session,
    LoopEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LoopEvent>(
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
  Future<List<LoopEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LoopEventTable> where,
    _is.OrderByBuilder<LoopEventTable>? orderBy,
    _is.OrderByListBuilder<LoopEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LoopEvent>(
      where: where(LoopEvent.t),
      orderBy: orderBy?.call(LoopEvent.t),
      orderByList: orderByList?.call(LoopEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LoopEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LoopEvent>(
      where: where?.call(LoopEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LoopEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LoopEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LoopEvent>(
      where: where(LoopEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
