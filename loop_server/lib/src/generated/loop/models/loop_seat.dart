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
import '../../loop/models/seat_response.dart' as _ih6s460s;

/// One member's position in a loop: they move from their posting to the
/// posting of the next seat.
abstract class LoopSeat
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  LoopSeat._({
    this.id,
    required this.loopId,
    required this.listingId,
    required this.memberId,
    required this.position,
    required this.fromPlaceId,
    required this.toPlaceId,
    required this.wishRank,
    required this.km,
    _ih6s460s.SeatResponse? response,
    this.respondedAt,
  }) : response = response ?? _ih6s460s.SeatResponse.pending;

  factory LoopSeat({
    int? id,
    required int loopId,
    required int listingId,
    required int memberId,
    required int position,
    required int fromPlaceId,
    required int toPlaceId,
    required int wishRank,
    required double km,
    _ih6s460s.SeatResponse? response,
    DateTime? respondedAt,
  }) = _LoopSeatImpl;

  factory LoopSeat.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoopSeat(
      id: jsonSerialization['id'] as int?,
      loopId: jsonSerialization['loopId'] as int,
      listingId: jsonSerialization['listingId'] as int,
      memberId: jsonSerialization['memberId'] as int,
      position: jsonSerialization['position'] as int,
      fromPlaceId: jsonSerialization['fromPlaceId'] as int,
      toPlaceId: jsonSerialization['toPlaceId'] as int,
      wishRank: jsonSerialization['wishRank'] as int,
      km: (jsonSerialization['km'] as num).toDouble(),
      response: jsonSerialization['response'] == null
          ? null
          : _ih6s460s.SeatResponse.fromJson(
              (jsonSerialization['response'] as String),
            ),
      respondedAt: jsonSerialization['respondedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['respondedAt'],
            ),
    );
  }

  static final t = LoopSeatTable();

  static const db = LoopSeatRepository._();

  @override
  int? id;

  int loopId;

  int listingId;

  int memberId;

  int position;

  int fromPlaceId;

  int toPlaceId;

  int wishRank;

  double km;

  _ih6s460s.SeatResponse response;

  DateTime? respondedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [LoopSeat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LoopSeat copyWith({
    int? id,
    int? loopId,
    int? listingId,
    int? memberId,
    int? position,
    int? fromPlaceId,
    int? toPlaceId,
    int? wishRank,
    double? km,
    _ih6s460s.SeatResponse? response,
    DateTime? respondedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoopSeat',
      if (id != null) 'id': id,
      'loopId': loopId,
      'listingId': listingId,
      'memberId': memberId,
      'position': position,
      'fromPlaceId': fromPlaceId,
      'toPlaceId': toPlaceId,
      'wishRank': wishRank,
      'km': km,
      'response': response.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LoopSeat',
      if (id != null) 'id': id,
      'loopId': loopId,
      'listingId': listingId,
      'memberId': memberId,
      'position': position,
      'fromPlaceId': fromPlaceId,
      'toPlaceId': toPlaceId,
      'wishRank': wishRank,
      'km': km,
      'response': response.toJson(),
      if (respondedAt != null) 'respondedAt': respondedAt?.toJson(),
    };
  }

  static LoopSeatInclude include() {
    return LoopSeatInclude._();
  }

  static LoopSeatIncludeList includeList({
    _is.WhereExpressionBuilder<LoopSeatTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LoopSeatTable>? orderBy,
    _is.OrderByListBuilder<LoopSeatTable>? orderByList,
    LoopSeatInclude? include,
  }) {
    return LoopSeatIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LoopSeat.t),
      orderByList: orderByList?.call(LoopSeat.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LoopSeatImpl extends LoopSeat {
  _LoopSeatImpl({
    int? id,
    required int loopId,
    required int listingId,
    required int memberId,
    required int position,
    required int fromPlaceId,
    required int toPlaceId,
    required int wishRank,
    required double km,
    _ih6s460s.SeatResponse? response,
    DateTime? respondedAt,
  }) : super._(
         id: id,
         loopId: loopId,
         listingId: listingId,
         memberId: memberId,
         position: position,
         fromPlaceId: fromPlaceId,
         toPlaceId: toPlaceId,
         wishRank: wishRank,
         km: km,
         response: response,
         respondedAt: respondedAt,
       );

  /// Returns a shallow copy of this [LoopSeat]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LoopSeat copyWith({
    Object? id = _Undefined,
    int? loopId,
    int? listingId,
    int? memberId,
    int? position,
    int? fromPlaceId,
    int? toPlaceId,
    int? wishRank,
    double? km,
    _ih6s460s.SeatResponse? response,
    Object? respondedAt = _Undefined,
  }) {
    return LoopSeat(
      id: id is int? ? id : this.id,
      loopId: loopId ?? this.loopId,
      listingId: listingId ?? this.listingId,
      memberId: memberId ?? this.memberId,
      position: position ?? this.position,
      fromPlaceId: fromPlaceId ?? this.fromPlaceId,
      toPlaceId: toPlaceId ?? this.toPlaceId,
      wishRank: wishRank ?? this.wishRank,
      km: km ?? this.km,
      response: response ?? this.response,
      respondedAt: respondedAt is DateTime? ? respondedAt : this.respondedAt,
    );
  }
}

