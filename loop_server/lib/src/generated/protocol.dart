/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:loop_server/src/generated/loop/models/exchange_summary.dart'
    as _ixjx40xr;
import 'package:loop_server/src/generated/loop/models/loop_view.dart'
    as _ik88j8r8;
import 'package:loop_server/src/generated/loop/models/my_listing.dart'
    as _ih4uw61h;
import 'package:loop_server/src/generated/loop/models/place.dart' as _is6pjt89;
import 'package:loop_server/src/generated/loop/models/wish_input.dart'
    as _ihs1spbq;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'future_calls_generated_models/bot_future_call_respond_model.dart'
    as _ivgds3jj;
import 'future_calls_generated_models/loop_deadline_future_call_expire_model.dart'
    as _irmg46bk;
import 'future_calls_generated_models/solve_future_call_solve_model.dart'
    as _it5h8prl;
import 'loop/models/declined_edge.dart' as _in009umd;
import 'loop/models/exchange.dart' as _iw5rmx8t;
import 'loop/models/exchange_summary.dart' as _ic8hgcmq;
import 'loop/models/lab_result.dart' as _ie0c7g9b;
import 'loop/models/listing.dart' as _i2ct69t9;
import 'loop/models/listing_status.dart' as _i524jma0;
import 'loop/models/loop_error_code.dart' as _iqsizhe6;
import 'loop/models/loop_event.dart' as _icdgd785;
import 'loop/models/loop_event_kind.dart' as _iklfu2yy;
import 'loop/models/loop_exception.dart' as _i47sf5r5;
import 'loop/models/loop_seat.dart' as _ih9o9q84;
import 'loop/models/loop_status.dart' as _ix0pjlyl;
import 'loop/models/loop_trace.dart' as _i0go6mh6;
import 'loop/models/loop_view.dart' as _inakt9ip;
import 'loop/models/market_event.dart' as _i7leuqa4;
import 'loop/models/market_event_kind.dart' as _iao4iwg6;
import 'loop/models/market_flow.dart' as _iyrvngek;
import 'loop/models/market_place.dart' as _ipuaqtg1;
import 'loop/models/market_snapshot.dart' as _ioomabe5;
import 'loop/models/member.dart' as _iqcjyqz4;
import 'loop/models/member_contact.dart' as _i1bo32kc;
import 'loop/models/member_update.dart' as _i8h1xlwl;
import 'loop/models/my_listing.dart' as _ik5nzdng;
import 'loop/models/place.dart' as _ifutsqcw;
import 'loop/models/seat_response.dart' as _iyc6u9y6;
import 'loop/models/seat_view.dart' as _ilqzmqki;
import 'loop/models/solver_run.dart' as _i797ae6t;
import 'loop/models/swap_loop.dart' as _ii5itptg;
import 'loop/models/wish.dart' as _ip90o58a;
import 'loop/models/wish_input.dart' as _il23c4a1;
export 'loop/models/declined_edge.dart';
export 'loop/models/exchange.dart';
export 'loop/models/exchange_summary.dart';
export 'loop/models/lab_result.dart';
export 'loop/models/listing.dart';
export 'loop/models/listing_status.dart';
export 'loop/models/loop_error_code.dart';
export 'loop/models/loop_event.dart';
export 'loop/models/loop_event_kind.dart';
export 'loop/models/loop_exception.dart';
export 'loop/models/loop_seat.dart';
export 'loop/models/loop_status.dart';
export 'loop/models/loop_trace.dart';
export 'loop/models/loop_view.dart';
export 'loop/models/market_event.dart';
export 'loop/models/market_event_kind.dart';
export 'loop/models/market_flow.dart';
export 'loop/models/market_place.dart';
export 'loop/models/market_snapshot.dart';
export 'loop/models/member.dart';
export 'loop/models/member_contact.dart';
export 'loop/models/member_update.dart';
export 'loop/models/my_listing.dart';
export 'loop/models/place.dart';
export 'loop/models/seat_response.dart';
export 'loop/models/seat_view.dart';
export 'loop/models/solver_run.dart';
export 'loop/models/swap_loop.dart';
export 'loop/models/wish.dart';
export 'loop/models/wish_input.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'declined_edge',
      dartName: 'DeclinedEdge',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'fromListingId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'toListingId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'declined_edge_fk_0',
          columns: ['fromListingId'],
          referenceTable: 'listing',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'declined_edge_fk_1',
          columns: ['toListingId'],
          referenceTable: 'listing',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'declined_edge_pair_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'fromListingId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'toListingId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'exchange',
      dartName: 'Exchange',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'slug',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'cadre',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'scope',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'state',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'maxLoopSize',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '4',
        ),
        _isp.ColumnDefinition(
          name: 'acceptWindowMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '2880',
        ),
        _isp.ColumnDefinition(
          name: 'isSandbox',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'isSimulated',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'exchange__slug__unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'listing',
      dartName: 'Listing',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'memberId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'exchangeId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'currentPlaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'postTitle',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'yearsInPost',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ListingStatus',
          columnDefault: '\'active\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'listing_fk_0',
          columns: ['memberId'],
          referenceTable: 'member',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'listing_fk_1',
          columns: ['exchangeId'],
          referenceTable: 'exchange',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'listing_fk_2',
          columns: ['currentPlaceId'],
          referenceTable: 'place',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'listing_member_exchange_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'memberId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'exchangeId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'listing_exchange_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'exchangeId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'loop_event',
      dartName: 'LoopEvent',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'loopId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:LoopEventKind',
        ),
        _isp.ColumnDefinition(
          name: 'seatPosition',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'loop_event_fk_0',
          columns: ['loopId'],
          referenceTable: 'swap_loop',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'loop_event_loop_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'loopId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'loop_seat',
      dartName: 'LoopSeat',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'loopId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'listingId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'memberId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'position',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'fromPlaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'toPlaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'wishRank',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'km',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'response',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SeatResponse',
          columnDefault: '\'pending\'',
        ),
        _isp.ColumnDefinition(
          name: 'respondedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'loop_seat_fk_0',
          columns: ['loopId'],
          referenceTable: 'swap_loop',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'loop_seat_fk_1',
          columns: ['listingId'],
          referenceTable: 'listing',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'loop_seat_fk_2',
          columns: ['memberId'],
          referenceTable: 'member',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'loop_seat_fk_3',
          columns: ['fromPlaceId'],
          referenceTable: 'place',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'loop_seat_fk_4',
          columns: ['toPlaceId'],
          referenceTable: 'place',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'loop_seat_loop_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'loopId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'loop_seat_member_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'memberId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'loop_seat_listing_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'listingId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'member',
      dartName: 'Member',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'phone',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'contactEmail',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'isBot',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'member__authUserId__unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'place',
      dartName: 'Place',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'code',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'state',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'point',
          columnType: _isp.ColumnType.geography,
          isNullable: false,
          dartType: 'GeographyPoint',
        ),
        _isp.ColumnDefinition(
          name: 'population',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'place__code__unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'place_state_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'state',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'place_point_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'point',
            ),
          ],
          type: 'gist',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'solver_run',
      dartName: 'SolverRun',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'exchangeId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'trigger',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'activeListings',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'edgeCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'coreSize',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'candidateCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'loopsProposed',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'peopleInLoops',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'pairwisePeople',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'elapsedMs',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'solver_run_fk_0',
          columns: ['exchangeId'],
          referenceTable: 'exchange',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'solver_run_exchange_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'exchangeId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'at',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'swap_loop',
      dartName: 'SwapLoop',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'exchangeId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:LoopStatus',
          columnDefault: '\'proposed\'',
        ),
        _isp.ColumnDefinition(
          name: 'size',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'score',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'publicCode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'deadline',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'swap_loop_fk_0',
          columns: ['exchangeId'],
          referenceTable: 'exchange',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'swap_loop__publicCode__unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'publicCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'swap_loop_exchange_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'exchangeId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'wish',
      dartName: 'Wish',
      schema: 'public',
      module: 'loop',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'listingId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'placeId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'radiusKm',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'rank',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'point',
          columnType: _isp.ColumnType.geography,
          isNullable: true,
          dartType: 'GeographyPoint?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'wish_fk_0',
          columns: ['listingId'],
          referenceTable: 'listing',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'wish_fk_1',
          columns: ['placeId'],
          referenceTable: 'place',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'wish_listing_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'listingId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'wish_point_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'point',
            ),
          ],
          type: 'gist',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ivgds3jj.BotFutureCallRespondModel) {
      return _ivgds3jj.BotFutureCallRespondModel.fromJson(data) as T;
    }
    if (t == _irmg46bk.LoopDeadlineFutureCallExpireModel) {
      return _irmg46bk.LoopDeadlineFutureCallExpireModel.fromJson(data) as T;
    }
    if (t == _it5h8prl.SolveFutureCallSolveModel) {
      return _it5h8prl.SolveFutureCallSolveModel.fromJson(data) as T;
    }
    if (t == _in009umd.DeclinedEdge) {
      return _in009umd.DeclinedEdge.fromJson(data) as T;
    }
    if (t == _iw5rmx8t.Exchange) {
      return _iw5rmx8t.Exchange.fromJson(data) as T;
    }
    if (t == _ic8hgcmq.ExchangeSummary) {
      return _ic8hgcmq.ExchangeSummary.fromJson(data) as T;
    }
    if (t == _ie0c7g9b.LabResult) {
      return _ie0c7g9b.LabResult.fromJson(data) as T;
    }
    if (t == _i2ct69t9.Listing) {
      return _i2ct69t9.Listing.fromJson(data) as T;
    }
    if (t == _i524jma0.ListingStatus) {
      return _i524jma0.ListingStatus.fromJson(data) as T;
    }
    if (t == _iqsizhe6.LoopErrorCode) {
      return _iqsizhe6.LoopErrorCode.fromJson(data) as T;
    }
    if (t == _icdgd785.LoopEvent) {
      return _icdgd785.LoopEvent.fromJson(data) as T;
    }
    if (t == _iklfu2yy.LoopEventKind) {
      return _iklfu2yy.LoopEventKind.fromJson(data) as T;
    }
    if (t == _i47sf5r5.LoopException) {
      return _i47sf5r5.LoopException.fromJson(data) as T;
    }
    if (t == _ih9o9q84.LoopSeat) {
      return _ih9o9q84.LoopSeat.fromJson(data) as T;
    }
    if (t == _ix0pjlyl.LoopStatus) {
      return _ix0pjlyl.LoopStatus.fromJson(data) as T;
    }
    if (t == _i0go6mh6.LoopTrace) {
      return _i0go6mh6.LoopTrace.fromJson(data) as T;
    }
    if (t == _inakt9ip.LoopView) {
      return _inakt9ip.LoopView.fromJson(data) as T;
    }
    if (t == _i7leuqa4.MarketEvent) {
      return _i7leuqa4.MarketEvent.fromJson(data) as T;
    }
    if (t == _iao4iwg6.MarketEventKind) {
      return _iao4iwg6.MarketEventKind.fromJson(data) as T;
    }
    if (t == _iyrvngek.MarketFlow) {
      return _iyrvngek.MarketFlow.fromJson(data) as T;
    }
    if (t == _ipuaqtg1.MarketPlace) {
      return _ipuaqtg1.MarketPlace.fromJson(data) as T;
    }
    if (t == _ioomabe5.MarketSnapshot) {
      return _ioomabe5.MarketSnapshot.fromJson(data) as T;
    }
    if (t == _iqcjyqz4.Member) {
      return _iqcjyqz4.Member.fromJson(data) as T;
    }
    if (t == _i1bo32kc.MemberContact) {
      return _i1bo32kc.MemberContact.fromJson(data) as T;
    }
    if (t == _i8h1xlwl.MemberUpdate) {
      return _i8h1xlwl.MemberUpdate.fromJson(data) as T;
    }
    if (t == _ik5nzdng.MyListing) {
      return _ik5nzdng.MyListing.fromJson(data) as T;
    }
    if (t == _ifutsqcw.Place) {
      return _ifutsqcw.Place.fromJson(data) as T;
    }
    if (t == _iyc6u9y6.SeatResponse) {
      return _iyc6u9y6.SeatResponse.fromJson(data) as T;
    }
    if (t == _ilqzmqki.SeatView) {
      return _ilqzmqki.SeatView.fromJson(data) as T;
    }
    if (t == _i797ae6t.SolverRun) {
      return _i797ae6t.SolverRun.fromJson(data) as T;
    }
    if (t == _ii5itptg.SwapLoop) {
      return _ii5itptg.SwapLoop.fromJson(data) as T;
    }
    if (t == _ip90o58a.Wish) {
      return _ip90o58a.Wish.fromJson(data) as T;
    }
    if (t == _il23c4a1.WishInput) {
      return _il23c4a1.WishInput.fromJson(data) as T;
    }
    if (t == _is.getType<_ivgds3jj.BotFutureCallRespondModel?>()) {
      return (data != null
              ? _ivgds3jj.BotFutureCallRespondModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_irmg46bk.LoopDeadlineFutureCallExpireModel?>()) {
      return (data != null
              ? _irmg46bk.LoopDeadlineFutureCallExpireModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_it5h8prl.SolveFutureCallSolveModel?>()) {
      return (data != null
              ? _it5h8prl.SolveFutureCallSolveModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_in009umd.DeclinedEdge?>()) {
      return (data != null ? _in009umd.DeclinedEdge.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iw5rmx8t.Exchange?>()) {
      return (data != null ? _iw5rmx8t.Exchange.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ic8hgcmq.ExchangeSummary?>()) {
      return (data != null ? _ic8hgcmq.ExchangeSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ie0c7g9b.LabResult?>()) {
      return (data != null ? _ie0c7g9b.LabResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2ct69t9.Listing?>()) {
      return (data != null ? _i2ct69t9.Listing.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i524jma0.ListingStatus?>()) {
      return (data != null ? _i524jma0.ListingStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqsizhe6.LoopErrorCode?>()) {
      return (data != null ? _iqsizhe6.LoopErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_icdgd785.LoopEvent?>()) {
      return (data != null ? _icdgd785.LoopEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iklfu2yy.LoopEventKind?>()) {
      return (data != null ? _iklfu2yy.LoopEventKind.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i47sf5r5.LoopException?>()) {
      return (data != null ? _i47sf5r5.LoopException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ih9o9q84.LoopSeat?>()) {
      return (data != null ? _ih9o9q84.LoopSeat.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ix0pjlyl.LoopStatus?>()) {
      return (data != null ? _ix0pjlyl.LoopStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i0go6mh6.LoopTrace?>()) {
      return (data != null ? _i0go6mh6.LoopTrace.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_inakt9ip.LoopView?>()) {
      return (data != null ? _inakt9ip.LoopView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7leuqa4.MarketEvent?>()) {
      return (data != null ? _i7leuqa4.MarketEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iao4iwg6.MarketEventKind?>()) {
      return (data != null ? _iao4iwg6.MarketEventKind.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iyrvngek.MarketFlow?>()) {
      return (data != null ? _iyrvngek.MarketFlow.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ipuaqtg1.MarketPlace?>()) {
      return (data != null ? _ipuaqtg1.MarketPlace.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ioomabe5.MarketSnapshot?>()) {
      return (data != null ? _ioomabe5.MarketSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqcjyqz4.Member?>()) {
      return (data != null ? _iqcjyqz4.Member.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1bo32kc.MemberContact?>()) {
      return (data != null ? _i1bo32kc.MemberContact.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i8h1xlwl.MemberUpdate?>()) {
      return (data != null ? _i8h1xlwl.MemberUpdate.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ik5nzdng.MyListing?>()) {
      return (data != null ? _ik5nzdng.MyListing.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifutsqcw.Place?>()) {
      return (data != null ? _ifutsqcw.Place.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iyc6u9y6.SeatResponse?>()) {
      return (data != null ? _iyc6u9y6.SeatResponse.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilqzmqki.SeatView?>()) {
      return (data != null ? _ilqzmqki.SeatView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i797ae6t.SolverRun?>()) {
      return (data != null ? _i797ae6t.SolverRun.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ii5itptg.SwapLoop?>()) {
      return (data != null ? _ii5itptg.SwapLoop.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ip90o58a.Wish?>()) {
      return (data != null ? _ip90o58a.Wish.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_il23c4a1.WishInput?>()) {
      return (data != null ? _il23c4a1.WishInput.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_ilqzmqki.SeatView>) {
      return (data as List)
              .map((e) => deserialize<_ilqzmqki.SeatView>(e))
              .toList()
          as T;
    }
    if (t == List<_icdgd785.LoopEvent>) {
      return (data as List)
              .map((e) => deserialize<_icdgd785.LoopEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_ipuaqtg1.MarketPlace>) {
      return (data as List)
              .map((e) => deserialize<_ipuaqtg1.MarketPlace>(e))
              .toList()
          as T;
    }
    if (t == List<_iyrvngek.MarketFlow>) {
      return (data as List)
              .map((e) => deserialize<_iyrvngek.MarketFlow>(e))
              .toList()
          as T;
    }
    if (t == List<_i0go6mh6.LoopTrace>) {
      return (data as List)
              .map((e) => deserialize<_i0go6mh6.LoopTrace>(e))
              .toList()
          as T;
    }
    if (t == List<_ip90o58a.Wish>) {
      return (data as List).map((e) => deserialize<_ip90o58a.Wish>(e)).toList()
          as T;
    }
    if (t == List<_ih4uw61h.MyListing>) {
      return (data as List)
              .map((e) => deserialize<_ih4uw61h.MyListing>(e))
              .toList()
          as T;
    }
    if (t == List<_ihs1spbq.WishInput>) {
      return (data as List)
              .map((e) => deserialize<_ihs1spbq.WishInput>(e))
              .toList()
          as T;
    }
    if (t == List<_ik88j8r8.LoopView>) {
      return (data as List)
              .map((e) => deserialize<_ik88j8r8.LoopView>(e))
              .toList()
          as T;
    }
    if (t == List<_is6pjt89.Place>) {
      return (data as List).map((e) => deserialize<_is6pjt89.Place>(e)).toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_ixjx40xr.ExchangeSummary>) {
      return (data as List)
              .map((e) => deserialize<_ixjx40xr.ExchangeSummary>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ivgds3jj.BotFutureCallRespondModel => 'BotFutureCallRespondModel',
      _irmg46bk.LoopDeadlineFutureCallExpireModel =>
        'LoopDeadlineFutureCallExpireModel',
      _it5h8prl.SolveFutureCallSolveModel => 'SolveFutureCallSolveModel',
      _in009umd.DeclinedEdge => 'DeclinedEdge',
      _iw5rmx8t.Exchange => 'Exchange',
      _ic8hgcmq.ExchangeSummary => 'ExchangeSummary',
      _ie0c7g9b.LabResult => 'LabResult',
      _i2ct69t9.Listing => 'Listing',
      _i524jma0.ListingStatus => 'ListingStatus',
      _iqsizhe6.LoopErrorCode => 'LoopErrorCode',
      _icdgd785.LoopEvent => 'LoopEvent',
      _iklfu2yy.LoopEventKind => 'LoopEventKind',
      _i47sf5r5.LoopException => 'LoopException',
      _ih9o9q84.LoopSeat => 'LoopSeat',
      _ix0pjlyl.LoopStatus => 'LoopStatus',
      _i0go6mh6.LoopTrace => 'LoopTrace',
      _inakt9ip.LoopView => 'LoopView',
      _i7leuqa4.MarketEvent => 'MarketEvent',
      _iao4iwg6.MarketEventKind => 'MarketEventKind',
      _iyrvngek.MarketFlow => 'MarketFlow',
      _ipuaqtg1.MarketPlace => 'MarketPlace',
      _ioomabe5.MarketSnapshot => 'MarketSnapshot',
      _iqcjyqz4.Member => 'Member',
      _i1bo32kc.MemberContact => 'MemberContact',
      _i8h1xlwl.MemberUpdate => 'MemberUpdate',
      _ik5nzdng.MyListing => 'MyListing',
      _ifutsqcw.Place => 'Place',
      _iyc6u9y6.SeatResponse => 'SeatResponse',
      _ilqzmqki.SeatView => 'SeatView',
      _i797ae6t.SolverRun => 'SolverRun',
      _ii5itptg.SwapLoop => 'SwapLoop',
      _ip90o58a.Wish => 'Wish',
      _il23c4a1.WishInput => 'WishInput',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('loop.', '');
    }

    switch (data) {
      case _ivgds3jj.BotFutureCallRespondModel():
        return 'BotFutureCallRespondModel';
      case _irmg46bk.LoopDeadlineFutureCallExpireModel():
        return 'LoopDeadlineFutureCallExpireModel';
      case _it5h8prl.SolveFutureCallSolveModel():
        return 'SolveFutureCallSolveModel';
      case _in009umd.DeclinedEdge():
        return 'DeclinedEdge';
      case _iw5rmx8t.Exchange():
        return 'Exchange';
      case _ic8hgcmq.ExchangeSummary():
        return 'ExchangeSummary';
      case _ie0c7g9b.LabResult():
        return 'LabResult';
      case _i2ct69t9.Listing():
        return 'Listing';
      case _i524jma0.ListingStatus():
        return 'ListingStatus';
      case _iqsizhe6.LoopErrorCode():
        return 'LoopErrorCode';
      case _icdgd785.LoopEvent():
        return 'LoopEvent';
      case _iklfu2yy.LoopEventKind():
        return 'LoopEventKind';
      case _i47sf5r5.LoopException():
        return 'LoopException';
      case _ih9o9q84.LoopSeat():
        return 'LoopSeat';
      case _ix0pjlyl.LoopStatus():
        return 'LoopStatus';
      case _i0go6mh6.LoopTrace():
        return 'LoopTrace';
      case _inakt9ip.LoopView():
        return 'LoopView';
      case _i7leuqa4.MarketEvent():
        return 'MarketEvent';
      case _iao4iwg6.MarketEventKind():
        return 'MarketEventKind';
      case _iyrvngek.MarketFlow():
        return 'MarketFlow';
      case _ipuaqtg1.MarketPlace():
        return 'MarketPlace';
      case _ioomabe5.MarketSnapshot():
        return 'MarketSnapshot';
      case _iqcjyqz4.Member():
        return 'Member';
      case _i1bo32kc.MemberContact():
        return 'MemberContact';
      case _i8h1xlwl.MemberUpdate():
        return 'MemberUpdate';
      case _ik5nzdng.MyListing():
        return 'MyListing';
      case _ifutsqcw.Place():
        return 'Place';
      case _iyc6u9y6.SeatResponse():
        return 'SeatResponse';
      case _ilqzmqki.SeatView():
        return 'SeatView';
      case _i797ae6t.SolverRun():
        return 'SolverRun';
      case _ii5itptg.SwapLoop():
        return 'SwapLoop';
      case _ip90o58a.Wish():
        return 'Wish';
      case _il23c4a1.WishInput():
        return 'WishInput';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'BotFutureCallRespondModel') {
      return deserialize<_ivgds3jj.BotFutureCallRespondModel>(data['data']);
    }
    if (dataClassName == 'LoopDeadlineFutureCallExpireModel') {
      return deserialize<_irmg46bk.LoopDeadlineFutureCallExpireModel>(
        data['data'],
      );
    }
    if (dataClassName == 'SolveFutureCallSolveModel') {
      return deserialize<_it5h8prl.SolveFutureCallSolveModel>(data['data']);
    }
    if (dataClassName == 'DeclinedEdge') {
      return deserialize<_in009umd.DeclinedEdge>(data['data']);
    }
    if (dataClassName == 'Exchange') {
      return deserialize<_iw5rmx8t.Exchange>(data['data']);
    }
    if (dataClassName == 'ExchangeSummary') {
      return deserialize<_ic8hgcmq.ExchangeSummary>(data['data']);
    }
    if (dataClassName == 'LabResult') {
      return deserialize<_ie0c7g9b.LabResult>(data['data']);
    }
    if (dataClassName == 'Listing') {
      return deserialize<_i2ct69t9.Listing>(data['data']);
    }
    if (dataClassName == 'ListingStatus') {
      return deserialize<_i524jma0.ListingStatus>(data['data']);
    }
    if (dataClassName == 'LoopErrorCode') {
      return deserialize<_iqsizhe6.LoopErrorCode>(data['data']);
    }
    if (dataClassName == 'LoopEvent') {
      return deserialize<_icdgd785.LoopEvent>(data['data']);
    }
    if (dataClassName == 'LoopEventKind') {
      return deserialize<_iklfu2yy.LoopEventKind>(data['data']);
    }
    if (dataClassName == 'LoopException') {
      return deserialize<_i47sf5r5.LoopException>(data['data']);
    }
    if (dataClassName == 'LoopSeat') {
      return deserialize<_ih9o9q84.LoopSeat>(data['data']);
    }
    if (dataClassName == 'LoopStatus') {
      return deserialize<_ix0pjlyl.LoopStatus>(data['data']);
    }
    if (dataClassName == 'LoopTrace') {
      return deserialize<_i0go6mh6.LoopTrace>(data['data']);
    }
    if (dataClassName == 'LoopView') {
      return deserialize<_inakt9ip.LoopView>(data['data']);
    }
    if (dataClassName == 'MarketEvent') {
      return deserialize<_i7leuqa4.MarketEvent>(data['data']);
    }
    if (dataClassName == 'MarketEventKind') {
      return deserialize<_iao4iwg6.MarketEventKind>(data['data']);
    }
    if (dataClassName == 'MarketFlow') {
      return deserialize<_iyrvngek.MarketFlow>(data['data']);
    }
    if (dataClassName == 'MarketPlace') {
      return deserialize<_ipuaqtg1.MarketPlace>(data['data']);
    }
    if (dataClassName == 'MarketSnapshot') {
      return deserialize<_ioomabe5.MarketSnapshot>(data['data']);
    }
    if (dataClassName == 'Member') {
      return deserialize<_iqcjyqz4.Member>(data['data']);
    }
    if (dataClassName == 'MemberContact') {
      return deserialize<_i1bo32kc.MemberContact>(data['data']);
    }
    if (dataClassName == 'MemberUpdate') {
      return deserialize<_i8h1xlwl.MemberUpdate>(data['data']);
    }
    if (dataClassName == 'MyListing') {
      return deserialize<_ik5nzdng.MyListing>(data['data']);
    }
    if (dataClassName == 'Place') {
      return deserialize<_ifutsqcw.Place>(data['data']);
    }
    if (dataClassName == 'SeatResponse') {
      return deserialize<_iyc6u9y6.SeatResponse>(data['data']);
    }
    if (dataClassName == 'SeatView') {
      return deserialize<_ilqzmqki.SeatView>(data['data']);
    }
    if (dataClassName == 'SolverRun') {
      return deserialize<_i797ae6t.SolverRun>(data['data']);
    }
    if (dataClassName == 'SwapLoop') {
      return deserialize<_ii5itptg.SwapLoop>(data['data']);
    }
    if (dataClassName == 'Wish') {
      return deserialize<_ip90o58a.Wish>(data['data']);
    }
    if (dataClassName == 'WishInput') {
      return deserialize<_il23c4a1.WishInput>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('loop', this);
    _iacs.Protocol().registerHostProtocol('loop', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _in009umd.DeclinedEdge:
        return _in009umd.DeclinedEdge.t;
      case _iw5rmx8t.Exchange:
        return _iw5rmx8t.Exchange.t;
      case _i2ct69t9.Listing:
        return _i2ct69t9.Listing.t;
      case _icdgd785.LoopEvent:
        return _icdgd785.LoopEvent.t;
      case _ih9o9q84.LoopSeat:
        return _ih9o9q84.LoopSeat.t;
      case _iqcjyqz4.Member:
        return _iqcjyqz4.Member.t;
      case _ifutsqcw.Place:
        return _ifutsqcw.Place.t;
      case _i797ae6t.SolverRun:
        return _i797ae6t.SolverRun.t;
      case _ii5itptg.SwapLoop:
        return _ii5itptg.SwapLoop.t;
      case _ip90o58a.Wish:
        return _ip90o58a.Wish.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'loop';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
