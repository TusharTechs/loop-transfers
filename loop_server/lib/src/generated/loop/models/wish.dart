/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:loop_server/src/generated/protocol.dart' as _iq3hot10;
import 'package:serverpod/serverpod.dart' as _is;
import '../../loop/models/place.dart' as _it93en99;

/// "Exactly this district" (radiusKm = 0) or "anywhere within radiusKm of it".
abstract class Wish implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Wish._({
    this.id,
    required this.listingId,
    required this.placeId,
    this.place,
    int? radiusKm,
    required this.rank,
    this.point,
  }) : radiusKm = radiusKm ?? 0;

  factory Wish({
    int? id,
    required int listingId,
    required int placeId,
    _it93en99.Place? place,
    int? radiusKm,
    required int rank,
    _is.GeographyPoint? point,
  }) = _WishImpl;

  factory Wish.fromJson(Map<String, dynamic> jsonSerialization) {
    return Wish(
      id: jsonSerialization['id'] as int?,
      listingId: jsonSerialization['listingId'] as int,
      placeId: jsonSerialization['placeId'] as int,
      place: jsonSerialization['place'] == null
          ? null
          : _iq3hot10.Protocol().deserialize<_it93en99.Place>(
              jsonSerialization['place'],
            ),
      radiusKm: jsonSerialization['radiusKm'] as int?,
      rank: jsonSerialization['rank'] as int,
      point: jsonSerialization['point'] == null
          ? null
          : _is.GeographyPointJsonExtension.fromJson(
              jsonSerialization['point'],
            ),
    );
  }

  static final t = WishTable();

  static const db = WishRepository._();

  @override
  int? id;

  int listingId;

  int placeId;

  _it93en99.Place? place;

  int radiusKm;

  /// 0 = first choice.
  int rank;

  /// Copy of the place's point, so edge building is one spatial join.
  _is.GeographyPoint? point;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Wish]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Wish copyWith({
    int? id,
    int? listingId,
    int? placeId,
    _it93en99.Place? place,
    int? radiusKm,
    int? rank,
    _is.GeographyPoint? point,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Wish',
      if (id != null) 'id': id,
      'listingId': listingId,
      'placeId': placeId,
      if (place != null) 'place': place?.toJson(),
      'radiusKm': radiusKm,
      'rank': rank,
      if (point != null) 'point': point?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Wish',
      if (id != null) 'id': id,
      'listingId': listingId,
      'placeId': placeId,
      if (place != null) 'place': place?.toJsonForProtocol(),
      'radiusKm': radiusKm,
      'rank': rank,
    };
  }

  static WishInclude include({_it93en99.PlaceInclude? place}) {
    return WishInclude._(place: place);
  }

  static WishIncludeList includeList({
    _is.WhereExpressionBuilder<WishTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WishTable>? orderBy,
    _is.OrderByListBuilder<WishTable>? orderByList,
    WishInclude? include,
  }) {
    return WishIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Wish.t),
      orderByList: orderByList?.call(Wish.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WishImpl extends Wish {
  _WishImpl({
    int? id,
    required int listingId,
    required int placeId,
    _it93en99.Place? place,
    int? radiusKm,
    required int rank,
    _is.GeographyPoint? point,
  }) : super._(
         id: id,
         listingId: listingId,
         placeId: placeId,
         place: place,
         radiusKm: radiusKm,
         rank: rank,
         point: point,
       );

  /// Returns a shallow copy of this [Wish]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Wish copyWith({
    Object? id = _Undefined,
    int? listingId,
    int? placeId,
    Object? place = _Undefined,
    int? radiusKm,
    int? rank,
    Object? point = _Undefined,
  }) {
    return Wish(
      id: id is int? ? id : this.id,
      listingId: listingId ?? this.listingId,
      placeId: placeId ?? this.placeId,
      place: place is _it93en99.Place? ? place : this.place?.copyWith(),
      radiusKm: radiusKm ?? this.radiusKm,
      rank: rank ?? this.rank,
      point: point is _is.GeographyPoint? ? point : this.point,
    );
  }
}

