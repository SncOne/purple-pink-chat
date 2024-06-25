// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roomHash() => r'e4ed62f230e0a3673686f7258fb81e1cffec80ee';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [room].
@ProviderFor(room)
const roomProvider = RoomFamily();

/// See also [room].
class RoomFamily extends Family<AsyncValue<types.Room>> {
  /// See also [room].
  const RoomFamily();

  /// See also [room].
  RoomProvider call(
    String roomId,
  ) {
    return RoomProvider(
      roomId,
    );
  }

  @override
  RoomProvider getProviderOverride(
    covariant RoomProvider provider,
  ) {
    return call(
      provider.roomId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'roomProvider';
}

/// See also [room].
class RoomProvider extends AutoDisposeStreamProvider<types.Room> {
  /// See also [room].
  RoomProvider(
    String roomId,
  ) : this._internal(
          (ref) => room(
            ref as RoomRef,
            roomId,
          ),
          from: roomProvider,
          name: r'roomProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$roomHash,
          dependencies: RoomFamily._dependencies,
          allTransitiveDependencies: RoomFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  RoomProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.roomId,
  }) : super.internal();

  final String roomId;

  @override
  Override overrideWith(
    Stream<types.Room> Function(RoomRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RoomProvider._internal(
        (ref) => create(ref as RoomRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        roomId: roomId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<types.Room> createElement() {
    return _RoomProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RoomProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RoomRef on AutoDisposeStreamProviderRef<types.Room> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _RoomProviderElement extends AutoDisposeStreamProviderElement<types.Room>
    with RoomRef {
  _RoomProviderElement(super.provider);

  @override
  String get roomId => (origin as RoomProvider).roomId;
}

String _$messagesHash() => r'c97330fef96ca85394c00a6322f37103aa81e1b9';

/// See also [messages].
@ProviderFor(messages)
const messagesProvider = MessagesFamily();

/// See also [messages].
class MessagesFamily extends Family<AsyncValue<List<types.Message>>> {
  /// See also [messages].
  const MessagesFamily();

  /// See also [messages].
  MessagesProvider call(
    Room room,
  ) {
    return MessagesProvider(
      room,
    );
  }

  @override
  MessagesProvider getProviderOverride(
    covariant MessagesProvider provider,
  ) {
    return call(
      provider.room,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messagesProvider';
}

/// See also [messages].
class MessagesProvider extends AutoDisposeStreamProvider<List<types.Message>> {
  /// See also [messages].
  MessagesProvider(
    Room room,
  ) : this._internal(
          (ref) => messages(
            ref as MessagesRef,
            room,
          ),
          from: messagesProvider,
          name: r'messagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messagesHash,
          dependencies: MessagesFamily._dependencies,
          allTransitiveDependencies: MessagesFamily._allTransitiveDependencies,
          room: room,
        );

  MessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.room,
  }) : super.internal();

  final Room room;

  @override
  Override overrideWith(
    Stream<List<types.Message>> Function(MessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MessagesProvider._internal(
        (ref) => create(ref as MessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        room: room,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<types.Message>> createElement() {
    return _MessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessagesProvider && other.room == room;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, room.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MessagesRef on AutoDisposeStreamProviderRef<List<types.Message>> {
  /// The parameter `room` of this provider.
  Room get room;
}

class _MessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<types.Message>>
    with MessagesRef {
  _MessagesProviderElement(super.provider);

  @override
  Room get room => (origin as MessagesProvider).room;
}

String _$selectedRoomHash() => r'89d721d7d77b4cf536690557563a2ccf1b77196b';

/// See also [SelectedRoom].
@ProviderFor(SelectedRoom)
final selectedRoomProvider =
    NotifierProvider<SelectedRoom, types.Room?>.internal(
  SelectedRoom.new,
  name: r'selectedRoomProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedRoomHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedRoom = Notifier<types.Room?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
