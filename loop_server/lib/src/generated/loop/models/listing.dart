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
import '../../loop/models/listing_status.dart' as _i1kb3nit;
import '../../loop/models/place.dart' as _it93en99;

/// One member's request to move, within one exchange.
abstract class Listing
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Listing._({
    this.id,
    required this.memberId,
    required this.exchangeId,
    required this.currentPlaceId,
    this.currentPlace,
    required this.postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : yearsInPost = yearsInPost ?? 0,
       status = status ?? _i1kb3nit.ListingStatus.active,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Listing({
    int? id,
    required int memberId,
    required int exchangeId,
    required int currentPlaceId,
    _it93en99.Place? currentPlace,
    required String postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ListingImpl;

  factory Listing.fromJson(Map<String, dynamic> jsonSerialization) {
    return Listing(
      id: jsonSerialization['id'] as int?,
      memberId: jsonSerialization['memberId'] as int,
      exchangeId: jsonSerialization['exchangeId'] as int,
      currentPlaceId: jsonSerialization['currentPlaceId'] as int,
      currentPlace: jsonSerialization['currentPlace'] == null
          ? null
          : _iq3hot10.Protocol().deserialize<_it93en99.Place>(
              jsonSerialization['currentPlace'],
            ),
      postTitle: jsonSerialization['postTitle'] as String,
      yearsInPost: jsonSerialization['yearsInPost'] as int?,
      status: jsonSerialization['status'] == null
          ? null
          : _i1kb3nit.ListingStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ListingTable();

  static const db = ListingRepository._();

  @override
  int? id;

  int memberId;

  int exchangeId;

  int currentPlaceId;

  _it93en99.Place? currentPlace;

  /// e.g. "Primary Teacher, ZP School Kharadi".
  String postTitle;

  int yearsInPost;

  _i1kb3nit.ListingStatus status;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Listing]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Listing copyWith({
    int? id,
    int? memberId,
    int? exchangeId,
    int? currentPlaceId,
    _it93en99.Place? currentPlace,
    String? postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Listing',
      if (id != null) 'id': id,
      'memberId': memberId,
      'exchangeId': exchangeId,
      'currentPlaceId': currentPlaceId,
      if (currentPlace != null) 'currentPlace': currentPlace?.toJson(),
      'postTitle': postTitle,
      'yearsInPost': yearsInPost,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Listing',
      if (id != null) 'id': id,
      'memberId': memberId,
      'exchangeId': exchangeId,
      'currentPlaceId': currentPlaceId,
      if (currentPlace != null)
        'currentPlace': currentPlace?.toJsonForProtocol(),
      'postTitle': postTitle,
      'yearsInPost': yearsInPost,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ListingInclude include({_it93en99.PlaceInclude? currentPlace}) {
    return ListingInclude._(currentPlace: currentPlace);
  }

  static ListingIncludeList includeList({
    _is.WhereExpressionBuilder<ListingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ListingTable>? orderBy,
    _is.OrderByListBuilder<ListingTable>? orderByList,
    ListingInclude? include,
  }) {
    return ListingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Listing.t),
      orderByList: orderByList?.call(Listing.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ListingImpl extends Listing {
  _ListingImpl({
    int? id,
    required int memberId,
    required int exchangeId,
    required int currentPlaceId,
    _it93en99.Place? currentPlace,
    required String postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         memberId: memberId,
         exchangeId: exchangeId,
         currentPlaceId: currentPlaceId,
         currentPlace: currentPlace,
         postTitle: postTitle,
         yearsInPost: yearsInPost,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Listing]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Listing copyWith({
    Object? id = _Undefined,
    int? memberId,
    int? exchangeId,
    int? currentPlaceId,
    Object? currentPlace = _Undefined,
    String? postTitle,
    int? yearsInPost,
    _i1kb3nit.ListingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Listing(
      id: id is int? ? id : this.id,
      memberId: memberId ?? this.memberId,
      exchangeId: exchangeId ?? this.exchangeId,
      currentPlaceId: currentPlaceId ?? this.currentPlaceId,
      currentPlace: currentPlace is _it93en99.Place?
          ? currentPlace
          : this.currentPlace?.copyWith(),
      postTitle: postTitle ?? this.postTitle,
      yearsInPost: yearsInPost ?? this.yearsInPost,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ListingUpdateTable extends _is.UpdateTable<ListingTable> {
  ListingUpdateTable(super.table);

  _is.ColumnValue<int, int> memberId(int value) => _is.ColumnValue(
    table.memberId,
    value,
  );

  _is.ColumnValue<int, int> exchangeId(int value) => _is.ColumnValue(
    table.exchangeId,
    value,
  );

  _is.ColumnValue<int, int> currentPlaceId(int value) => _is.ColumnValue(
    table.currentPlaceId,
    value,
  );

  _is.ColumnValue<String, String> postTitle(String value) => _is.ColumnValue(
    table.postTitle,
    value,
  );

  _is.ColumnValue<int, int> yearsInPost(int value) => _is.ColumnValue(
    table.yearsInPost,
    value,
  );

  _is.ColumnValue<_i1kb3nit.ListingStatus, _i1kb3nit.ListingStatus> status(
    _i1kb3nit.ListingStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ListingTable extends _is.Table<int?> {
  ListingTable({super.tableRelation}) : super(tableName: 'listing') {
    updateTable = ListingUpdateTable(this);
    memberId = _is.ColumnInt(
      'memberId',
      this,
    );
    exchangeId = _is.ColumnInt(
      'exchangeId',
      this,
    );
    currentPlaceId = _is.ColumnInt(
      'currentPlaceId',
      this,
    );
    postTitle = _is.ColumnString(
      'postTitle',
      this,
    );
    yearsInPost = _is.ColumnInt(
      'yearsInPost',
      this,
      hasDefault: true,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final ListingUpdateTable updateTable;

  late final _is.ColumnInt memberId;

  late final _is.ColumnInt exchangeId;

  late final _is.ColumnInt currentPlaceId;

  _it93en99.PlaceTable? _currentPlace;

  /// e.g. "Primary Teacher, ZP School Kharadi".
  late final _is.ColumnString postTitle;

  late final _is.ColumnInt yearsInPost;

  late final _is.ColumnEnum<_i1kb3nit.ListingStatus> status;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _it93en99.PlaceTable get currentPlace {
    if (_currentPlace != null) return _currentPlace!;
    _currentPlace = _is.createRelationTable(
      relationFieldName: 'currentPlace',
      field: Listing.t.currentPlaceId,
      foreignField: _it93en99.Place.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _it93en99.PlaceTable(tableRelation: foreignTableRelation),
    );
    return _currentPlace!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    memberId,
    exchangeId,
    currentPlaceId,
    postTitle,
    yearsInPost,
    status,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'currentPlace') {
      return currentPlace;
    }
    return null;
  }
}

class ListingInclude extends _is.IncludeObject {
  ListingInclude._({_it93en99.PlaceInclude? currentPlace}) {
    _currentPlace = currentPlace;
  }

  _it93en99.PlaceInclude? _currentPlace;

  @override
  Map<String, _is.Include?> get includes => {'currentPlace': _currentPlace};

  @override
  _is.Table<int?> get table => Listing.t;
}

class ListingIncludeList extends _is.IncludeList {
  ListingIncludeList._({
    _is.WhereExpressionBuilder<ListingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Listing.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Listing.t;
}

class ListingRepository {
  const ListingRepository._();

  final attachRow = const ListingAttachRowRepository._();

  /// Returns a list of [Listing]s matching the given query parameters.
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
  Future<List<Listing>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ListingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ListingTable>? orderBy,
    _is.OrderByListBuilder<ListingTable>? orderByList,
    _is.Transaction? transaction,
    ListingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Listing>(
      where: where?.call(Listing.t),
      orderBy: orderBy?.call(Listing.t),
      orderByList: orderByList?.call(Listing.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Listing] matching the given query parameters.
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
  Future<Listing?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ListingTable>? where,
    int? offset,
    _is.OrderByBuilder<ListingTable>? orderBy,
    _is.OrderByListBuilder<ListingTable>? orderByList,
    _is.Transaction? transaction,
    ListingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Listing>(
      where: where?.call(Listing.t),
      orderBy: orderBy?.call(Listing.t),
      orderByList: orderByList?.call(Listing.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Listing] by its [id] or null if no such row exists.
  Future<Listing?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ListingInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Listing>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Listing]s in the list and returns the inserted rows.
  ///
  /// The returned [Listing]s will have their `id` fields set.
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
  Future<List<Listing>> insert(
    _is.DatabaseSession session,
    List<Listing> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Listing>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Listing] and returns the inserted row.
  ///
  /// The returned [Listing] will have its `id` field set.
  Future<Listing> insertRow(
    _is.DatabaseSession session,
    Listing row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Listing>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Listing]s in the list and returns the resulting rows.
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
  /// The returned [Listing]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Listing>> upsert(
    _is.DatabaseSession session,
    List<Listing> rows, {
    required _is.ColumnSelections<ListingTable> conflictColumns,
    _is.ColumnSelections<ListingTable>? updateColumns,
    _is.WhereExpressionBuilder<ListingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Listing>(
      rows,
      conflictColumns: conflictColumns(Listing.t),
      updateColumns: updateColumns?.call(Listing.t),
      updateWhere: updateWhere?.call(Listing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Listing] and returns the resulting row.
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
  /// The returned [Listing] will have its `id` field set.
  Future<Listing?> upsertRow(
    _is.DatabaseSession session,
    Listing row, {
    required _is.ColumnSelections<ListingTable> conflictColumns,
    _is.ColumnSelections<ListingTable>? updateColumns,
    _is.WhereExpressionBuilder<ListingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Listing>(
      row,
      conflictColumns: conflictColumns(Listing.t),
      updateColumns: updateColumns?.call(Listing.t),
      updateWhere: updateWhere?.call(Listing.t),
      transaction: transaction,
    );
  }

  /// Updates all [Listing]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Listing>> update(
    _is.DatabaseSession session,
    List<Listing> rows, {
    _is.ColumnSelections<ListingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Listing>(
      rows,
      columns: columns?.call(Listing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Listing]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Listing> updateRow(
    _is.DatabaseSession session,
    Listing row, {
    _is.ColumnSelections<ListingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Listing>(
      row,
      columns: columns?.call(Listing.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Listing] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Listing?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ListingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Listing>(
      id,
      columnValues: columnValues(Listing.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Listing]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Listing>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ListingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ListingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ListingTable>? orderBy,
    _is.OrderByListBuilder<ListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Listing>(
      columnValues: columnValues(Listing.t.updateTable),
      where: where(Listing.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Listing.t),
      orderByList: orderByList?.call(Listing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Listing]s in the list and returns the deleted rows.
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
  Future<List<Listing>> delete(
    _is.DatabaseSession session,
    List<Listing> rows, {
    _is.OrderByBuilder<ListingTable>? orderBy,
    _is.OrderByListBuilder<ListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Listing>(
      rows,
      orderBy: orderBy?.call(Listing.t),
      orderByList: orderByList?.call(Listing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Listing].
  Future<Listing> deleteRow(
    _is.DatabaseSession session,
    Listing row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Listing>(
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
  Future<List<Listing>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ListingTable> where,
    _is.OrderByBuilder<ListingTable>? orderBy,
    _is.OrderByListBuilder<ListingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Listing>(
      where: where(Listing.t),
      orderBy: orderBy?.call(Listing.t),
      orderByList: orderByList?.call(Listing.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ListingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Listing>(
      where: where?.call(Listing.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Listing] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ListingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Listing>(
      where: where(Listing.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ListingAttachRowRepository {
  const ListingAttachRowRepository._();

  /// Creates a relation between the given [Listing] and [Place]
  /// by setting the [Listing]'s foreign key `currentPlaceId` to refer to the [Place].
  Future<void> currentPlace(
    _is.DatabaseSession session,
    Listing listing,
    _it93en99.Place currentPlace, {
    _is.Transaction? transaction,
  }) async {
    if (listing.id == null) {
      throw ArgumentError.notNull('listing.id');
    }
    if (currentPlace.id == null) {
      throw ArgumentError.notNull('currentPlace.id');
    }

    var $listing = listing.copyWith(currentPlaceId: currentPlace.id);
    await session.db.updateRow<Listing>(
      $listing,
      columns: [Listing.t.currentPlaceId],
      transaction: transaction,
    );
  }
}