class WishUpdateTable extends _is.UpdateTable<WishTable> {
  WishUpdateTable(super.table);

  _is.ColumnValue<int, int> listingId(int value) => _is.ColumnValue(
    table.listingId,
    value,
  );

  _is.ColumnValue<int, int> placeId(int value) => _is.ColumnValue(
    table.placeId,
    value,
  );

  _is.ColumnValue<int, int> radiusKm(int value) => _is.ColumnValue(
    table.radiusKm,
    value,
  );

  _is.ColumnValue<int, int> rank(int value) => _is.ColumnValue(
    table.rank,
    value,
  );

  _is.ColumnValue<_is.GeographyPoint, _is.GeographyPoint> point(
    _is.GeographyPoint? value,
  ) => _is.ColumnValue(
    table.point,
    value,
  );
}

class WishTable extends _is.Table<int?> {
  WishTable({super.tableRelation}) : super(tableName: 'wish') {
    updateTable = WishUpdateTable(this);
    listingId = _is.ColumnInt(
      'listingId',
      this,
    );
    placeId = _is.ColumnInt(
      'placeId',
      this,
    );
    radiusKm = _is.ColumnInt(
      'radiusKm',
      this,
      hasDefault: true,
    );
    rank = _is.ColumnInt(
      'rank',
      this,
    );
    point = _is.ColumnGeographyPoint(
      'point',
      this,
    );
  }

  late final WishUpdateTable updateTable;

  late final _is.ColumnInt listingId;

  late final _is.ColumnInt placeId;

  _it93en99.PlaceTable? _place;

  late final _is.ColumnInt radiusKm;

  /// 0 = first choice.
  late final _is.ColumnInt rank;

  /// Copy of the place's point, so edge building is one spatial join.
  late final _is.ColumnGeographyPoint point;

  _it93en99.PlaceTable get place {
    if (_place != null) return _place!;
    _place = _is.createRelationTable(
      relationFieldName: 'place',
      field: Wish.t.placeId,
      foreignField: _it93en99.Place.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _it93en99.PlaceTable(tableRelation: foreignTableRelation),
    );
    return _place!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    listingId,
    placeId,
    radiusKm,
    rank,
    point,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'place') {
      return place;
    }
    return null;
  }
}

class WishInclude extends _is.IncludeObject {
  WishInclude._({_it93en99.PlaceInclude? place}) {
    _place = place;
  }

  _it93en99.PlaceInclude? _place;

  @override
  Map<String, _is.Include?> get includes => {'place': _place};

  @override
  _is.Table<int?> get table => Wish.t;
}

