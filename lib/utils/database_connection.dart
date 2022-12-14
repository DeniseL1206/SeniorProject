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

    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
    return results;
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

    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
    return results;
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

    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
    return results;
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

    // for (var row in results) {
    //   print('Name: ${row[0]} , email: ${row[1]} ');
    // }

    // Finally, close the connection
    await conn.close();
    return results;
  }

  static Future<Results> GetCommunityRatings() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn.query('select rating from Communities');

    await conn.close();
    return results;
  }

  static Future<Results> GetUsername(String useremail) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn
        .query('select username from Users where user_email = ?', [useremail]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
    await conn.close();
    return results;
  }

  static Future InsertPost(String useremail, String community_guid,
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

    Results getUsername = await conn
        .query('select username from Users where user_email = ?', [useremail]);

    String tempUserName = "";

    for (var element in getUsername) {
      tempUserName = element[0];
    }
    // Query the database using a parameterized query
    Results results = await conn.query(
        'insert into Posts (user_name, user_email, community_guid, post_date, post_title, post, smiles, cries, comments, reports) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          tempUserName,
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
    await conn.close();
  }

  static Future<Results> GetPostInfo(String post_guid) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn
        .query('select * from Posts where post_guid = ?', [post_guid]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
    await conn.close();
    return results;
  }

  static Future<Results> GetPostOldtoNew(String useremail) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn.query(
        'select * from Posts where useremail = ? order by post_date ASC',
        [useremail]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
    await conn.close();
    return results;
  }

  static Future<Results> GetPostNewtoOld(String useremail) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    Results results = await conn.query(
        'select * from Posts where useremail = ? order by post_date DESC',
        [useremail]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
    await conn.close();
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
    await conn.close();
  }

  static Future SmileAtPost(String post_guid) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    await conn.query(
        'update Posts set smiles=smiles + 1 where post_guid=?', [post_guid]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]

    await conn.close();
  }

  static Future CryAtPost(String post_guid) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
        port: 3306,
        user: 'admin',
        db: 'Koi',
        password: 'BangTanS13!'));

    // Query the database using a parameterized query
    await conn.query(
        'update Posts set cries=cries + 1 where post_guid=?', [post_guid]);
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
    await conn.close();
  }

  static Future CommentOnPost(
      String post_guid, String comment, String username) async {
    if (!comment.isEmpty) {
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

      await conn.query(
          'update Posts set comments=comments + 1 where post_guid=?',
          [post_guid]);

      await conn.query(
          'insert into Comments (post_guid, user_name, comment_date, comment, smiles, cries, reports) values (?, ?, ?, ?, ?, ?, ?)',
          [int.parse(post_guid), username, formattedDate, comment, 0, 0, 0]);
      //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
      await conn.close();
    }
  }

  // static Future GetPostFeaturesCount(String post_guid) async {
  //   final conn = await MySqlConnection.connect(ConnectionSettings(
  //       host: 'campussafetyapp.cra5btmlrrve.us-east-2.rds.amazonaws.com',
  //       port: 3306,
  //       user: 'admin',
  //       db: 'Koi',
  //       password: 'BangTanS13!'));

  //   var now = new DateTime.now();
  //   var formatter = new DateFormat('yyyy-MM-dd');
  //   String formattedDate = formatter.format(now);
  //   // Query the database using a parameterized query
  //   await conn.query(
  //       'select smiles, cries, comments, reports from Posts where post_guid=?',
  //       [post_guid]);

  //   await conn.close();
  //   //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
  // }

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

  static Future InsertUser(String useremail) async {
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

    await conn.close();
    //'insert into users (name, email, age) values (?, ?, ?)', ['Bob', 'bob@bob.com', 25]
    //return results;
  }
}
