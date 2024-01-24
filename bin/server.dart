import 'dart:async';
import 'dart:io';
import 'package:rpi_gpio/rpi_gpio.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'controller.dart';
import 'get_date_time.dart';
import 'output_app.dart';

final scheduledTimeInt = 7;
final scheduledWeekdaysIntList = [1, 2, 3, 4, 5];

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..get('/addWeekday', _addWeekday)
  ..get('/addTime', addTime)
  ..get('/pullValues', pullValuesFromDb);

Response _rootHandler(Request req) {
  final queryParams = req.requestedUri.queryParameters;
  final username = queryParams['user'];
  if (username != null) {
    return Response.ok('Hello, $username\n');
  }

  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Response _addWeekday(Request request) {
  // final response = addWeekday(request);
  // return Response.ok('weekdays added. $response\n');
  return Response.ok('weekdays received. test.');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');

  //set up RPI and timer

  //  final gpio = await initialize_RpiGpio();

  // Timer.periodic(Duration(minutes: 1), (Timer t) async {
  //   if (checkDayAndTimeMatch(
  //       scheduledTimeInt: scheduledTimeInt,
  //       scheduledWeekdaysIntList: scheduledWeekdaysIntList)) {
  //     try {
  //       await unlockLock(gpio);
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     print('It is not time to open the door yet.');
  //   }
  // });
}
