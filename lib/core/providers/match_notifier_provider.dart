import 'package:hooks_riverpod/hooks_riverpod.dart';

final matchNotifierProvider = StateNotifierProvider<MatchNotifier, MatchState>(
  (ref) => MatchNotifier(),
);

class MatchNotifier extends StateNotifier<MatchState> {
  MatchNotifier() : super(MatchState());

  void showMatchDialog({
    required String currentUserId,
    required String toUserId,
  }) {
    state = MatchState(
      showDialog: true,
      currentUserId: currentUserId,
      toUserId: toUserId,
    );
  }

  void hideMatchDialog() {
    state = MatchState();
  }
}

class MatchState {
  final bool showDialog;
  final String currentUserId;
  final String toUserId;

  MatchState({
    this.showDialog = false,
    this.currentUserId = '',
    this.toUserId = '',
  });
}