class WishIncludeList extends _is.IncludeList {
  WishIncludeList._({
    _is.WhereExpressionBuilder<WishTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Wish.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Wish.t;
}

class WishRepository {
  const WishRepository._();

  final attachRow = const WishAttachRowRepository._();

  /// Returns a list of [Wish]s matching the given query parameters.
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
  Future<List<Wish>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WishTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WishTable>? orderBy,
    _is.OrderByListBuilder<WishTable>? orderByList,
    _is.Transaction? transaction,
    WishInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Wish>(
      where: where?.call(Wish.t),
      orderBy: orderBy?.call(Wish.t),
      orderByList: orderByList?.call(Wish.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Wish] matching the given query parameters.
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
  Future<Wish?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WishTable>? where,
    int? offset,
    _is.OrderByBuilder<WishTable>? orderBy,
    _is.OrderByListBuilder<WishTable>? orderByList,
    _is.Transaction? transaction,
    WishInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Wish>(
      where: where?.call(Wish.t),
      orderBy: orderBy?.call(Wish.t),
      orderByList: orderByList?.call(Wish.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Wish] by its [id] or null if no such row exists.
  Future<Wish?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    WishInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Wish>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Wish]s in the list and returns the inserted rows.
  ///
  /// The returned [Wish]s will have their `id` fields set.
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
  Future<List<Wish>> insert(
    _is.DatabaseSession session,
    List<Wish> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Wish>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Wish] and returns the inserted row.
  ///
  /// The returned [Wish] will have its `id` field set.
  Future<Wish> insertRow(
    _is.DatabaseSession session,
    Wish row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Wish>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Wish]s in the list and returns the resulting rows.
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
  /// The returned [Wish]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Wish>> upsert(
    _is.DatabaseSession session,
    List<Wish> rows, {
    required _is.ColumnSelections<WishTable> conflictColumns,
    _is.ColumnSelections<WishTable>? updateColumns,
    _is.WhereExpressionBuilder<WishTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Wish>(
      rows,
      conflictColumns: conflictColumns(Wish.t),
      updateColumns: updateColumns?.call(Wish.t),
      updateWhere: updateWhere?.call(Wish.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Wish] and returns the resulting row.
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
  /// The returned [Wish] will have its `id` field set.
  Future<Wish?> upsertRow(
    _is.DatabaseSession session,
    Wish row, {
    required _is.ColumnSelections<WishTable> conflictColumns,
    _is.ColumnSelections<WishTable>? updateColumns,
    _is.WhereExpressionBuilder<WishTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Wish>(
      row,
      conflictColumns: conflictColumns(Wish.t),
      updateColumns: updateColumns?.call(Wish.t),
      updateWhere: updateWhere?.call(Wish.t),
      transaction: transaction,
    );
  }

  /// Updates all [Wish]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Wish>> update(
    _is.DatabaseSession session,
    List<Wish> rows, {
    _is.ColumnSelections<WishTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Wish>(
      rows,
      columns: columns?.call(Wish.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Wish]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Wish> updateRow(
    _is.DatabaseSession session,
    Wish row, {
    _is.ColumnSelections<WishTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Wish>(
      row,
      columns: columns?.call(Wish.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Wish] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Wish?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<WishUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Wish>(
      id,
      columnValues: columnValues(Wish.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Wish]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Wish>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<WishUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<WishTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<WishTable>? orderBy,
    _is.OrderByListBuilder<WishTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Wish>(
      columnValues: columnValues(Wish.t.updateTable),
      where: where(Wish.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Wish.t),
      orderByList: orderByList?.call(Wish.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Wish]s in the list and returns the deleted rows.
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
  Future<List<Wish>> delete(
    _is.DatabaseSession session,
    List<Wish> rows, {
    _is.OrderByBuilder<WishTable>? orderBy,
    _is.OrderByListBuilder<WishTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Wish>(
      rows,
      orderBy: orderBy?.call(Wish.t),
      orderByList: orderByList?.call(Wish.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Wish].
  Future<Wish> deleteRow(
    _is.DatabaseSession session,
    Wish row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Wish>(
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
  Future<List<Wish>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WishTable> where,
    _is.OrderByBuilder<WishTable>? orderBy,
    _is.OrderByListBuilder<WishTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Wish>(
      where: where(Wish.t),
      orderBy: orderBy?.call(Wish.t),
      orderByList: orderByList?.call(Wish.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<WishTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Wish>(
      where: where?.call(Wish.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Wish] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<WishTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Wish>(
      where: where(Wish.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class WishAttachRowRepository {
  const WishAttachRowRepository._();

  /// Creates a relation between the given [Wish] and [Place]
  /// by setting the [Wish]'s foreign key `placeId` to refer to the [Place].
  Future<void> place(
    _is.DatabaseSession session,
    Wish wish,
    _it93en99.Place place, {
    _is.Transaction? transaction,
  }) async {
    if (wish.id == null) {
      throw ArgumentError.notNull('wish.id');
    }
    if (place.id == null) {
      throw ArgumentError.notNull('place.id');
    }

    var $wish = wish.copyWith(placeId: place.id);
    await session.db.updateRow<Wish>(
      $wish,
      columns: [Wish.t.placeId],
      transaction: transaction,
    );
  }
}
