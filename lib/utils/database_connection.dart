import 'dart:convert';
import 'dart:async';

import 'package:mysql1/mysql1.dart';
import 'package:username_generator/username_generator.dart';
import 'package:intl/intl.dart';

class DatabaseConnection {
  static Future<Results> PostsforUser(String useremail) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn
        .query('select * from Posts where user_email = ?', [useremail]);

    // return results;

    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();

    return results;
  }

  static Future<Results> PostsforCommunity(String community) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn
        .query('select * from Posts where community_guid = ?', [community]);

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

  //?
  static Future<Results> Comments(String postGuid) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn
        .query('select * from Comments where post_guid = ?', [postGuid]);

    return results;
    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
  }

  static Future<Results> Communities() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn.query('select * from Communities');

    return results;
    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
  }

  static Future<Results> InsertPost(String useremail, String community_guid,
      String postTitle, postDescription) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);

    // Query the database using a parameterized query
    Results results = await conn.query(
        'insert into Posts (user_email, community_guid, post_date, post_title, post, smiles, cries, comments, reports) values (?, ?, ?, ?)',
        [
          useremail,
          community_guid,
          formattedDate,
          postTitle,
          postDescription,
          0,
          0,
          0,
          0
        ]);
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
    await conn.query(
        'update Posts set reports=reports + 1 where post_guid=?', [post_guid]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
  }

  //Add community to user!
  // static Future JoinCommunity(String user_guid, String community_guid) async {
  //   final conn = await MySqlConnection.connect(ConnectionSettings(
  //       host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
  //       port: 3306,
  //       user: 'admin',
  //       db: 'Koi',
  //       password: 'BangTanS13!'));

  //     // Query the database using a parameterized query
  //   await conn.query('update Communities set followers=followers + 1 where community_guid=?',
  //   [community_guid]);
  //   // Allow user to get notifications from the community they followed
  // }

  static Future<Results> InsertUser(String useremail) async {
    UsernameGenerator username = new UsernameGenerator();

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn.query(
        'insert into Users (username, user_email, posts) values (?, ?, ?)',
        [username.generateRandom(), useremail, 0]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
    return results;
  }
}
