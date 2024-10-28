import 'package:flutter_test/flutter_test.dart';
import 'package:local_fx/src/features/common/infrastructure/logging_service.dart';
import 'package:logger/logger.dart';
import 'package:mockito/mockito.dart';

class MockLogger extends Mock implements Logger {}

void main() {
  late MockLogger mockLogger;
  late LoggingService loggingService;

  setUpAll(() {
    mockLogger = MockLogger();
    loggingService = LoggingService(logger: mockLogger);
  });

  group('Loggers', () {
    test('info should log info message with formatted args if provided', () {
      loggingService.info(String, 'Test message with %s', ['argument']);

      verify(mockLogger.i('String - Test message with argument')).called(1);
    });

    test('info should log info message without args', () {
      loggingService.info(String, 'Test message without args');

      verify(mockLogger.i('String - Test message without args')).called(1);
    });

    test('warning should log warning message with exception and stack trace',
        () {
      final exception = Exception('Test exception');
      final stackTrace = StackTrace.current;

      loggingService.warning(String, 'Warning message', exception, stackTrace);

      verify(
        mockLogger.w(
          'String - Warning message \n $exception',
          time: LoggingService.now,
          error: exception,
          stackTrace: stackTrace,
        ),
      ).called(1);
    });

    test('warning should log warning message without exception', () {
      loggingService.warning(String, 'Warning message');

      verify(
        mockLogger.w(
          'String - Warning message \n No exception available',
          time: LoggingService.now,
        ),
      ).called(1);
    });

    test('error should log error message with exception and stack trace', () {
      final exception = Exception('Test exception');
      final stackTrace = StackTrace.current;

      loggingService.error(
        String,
        'Error message',
        ex: exception,
        trace: stackTrace,
      );

      verify(
        mockLogger.e(
          'String - Error message \n $exception',
          time: LoggingService.now,
          error: exception,
          stackTrace: stackTrace,
        ),
      ).called(1);
    });

    test('error should log error message without exception', () {
      loggingService.error(String, 'Error message');

      verify(
        mockLogger.e(
          'String - Error message \n No exception available',
          time: LoggingService.now,
        ),
      ).called(1);
    });
  });
}
