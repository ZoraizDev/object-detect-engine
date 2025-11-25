class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;

  AppExceptions(this._message, this._prefix);

  @override
  String toString() => '$_prefix: $_message';
}

class InternetException extends AppExceptions {
  InternetException([String? message]) : super(message, 'No Internet');
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message]) : super(message, 'Request Timed Out');
}

class ServerException extends AppExceptions {
  ServerException([String? message]) : super(message, 'Server Error');
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message]) : super(message, 'Invalid URL');
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message]) : super(message, 'Unexpected Error');
}
