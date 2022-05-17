import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ClockState();
  }
}

class _ClockState extends State<Clock> {
  String _date = '';
  String _time = '';

  String _getDate() {
    DateTime now = DateTime.now();
    DateFormat df = DateFormat('M月d日(E)', 'ja');
    return df.format(now);
  }

  String _getTime() {
    DateTime now = DateTime.now();
    DateFormat tf = DateFormat('HH:mm:ss');
    return tf.format(now);
  }

  @override
  void initState() {
    super.initState();

    // 日付フォーマットを日本語で初期化
    initializeDateFormatting('ja');

    _date = _getDate();
    _time = _getTime();
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        setState(() {
          _date = _getDate();
          _time = _getTime();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'Custom',
      ),
      child: Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.all(40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(100, 0, 0, 0),
          ),
          padding:
              const EdgeInsets.only(top: 10, bottom: 3, left: 28, right: 28),
          child: Stack(
            children: [
              Text(
                _date,
                style: const TextStyle(fontSize: 26),
              ),
              Container(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  _time,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
