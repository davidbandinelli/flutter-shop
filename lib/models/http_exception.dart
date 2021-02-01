// id Dart tutte le classi ereditano implicitamente da Object
// in questo caso ereditiamo dalla classe base astratta Exception
class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  @override
  String toString() {
    return message;
    //return super.toString();
  }
}
