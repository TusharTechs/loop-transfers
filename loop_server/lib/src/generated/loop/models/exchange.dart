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

/// A pool in which swaps are legal: the same cadre, post and grade.
abstract class Exchange
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Exchange._({
    this.id,
    required this.slug,
    required this.name,
    required this.cadre,
    required this.scope,
    this.state,
    required this.description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  }) : maxLoopSize = maxLoopSize ?? 4,
       acceptWindowMinutes = acceptWindowMinutes ?? 2880,
       isSandbox = isSandbox ?? false,
       isSimulated = isSimulated ?? false;

  factory Exchange({
    int? id,
    required String slug,
    required String name,
    required String cadre,
    required String scope,
    String? state,
    required String description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  }) = _ExchangeImpl;

  factory Exchange.fromJson(Map<String, dynamic> jsonSerialization) {
    return Exchange(
      id: jsonSerialization['id'] as int?,
      slug: jsonSerialization['slug'] as String,
      name: jsonSerialization['name'] as String,
      cadre: jsonSerialization['cadre'] as String,
      scope: jsonSerialization['scope'] as String,
      state: jsonSerialization['state'] as String?,
      description: jsonSerialization['description'] as String,
      maxLoopSize: jsonSerialization['maxLoopSize'] as int?,
      acceptWindowMinutes: jsonSerialization['acceptWindowMinutes'] as int?,
      isSandbox: jsonSerialization['isSandbox'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isSandbox']),
      isSimulated: jsonSerialization['isSimulated'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isSimulated']),
    );
  }

  static final t = ExchangeTable();

  static const db = ExchangeRepository._();

  @override
  int? id;

  String slug;

  String name;

  /// The post people in this exchange hold, e.g. "Primary Teacher".
  String cadre;

  /// Human readable scope, e.g. "Maharashtra" or "All India".
  String scope;

  /// When set, postings and wishes must be in this state.
  String? state;

  String description;

  int maxLoopSize;

  int acceptWindowMinutes;

  /// Open playground whose simulated members answer within seconds.
  bool isSandbox;

  /// Members are simulated (demo data), not real people.
  bool isSimulated;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Exchange]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Exchange copyWith({
    int? id,
    String? slug,
    String? name,
    String? cadre,
    String? scope,
    String? state,
    String? description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Exchange',
      if (id != null) 'id': id,
      'slug': slug,
      'name': name,
      'cadre': cadre,
      'scope': scope,
      if (state != null) 'state': state,
      'description': description,
      'maxLoopSize': maxLoopSize,
      'acceptWindowMinutes': acceptWindowMinutes,
      'isSandbox': isSandbox,
      'isSimulated': isSimulated,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Exchange',
      if (id != null) 'id': id,
      'slug': slug,
      'name': name,
      'cadre': cadre,
      'scope': scope,
      if (state != null) 'state': state,
      'description': description,
      'maxLoopSize': maxLoopSize,
      'acceptWindowMinutes': acceptWindowMinutes,
      'isSandbox': isSandbox,
      'isSimulated': isSimulated,
    };
  }

  static ExchangeInclude include() {
    return ExchangeInclude._();
  }

  static ExchangeIncludeList includeList({
    _is.WhereExpressionBuilder<ExchangeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExchangeTable>? orderBy,
    _is.OrderByListBuilder<ExchangeTable>? orderByList,
    ExchangeInclude? include,
  }) {
    return ExchangeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Exchange.t),
      orderByList: orderByList?.call(Exchange.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExchangeImpl extends Exchange {
  _ExchangeImpl({
    int? id,
    required String slug,
    required String name,
    required String cadre,
    required String scope,
    String? state,
    required String description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  }) : super._(
         id: id,
         slug: slug,
         name: name,
         cadre: cadre,
         scope: scope,
         state: state,
         description: description,
         maxLoopSize: maxLoopSize,
         acceptWindowMinutes: acceptWindowMinutes,
         isSandbox: isSandbox,
         isSimulated: isSimulated,
       );

  /// Returns a shallow copy of this [Exchange]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Exchange copyWith({
    Object? id = _Undefined,
    String? slug,
    String? name,
    String? cadre,
    String? scope,
    Object? state = _Undefined,
    String? description,
    int? maxLoopSize,
    int? acceptWindowMinutes,
    bool? isSandbox,
    bool? isSimulated,
  }) {
    return Exchange(
      id: id is int? ? id : this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      cadre: cadre ?? this.cadre,
      scope: scope ?? this.scope,
      state: state is String? ? state : this.state,
      description: description ?? this.description,
      maxLoopSize: maxLoopSize ?? this.maxLoopSize,
      acceptWindowMinutes: acceptWindowMinutes ?? this.acceptWindowMinutes,
      isSandbox: isSandbox ?? this.isSandbox,
      isSimulated: isSimulated ?? this.isSimulated,
    );
  }
}

