import 'dart:convert';
import 'dart:async';

import 'package:mysql1/mysql1.dart';

class DatabaseConnection {
  static Future<Results> Posts() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn.query('select * from Posts');

    return results;
    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
  }

  static Future<Results> Users() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn.query('select * from Users');

    return results;
    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
  }

  static Future<Results> Comments() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn.query('select * from Comments');

    return results;
    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
  }

  static Future<Results> Locations_Communities() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn.query('select * from Locations_Communities');

    return results;
    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
  }

  static Future<Results> InsertPost(String user_guid, String community_guid, String post) async {
     final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

      // Query the database using a parameterized query
    Results results = await conn.query('insert into Posts (post_guid, user_guid, community_guid, post_date, post) values (?, ?, ?, ?)', ['x', user_guid, community_guid, post]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
    return results;
  }

  static Future ReportPost(String post_guid) async {
     final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

      // Query the database using a parameterized query
    await conn.query('update Posts set reportCount=reportCount + 1 where post_guid=?',
    [post_guid]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
   
  }

  static Future JoinCommunity(String user_guid, String community_guid) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

      // Query the database using a parameterized query
    await conn.query('update Locations_Communities set followers=followers + 1 where _guid=?',
    [community_guid]);
    // Allow user to get notifications from the community they followed
  }
}