class LoopSeatUpdateTable extends _is.UpdateTable<LoopSeatTable> {
  LoopSeatUpdateTable(super.table);

  _is.ColumnValue<int, int> loopId(int value) => _is.ColumnValue(
    table.loopId,
    value,
  );

  _is.ColumnValue<int, int> listingId(int value) => _is.ColumnValue(
    table.listingId,
    value,
  );

  _is.ColumnValue<int, int> memberId(int value) => _is.ColumnValue(
    table.memberId,
    value,
  );

  _is.ColumnValue<int, int> position(int value) => _is.ColumnValue(
    table.position,
    value,
  );

  _is.ColumnValue<int, int> fromPlaceId(int value) => _is.ColumnValue(
    table.fromPlaceId,
    value,
  );

  _is.ColumnValue<int, int> toPlaceId(int value) => _is.ColumnValue(
    table.toPlaceId,
    value,
  );

  _is.ColumnValue<int, int> wishRank(int value) => _is.ColumnValue(
    table.wishRank,
    value,
  );

  _is.ColumnValue<double, double> km(double value) => _is.ColumnValue(
    table.km,
    value,
  );

  _is.ColumnValue<_ih6s460s.SeatResponse, _ih6s460s.SeatResponse> response(
    _ih6s460s.SeatResponse value,
  ) => _is.ColumnValue(
    table.response,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> respondedAt(DateTime? value) =>
      _is.ColumnValue(
        table.respondedAt,
        value,
      );
}

class LoopSeatTable extends _is.Table<int?> {
  LoopSeatTable({super.tableRelation}) : super(tableName: 'loop_seat') {
    updateTable = LoopSeatUpdateTable(this);
    loopId = _is.ColumnInt(
      'loopId',
      this,
    );
    listingId = _is.ColumnInt(
      'listingId',
      this,
    );
    memberId = _is.ColumnInt(
      'memberId',
      this,
    );
    position = _is.ColumnInt(
      'position',
      this,
    );
    fromPlaceId = _is.ColumnInt(
      'fromPlaceId',
      this,
    );
    toPlaceId = _is.ColumnInt(
      'toPlaceId',
      this,
    );
    wishRank = _is.ColumnInt(
      'wishRank',
      this,
    );
    km = _is.ColumnDouble(
      'km',
      this,
    );
    response = _is.ColumnEnum(
      'response',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    respondedAt = _is.ColumnDateTime(
      'respondedAt',
      this,
    );
  }

  late final LoopSeatUpdateTable updateTable;

  late final _is.ColumnInt loopId;

  late final _is.ColumnInt listingId;

  late final _is.ColumnInt memberId;

  late final _is.ColumnInt position;

  late final _is.ColumnInt fromPlaceId;

  late final _is.ColumnInt toPlaceId;

  late final _is.ColumnInt wishRank;

  late final _is.ColumnDouble km;

  late final _is.ColumnEnum<_ih6s460s.SeatResponse> response;

  late final _is.ColumnDateTime respondedAt;

  @override
  List<_is.Column> get columns => [
    id,
    loopId,
    listingId,
    memberId,
    position,
    fromPlaceId,
    toPlaceId,
    wishRank,
    km,
    response,
    respondedAt,
  ];
}

class LoopSeatInclude extends _is.IncludeObject {
  LoopSeatInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => LoopSeat.t;
}

class LoopSeatIncludeList extends _is.IncludeList {
  LoopSeatIncludeList._({
    _is.WhereExpressionBuilder<LoopSeatTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LoopSeat.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => LoopSeat.t;
}

class LoopSeatRepository {
  const LoopSeatRepository._();

  /// Returns a list of [LoopSeat]s matching the given query parameters.
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
  Future<List<LoopSeat>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LoopSeatTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LoopSeatTable>? orderBy,
    _is.OrderByListBuilder<LoopSeatTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LoopSeat>(
      where: where?.call(LoopSeat.t),
      orderBy: orderBy?.call(LoopSeat.t),
      orderByList: orderByList?.call(LoopSeat.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LoopSeat] matching the given query parameters.
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
  Future<LoopSeat?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LoopSeatTable>? where,
    int? offset,
    _is.OrderByBuilder<LoopSeatTable>? orderBy,
    _is.OrderByListBuilder<LoopSeatTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LoopSeat>(
      where: where?.call(LoopSeat.t),
      orderBy: orderBy?.call(LoopSeat.t),
      orderByList: orderByList?.call(LoopSeat.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LoopSeat] by its [id] or null if no such row exists.
  Future<LoopSeat?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LoopSeat>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LoopSeat]s in the list and returns the inserted rows.
  ///
  /// The returned [LoopSeat]s will have their `id` fields set.
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
  Future<List<LoopSeat>> insert(
    _is.DatabaseSession session,
    List<LoopSeat> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<LoopSeat>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [LoopSeat] and returns the inserted row.
  ///
  /// The returned [LoopSeat] will have its `id` field set.
  Future<LoopSeat> insertRow(
    _is.DatabaseSession session,
    LoopSeat row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<LoopSeat>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [LoopSeat]s in the list and returns the resulting rows.
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
  /// The returned [LoopSeat]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LoopSeat>> upsert(
    _is.DatabaseSession session,
    List<LoopSeat> rows, {
    required _is.ColumnSelections<LoopSeatTable> conflictColumns,
    _is.ColumnSelections<LoopSeatTable>? updateColumns,
    _is.WhereExpressionBuilder<LoopSeatTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<LoopSeat>(
      rows,
      conflictColumns: conflictColumns(LoopSeat.t),
      updateColumns: updateColumns?.call(LoopSeat.t),
      updateWhere: updateWhere?.call(LoopSeat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [LoopSeat] and returns the resulting row.
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
  /// The returned [LoopSeat] will have its `id` field set.
  Future<LoopSeat?> upsertRow(
    _is.DatabaseSession session,
    LoopSeat row, {
    required _is.ColumnSelections<LoopSeatTable> conflictColumns,
    _is.ColumnSelections<LoopSeatTable>? updateColumns,
    _is.WhereExpressionBuilder<LoopSeatTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<LoopSeat>(
      row,
      conflictColumns: conflictColumns(LoopSeat.t),
      updateColumns: updateColumns?.call(LoopSeat.t),
      updateWhere: updateWhere?.call(LoopSeat.t),
      transaction: transaction,
    );
  }

  /// Updates all [LoopSeat]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LoopSeat>> update(
    _is.DatabaseSession session,
    List<LoopSeat> rows, {
    _is.ColumnSelections<LoopSeatTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<LoopSeat>(
      rows,
      columns: columns?.call(LoopSeat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [LoopSeat]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LoopSeat> updateRow(
    _is.DatabaseSession session,
    LoopSeat row, {
    _is.ColumnSelections<LoopSeatTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<LoopSeat>(
      row,
      columns: columns?.call(LoopSeat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LoopSeat] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LoopSeat?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<LoopSeatUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<LoopSeat>(
      id,
      columnValues: columnValues(LoopSeat.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LoopSeat]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<LoopSeat>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<LoopSeatUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<LoopSeatTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<LoopSeatTable>? orderBy,
    _is.OrderByListBuilder<LoopSeatTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<LoopSeat>(
      columnValues: columnValues(LoopSeat.t.updateTable),
      where: where(LoopSeat.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LoopSeat.t),
      orderByList: orderByList?.call(LoopSeat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [LoopSeat]s in the list and returns the deleted rows.
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
  Future<List<LoopSeat>> delete(
    _is.DatabaseSession session,
    List<LoopSeat> rows, {
    _is.OrderByBuilder<LoopSeatTable>? orderBy,
    _is.OrderByListBuilder<LoopSeatTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<LoopSeat>(
      rows,
      orderBy: orderBy?.call(LoopSeat.t),
      orderByList: orderByList?.call(LoopSeat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [LoopSeat].
  Future<LoopSeat> deleteRow(
    _is.DatabaseSession session,
    LoopSeat row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LoopSeat>(
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
  Future<List<LoopSeat>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LoopSeatTable> where,
    _is.OrderByBuilder<LoopSeatTable>? orderBy,
    _is.OrderByListBuilder<LoopSeatTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<LoopSeat>(
      where: where(LoopSeat.t),
      orderBy: orderBy?.call(LoopSeat.t),
      orderByList: orderByList?.call(LoopSeat.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<LoopSeatTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<LoopSeat>(
      where: where?.call(LoopSeat.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LoopSeat] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<LoopSeatTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LoopSeat>(
      where: where(LoopSeat.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
