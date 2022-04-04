import 'package:net_module/net_module.dart';
import 'package:redux/redux.dart';

class LoggingMiddleware<State> extends MiddlewareClass<State> {
  LoggingMiddleware({
    Logger? logger,
    this.level = Level.INFO,
    this.formatter = singleLineFormatter,
  }) : logger = logger ?? Logger('LoggingMiddleware');

  /// The default constructor. It will only log actions to the given [Logger],
  /// but it will not print to the console or anything else.
  ///
  /// A helper factory for creating a piece of LoggingMiddleware that only
  /// prints to the console.
  factory LoggingMiddleware.printer({
    Logger? logger,
    Level level = Level.INFO,
    MessageFormatter<State> formatter = singleLineFormatter,
  }) {
    final middleware = LoggingMiddleware<State>(
      logger: logger,
      level: level,
      formatter: formatter,
    );

    middleware.logger.onRecord.where((record) {
      return record.loggerName == middleware.logger.name;
    }).listen(print);

    return middleware;
  }

  /// The [Logger] instance that actions will be logged to.
  final Logger logger;

  /// The log [Level] at which the actions will be recorded
  final Level level;

  /// A function that formats the String for printing
  final MessageFormatter<State> formatter;

  /// A simple formatter that puts all data on one line
  static String singleLineFormatter(
    dynamic state,
    dynamic action,
    DateTime timestamp,
  ) {
    return '\x1B[35m{Action: $action, State: $state, ts: $timestamp}\x1B[0m';
  }

  /// A formatter that puts each attribute on it's own line
  static String multiLineFormatter(
    dynamic state,
    dynamic action,
    DateTime timestamp,
  ) {
    return '\x1B[35m{\n'
        '  Action: $action,\n'
        '  State: $state,\n'
        '  Timestamp: $timestamp\n'
        '}\x1B[0m';
  }

  @override
  void call(Store<State> store, dynamic action, NextDispatcher next) {
    next(action);
    logger.log(level, () => formatter(store.state, action, DateTime.now()));
  }
}

typedef MessageFormatter<State> = String Function(
  State state,
  dynamic action,
  DateTime timestamp,
);
