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

/// Never propose this move again: the member behind fromListing declined
/// taking the posting of toListing.
abstract class DeclinedEdge
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DeclinedEdge._({
    this.id,
    required this.fromListingId,
    required this.toListingId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory DeclinedEdge({
    int? id,
    required int fromListingId,
    required int toListingId,
    DateTime? createdAt,
  }) = _DeclinedEdgeImpl;

  factory DeclinedEdge.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeclinedEdge(
      id: jsonSerialization['id'] as int?,
      fromListingId: jsonSerialization['fromListingId'] as int,
      toListingId: jsonSerialization['toListingId'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = DeclinedEdgeTable();

  static const db = DeclinedEdgeRepository._();

  @override
  int? id;

  int fromListingId;

  int toListingId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DeclinedEdge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DeclinedEdge copyWith({
    int? id,
    int? fromListingId,
    int? toListingId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeclinedEdge',
      if (id != null) 'id': id,
      'fromListingId': fromListingId,
      'toListingId': toListingId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static DeclinedEdgeInclude include() {
    return DeclinedEdgeInclude._();
  }

  static DeclinedEdgeIncludeList includeList({
    _is.WhereExpressionBuilder<DeclinedEdgeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DeclinedEdgeTable>? orderBy,
    _is.OrderByListBuilder<DeclinedEdgeTable>? orderByList,
    DeclinedEdgeInclude? include,
  }) {
    return DeclinedEdgeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeclinedEdge.t),
      orderByList: orderByList?.call(DeclinedEdge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeclinedEdgeImpl extends DeclinedEdge {
  _DeclinedEdgeImpl({
    int? id,
    required int fromListingId,
    required int toListingId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         fromListingId: fromListingId,
         toListingId: toListingId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DeclinedEdge]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DeclinedEdge copyWith({
    Object? id = _Undefined,
    int? fromListingId,
    int? toListingId,
    DateTime? createdAt,
  }) {
    return DeclinedEdge(
      id: id is int? ? id : this.id,
      fromListingId: fromListingId ?? this.fromListingId,
      toListingId: toListingId ?? this.toListingId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DeclinedEdgeUpdateTable extends _is.UpdateTable<DeclinedEdgeTable> {
  DeclinedEdgeUpdateTable(super.table);

  _is.ColumnValue<int, int> fromListingId(int value) => _is.ColumnValue(
    table.fromListingId,
    value,
  );

  _is.ColumnValue<int, int> toListingId(int value) => _is.ColumnValue(
    table.toListingId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class DeclinedEdgeTable extends _is.Table<int?> {
  DeclinedEdgeTable({super.tableRelation}) : super(tableName: 'declined_edge') {
    updateTable = DeclinedEdgeUpdateTable(this);
    fromListingId = _is.ColumnInt(
      'fromListingId',
      this,
    );
    toListingId = _is.ColumnInt(
      'toListingId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final DeclinedEdgeUpdateTable updateTable;

  late final _is.ColumnInt fromListingId;

  late final _is.ColumnInt toListingId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    fromListingId,
    toListingId,
    createdAt,
  ];
}

class DeclinedEdgeInclude extends _is.IncludeObject {
  DeclinedEdgeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DeclinedEdge.t;
}

class DeclinedEdgeIncludeList extends _is.IncludeList {
  DeclinedEdgeIncludeList._({
    _is.WhereExpressionBuilder<DeclinedEdgeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DeclinedEdge.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DeclinedEdge.t;
}

class DeclinedEdgeRepository {
  const DeclinedEdgeRepository._();

  /// Returns a list of [DeclinedEdge]s matching the given query parameters.
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
  Future<List<DeclinedEdge>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DeclinedEdgeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DeclinedEdgeTable>? orderBy,
    _is.OrderByListBuilder<DeclinedEdgeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DeclinedEdge>(
      where: where?.call(DeclinedEdge.t),
      orderBy: orderBy?.call(DeclinedEdge.t),
      orderByList: orderByList?.call(DeclinedEdge.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DeclinedEdge] matching the given query parameters.
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
  Future<DeclinedEdge?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DeclinedEdgeTable>? where,
    int? offset,
    _is.OrderByBuilder<DeclinedEdgeTable>? orderBy,
    _is.OrderByListBuilder<DeclinedEdgeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DeclinedEdge>(
      where: where?.call(DeclinedEdge.t),
      orderBy: orderBy?.call(DeclinedEdge.t),
      orderByList: orderByList?.call(DeclinedEdge.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DeclinedEdge] by its [id] or null if no such row exists.
  Future<DeclinedEdge?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DeclinedEdge>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DeclinedEdge]s in the list and returns the inserted rows.
  ///
  /// The returned [DeclinedEdge]s will have their `id` fields set.
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
  Future<List<DeclinedEdge>> insert(
    _is.DatabaseSession session,
    List<DeclinedEdge> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DeclinedEdge>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DeclinedEdge] and returns the inserted row.
  ///
  /// The returned [DeclinedEdge] will have its `id` field set.
  Future<DeclinedEdge> insertRow(
    _is.DatabaseSession session,
    DeclinedEdge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DeclinedEdge>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DeclinedEdge]s in the list and returns the resulting rows.
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
  /// The returned [DeclinedEdge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DeclinedEdge>> upsert(
    _is.DatabaseSession session,
    List<DeclinedEdge> rows, {
    required _is.ColumnSelections<DeclinedEdgeTable> conflictColumns,
    _is.ColumnSelections<DeclinedEdgeTable>? updateColumns,
    _is.WhereExpressionBuilder<DeclinedEdgeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DeclinedEdge>(
      rows,
      conflictColumns: conflictColumns(DeclinedEdge.t),
      updateColumns: updateColumns?.call(DeclinedEdge.t),
      updateWhere: updateWhere?.call(DeclinedEdge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DeclinedEdge] and returns the resulting row.
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
  /// The returned [DeclinedEdge] will have its `id` field set.
  Future<DeclinedEdge?> upsertRow(
    _is.DatabaseSession session,
    DeclinedEdge row, {
    required _is.ColumnSelections<DeclinedEdgeTable> conflictColumns,
    _is.ColumnSelections<DeclinedEdgeTable>? updateColumns,
    _is.WhereExpressionBuilder<DeclinedEdgeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DeclinedEdge>(
      row,
      conflictColumns: conflictColumns(DeclinedEdge.t),
      updateColumns: updateColumns?.call(DeclinedEdge.t),
      updateWhere: updateWhere?.call(DeclinedEdge.t),
      transaction: transaction,
    );
  }

  /// Updates all [DeclinedEdge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DeclinedEdge>> update(
    _is.DatabaseSession session,
    List<DeclinedEdge> rows, {
    _is.ColumnSelections<DeclinedEdgeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DeclinedEdge>(
      rows,
      columns: columns?.call(DeclinedEdge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DeclinedEdge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DeclinedEdge> updateRow(
    _is.DatabaseSession session,
    DeclinedEdge row, {
    _is.ColumnSelections<DeclinedEdgeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DeclinedEdge>(
      row,
      columns: columns?.call(DeclinedEdge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DeclinedEdge] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DeclinedEdge?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DeclinedEdgeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DeclinedEdge>(
      id,
      columnValues: columnValues(DeclinedEdge.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DeclinedEdge]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DeclinedEdge>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DeclinedEdgeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DeclinedEdgeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DeclinedEdgeTable>? orderBy,
    _is.OrderByListBuilder<DeclinedEdgeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DeclinedEdge>(
      columnValues: columnValues(DeclinedEdge.t.updateTable),
      where: where(DeclinedEdge.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DeclinedEdge.t),
      orderByList: orderByList?.call(DeclinedEdge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DeclinedEdge]s in the list and returns the deleted rows.
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
  Future<List<DeclinedEdge>> delete(
    _is.DatabaseSession session,
    List<DeclinedEdge> rows, {
    _is.OrderByBuilder<DeclinedEdgeTable>? orderBy,
    _is.OrderByListBuilder<DeclinedEdgeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DeclinedEdge>(
      rows,
      orderBy: orderBy?.call(DeclinedEdge.t),
      orderByList: orderByList?.call(DeclinedEdge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DeclinedEdge].
  Future<DeclinedEdge> deleteRow(
    _is.DatabaseSession session,
    DeclinedEdge row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DeclinedEdge>(
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
  Future<List<DeclinedEdge>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DeclinedEdgeTable> where,
    _is.OrderByBuilder<DeclinedEdgeTable>? orderBy,
    _is.OrderByListBuilder<DeclinedEdgeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DeclinedEdge>(
      where: where(DeclinedEdge.t),
      orderBy: orderBy?.call(DeclinedEdge.t),
      orderByList: orderByList?.call(DeclinedEdge.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DeclinedEdgeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DeclinedEdge>(
      where: where?.call(DeclinedEdge.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DeclinedEdge] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DeclinedEdgeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DeclinedEdge>(
      where: where(DeclinedEdge.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