class ExchangeUpdateTable extends _is.UpdateTable<ExchangeTable> {
  ExchangeUpdateTable(super.table);

  _is.ColumnValue<String, String> slug(String value) => _is.ColumnValue(
    table.slug,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> cadre(String value) => _is.ColumnValue(
    table.cadre,
    value,
  );

  _is.ColumnValue<String, String> scope(String value) => _is.ColumnValue(
    table.scope,
    value,
  );

  _is.ColumnValue<String, String> state(String? value) => _is.ColumnValue(
    table.state,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<int, int> maxLoopSize(int value) => _is.ColumnValue(
    table.maxLoopSize,
    value,
  );

  _is.ColumnValue<int, int> acceptWindowMinutes(int value) => _is.ColumnValue(
    table.acceptWindowMinutes,
    value,
  );

  _is.ColumnValue<bool, bool> isSandbox(bool value) => _is.ColumnValue(
    table.isSandbox,
    value,
  );

  _is.ColumnValue<bool, bool> isSimulated(bool value) => _is.ColumnValue(
    table.isSimulated,
    value,
  );
}

class ExchangeTable extends _is.Table<int?> {
  ExchangeTable({super.tableRelation}) : super(tableName: 'exchange') {
    updateTable = ExchangeUpdateTable(this);
    slug = _is.ColumnString(
      'slug',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    cadre = _is.ColumnString(
      'cadre',
      this,
    );
    scope = _is.ColumnString(
      'scope',
      this,
    );
    state = _is.ColumnString(
      'state',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    maxLoopSize = _is.ColumnInt(
      'maxLoopSize',
      this,
      hasDefault: true,
    );
    acceptWindowMinutes = _is.ColumnInt(
      'acceptWindowMinutes',
      this,
      hasDefault: true,
    );
    isSandbox = _is.ColumnBool(
      'isSandbox',
      this,
      hasDefault: true,
    );
    isSimulated = _is.ColumnBool(
      'isSimulated',
      this,
      hasDefault: true,
    );
  }

  late final ExchangeUpdateTable updateTable;

  late final _is.ColumnString slug;

  late final _is.ColumnString name;

  /// The post people in this exchange hold, e.g. "Primary Teacher".
  late final _is.ColumnString cadre;

  /// Human readable scope, e.g. "Maharashtra" or "All India".
  late final _is.ColumnString scope;

  /// When set, postings and wishes must be in this state.
  late final _is.ColumnString state;

  late final _is.ColumnString description;

  late final _is.ColumnInt maxLoopSize;

  late final _is.ColumnInt acceptWindowMinutes;

  /// Open playground whose simulated members answer within seconds.
  late final _is.ColumnBool isSandbox;

  /// Members are simulated (demo data), not real people.
  late final _is.ColumnBool isSimulated;

  @override
  List<_is.Column> get columns => [
    id,
    slug,
    name,
    cadre,
    scope,
    state,
    description,
    maxLoopSize,
    acceptWindowMinutes,
    isSandbox,
    isSimulated,
  ];
}

class ExchangeInclude extends _is.IncludeObject {
  ExchangeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Exchange.t;
}

class ExchangeIncludeList extends _is.IncludeList {
  ExchangeIncludeList._({
    _is.WhereExpressionBuilder<ExchangeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Exchange.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Exchange.t;
}

class ExchangeRepository {
  const ExchangeRepository._();

  /// Returns a list of [Exchange]s matching the given query parameters.
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
  Future<List<Exchange>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExchangeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExchangeTable>? orderBy,
    _is.OrderByListBuilder<ExchangeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Exchange>(
      where: where?.call(Exchange.t),
      orderBy: orderBy?.call(Exchange.t),
      orderByList: orderByList?.call(Exchange.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Exchange] matching the given query parameters.
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
  Future<Exchange?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExchangeTable>? where,
    int? offset,
    _is.OrderByBuilder<ExchangeTable>? orderBy,
    _is.OrderByListBuilder<ExchangeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Exchange>(
      where: where?.call(Exchange.t),
      orderBy: orderBy?.call(Exchange.t),
      orderByList: orderByList?.call(Exchange.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Exchange] by its [id] or null if no such row exists.
  Future<Exchange?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Exchange>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Exchange]s in the list and returns the inserted rows.
  ///
  /// The returned [Exchange]s will have their `id` fields set.
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
  Future<List<Exchange>> insert(
    _is.DatabaseSession session,
    List<Exchange> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Exchange>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Exchange] and returns the inserted row.
  ///
  /// The returned [Exchange] will have its `id` field set.
  Future<Exchange> insertRow(
    _is.DatabaseSession session,
    Exchange row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Exchange>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Exchange]s in the list and returns the resulting rows.
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
  /// The returned [Exchange]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Exchange>> upsert(
    _is.DatabaseSession session,
    List<Exchange> rows, {
    required _is.ColumnSelections<ExchangeTable> conflictColumns,
    _is.ColumnSelections<ExchangeTable>? updateColumns,
    _is.WhereExpressionBuilder<ExchangeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Exchange>(
      rows,
      conflictColumns: conflictColumns(Exchange.t),
      updateColumns: updateColumns?.call(Exchange.t),
      updateWhere: updateWhere?.call(Exchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Exchange] and returns the resulting row.
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
  /// The returned [Exchange] will have its `id` field set.
  Future<Exchange?> upsertRow(
    _is.DatabaseSession session,
    Exchange row, {
    required _is.ColumnSelections<ExchangeTable> conflictColumns,
    _is.ColumnSelections<ExchangeTable>? updateColumns,
    _is.WhereExpressionBuilder<ExchangeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Exchange>(
      row,
      conflictColumns: conflictColumns(Exchange.t),
      updateColumns: updateColumns?.call(Exchange.t),
      updateWhere: updateWhere?.call(Exchange.t),
      transaction: transaction,
    );
  }

  /// Updates all [Exchange]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Exchange>> update(
    _is.DatabaseSession session,
    List<Exchange> rows, {
    _is.ColumnSelections<ExchangeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Exchange>(
      rows,
      columns: columns?.call(Exchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Exchange]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Exchange> updateRow(
    _is.DatabaseSession session,
    Exchange row, {
    _is.ColumnSelections<ExchangeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Exchange>(
      row,
      columns: columns?.call(Exchange.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Exchange] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Exchange?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ExchangeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Exchange>(
      id,
      columnValues: columnValues(Exchange.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Exchange]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Exchange>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ExchangeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ExchangeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ExchangeTable>? orderBy,
    _is.OrderByListBuilder<ExchangeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Exchange>(
      columnValues: columnValues(Exchange.t.updateTable),
      where: where(Exchange.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Exchange.t),
      orderByList: orderByList?.call(Exchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Exchange]s in the list and returns the deleted rows.
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
  Future<List<Exchange>> delete(
    _is.DatabaseSession session,
    List<Exchange> rows, {
    _is.OrderByBuilder<ExchangeTable>? orderBy,
    _is.OrderByListBuilder<ExchangeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Exchange>(
      rows,
      orderBy: orderBy?.call(Exchange.t),
      orderByList: orderByList?.call(Exchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Exchange].
  Future<Exchange> deleteRow(
    _is.DatabaseSession session,
    Exchange row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Exchange>(
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
  Future<List<Exchange>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExchangeTable> where,
    _is.OrderByBuilder<ExchangeTable>? orderBy,
    _is.OrderByListBuilder<ExchangeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Exchange>(
      where: where(Exchange.t),
      orderBy: orderBy?.call(Exchange.t),
      orderByList: orderByList?.call(Exchange.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ExchangeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Exchange>(
      where: where?.call(Exchange.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Exchange] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ExchangeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Exchange>(
      where: where(Exchange.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
