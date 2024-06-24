// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messagesHash() => r'0576764561c0f84ec76e7deb9bd3364748adbc07';

/// See also [messages].
@ProviderFor(messages)
final messagesProvider = AutoDisposeStreamProvider<List<Room>>.internal(
  messages,
  name: r'messagesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$messagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessagesRef = AutoDisposeStreamProviderRef<List<Room>>;
String _$unreadMessageCountHash() =>
    r'170108ab0f3627270597402175727a2ae5c65acb';

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

/// See also [unreadMessageCount].
@ProviderFor(unreadMessageCount)
const unreadMessageCountProvider = UnreadMessageCountFamily();

/// See also [unreadMessageCount].
class UnreadMessageCountFamily extends Family<AsyncValue<int>> {
  /// See also [unreadMessageCount].
  const UnreadMessageCountFamily();

  /// See also [unreadMessageCount].
  UnreadMessageCountProvider call(
    String roomId,
  ) {
    return UnreadMessageCountProvider(
      roomId,
    );
  }

  @override
  UnreadMessageCountProvider getProviderOverride(
    covariant UnreadMessageCountProvider provider,
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
  String? get name => r'unreadMessageCountProvider';
}

/// See also [unreadMessageCount].
class UnreadMessageCountProvider extends AutoDisposeStreamProvider<int> {
  /// See also [unreadMessageCount].
  UnreadMessageCountProvider(
    String roomId,
  ) : this._internal(
          (ref) => unreadMessageCount(
            ref as UnreadMessageCountRef,
            roomId,
          ),
          from: unreadMessageCountProvider,
          name: r'unreadMessageCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$unreadMessageCountHash,
          dependencies: UnreadMessageCountFamily._dependencies,
          allTransitiveDependencies:
              UnreadMessageCountFamily._allTransitiveDependencies,
          roomId: roomId,
        );

  UnreadMessageCountProvider._internal(
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
    Stream<int> Function(UnreadMessageCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UnreadMessageCountProvider._internal(
        (ref) => create(ref as UnreadMessageCountRef),
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
  AutoDisposeStreamProviderElement<int> createElement() {
    return _UnreadMessageCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnreadMessageCountProvider && other.roomId == roomId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, roomId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UnreadMessageCountRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `roomId` of this provider.
  String get roomId;
}

class _UnreadMessageCountProviderElement
    extends AutoDisposeStreamProviderElement<int> with UnreadMessageCountRef {
  _UnreadMessageCountProviderElement(super.provider);

  @override
  String get roomId => (origin as UnreadMessageCountProvider).roomId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
