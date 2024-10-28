import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_fx/src/features/common/presentation/bloc_presentation/bloc_presentation_mixin.dart';

class _TestCubit extends Cubit<int> with BlocPresentationMixin<int, _Event> {
  _TestCubit() : super(0);

  void emitValueEvent() => emitPresentation(_ValueEvent());
  void emitReferenceEvent() => emitPresentation(_ReferenceEvent());
}

sealed class _Event {}

@immutable
class _ValueEvent implements _Event {
  @override
  bool operator ==(Object other) => other is _ValueEvent;

  @override
  int get hashCode => 0;
}

class _ReferenceEvent implements _Event {}

void main() {
  group('BlocPresentationMixin', () {
    late _TestCubit cubit;

    setUp(() {
      cubit = _TestCubit();
    });

    test('Presentation events are emitted', () {
      expect(
        cubit.presentation,
        emitsInOrder(<Matcher>[
          isA<_ValueEvent>(),
          isA<_ReferenceEvent>(),
        ]),
      );

      cubit
        ..emitValueEvent()
        ..emitReferenceEvent();
    });

    test('Presentation stream is correctly closed', () async {
      expect(
        cubit.presentation,
        emitsInOrder(<Matcher>[
          isA<_ValueEvent>(),
          emitsDone,
        ]),
      );

      cubit.emitValueEvent();
      await cubit.close();

      expect(cubit.emitReferenceEvent, throwsStateError);
      expect(() => cubit.emit(0), throwsStateError);
    });

    test('Presentation stream can emit consecutively equal objects', () async {
      expect(
        cubit.presentation,
        emitsInOrder(<Matcher>[
          isA<_ValueEvent>(),
          isA<_ValueEvent>(),
          isA<_ReferenceEvent>(),
          isA<_ReferenceEvent>(),
        ]),
      );

      cubit
        ..emitValueEvent()
        ..emitValueEvent()
        ..emitReferenceEvent()
        ..emitReferenceEvent();
    });
  });
}
