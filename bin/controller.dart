import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:sqlite3/sqlite3.dart';

class MessageFromApp {
  String type;
  String? parameter;
  String? value;

  MessageFromApp({
    required this.type,
    this.parameter,
    this.value,
  });

  messageFromApp(requestType, parameter, value) {
    //save parameter locally
    final db = sqlite3.open('storage.db');
    if (requestType == 'saveWeekday') {
      db.execute('''
          CREATE TABLE IF NOT EXISTS days (
            weekdayNum INTEGER,
            weekdayValue BOOLEAN,
          );
      ''');

      // Update rows that match weekdayNum and update the weekdayValue
      db.execute('''
          UPDATE days
          SET weekdayValue = $value
          WHERE weekdayNum = $parameter;
      ''');
      //TODO: insert error handling
    } else if (requestType == 'pullWeekday') {
      // get data from database
      Map<int, bool> daysForPulling = {};
      final dbDays = db.select('SELECT * FROM days');
      for (var row in dbDays) {
        daysForPulling[row['weekdayNum']] = row['weekdayValue'];
        return daysForPulling;
      }
      //TODO: insert error handling
    } else if (requestType == 'saveTime') {
      print('hey, implement saveTime');
    } else if (requestType == 'pullTime') {
      print('hey, implement pullTime');
    } else {
      print('unknown requestType');
    }
    db.dispose();
  }
}

Future<Response> addWeekday(Request request) async {
  try {
    // 1
    final payload = json.decode(await request.readAsString());
    final String? username = payload['username'];
    if (username == null) {
      return Response(400, body: 'Missing "username" in the payload.');
    }
    // 2
    // TODO: get weekday int an weekday bool from payload

    // TODO: store them as vairables for function below
    final db = sqlite3.open('storage.db');

    db.execute('''
          CREATE TABLE IF NOT EXISTS days (
            weekdayNum INTEGER,
            weekdayValue BOOLEAN,
          );
      ''');

    // Update rows that match weekdayNum and update the weekdayValue
    db.execute('''
          UPDATE days
          SET weekdayValue = $value
          WHERE weekdayNum = $parameter;
      ''');
    //TODO: insert error handling

    // reponse
    return Response.ok(
      json.encode({'message': 'Weekday added successfully.'}),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response(400, body: 'Invalid JSON payload.');
  }
}

Future<Response> addTime(Request request) async {
  try {
    // 1
    final payload = json.decode(await request.readAsString());
    final String? username = payload['username'];
    if (username == null) {
      return Response(400, body: 'Missing "username" in the payload.');
    }
    final db = sqlite3.open('storage.db');

    //TODO: get time values from JSON
    //TODO: store Time values

    return Response.ok(
      json.encode({'message': 'Times added successfully.'}),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response(400, body: 'Invalid JSON payload.');
  }
}

Future<Response> pullValuesFromDb(Request request) async {
  try {
    // 1
    final payload = json.decode(await request.readAsString());
    final String? username = payload['username'];
    if (username == null) {
      return Response(400, body: 'Missing "username" in the payload.');
    }
    final db = sqlite3.open('storage.db');

    //TODO: Pull Values

    return Response.ok(
      json.encode({'message': 'MESSAGE HERE'}),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response(400, body: 'Invalid JSON payload.');
  }
}
