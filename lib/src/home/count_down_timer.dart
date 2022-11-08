import 'dart:async';
import 'package:flutter/material.dart';

const defaultTimer = 60;

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key, this.title, int? time, bool? autoStart})
      : time = time ?? defaultTimer,
        autoStart = autoStart ?? false;

  // Question il y a t'il possibilité dans une redirection de constructeur de ne pas ré-écrire tous les paramètres ?
  const CountdownTimer.amazing({key, int? time, bool? autoStart})
      : this(key: key, title: 'Amazing Timer', time: time, autoStart: autoStart);

  final String? title;
  final bool autoStart;
  final int time;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int remainingSeconds = widget.time;
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();

    if (widget.autoStart) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    countdownTimer?.cancel();
  }

  bool _isTimerActive() => countdownTimer != null && countdownTimer!.isActive;

  void _startTimer() {
    setState(() => {countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => _decrementTimer())});
  }

  void _stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void _toggleTimer() {
    if (_isTimerActive()) {
      return _stopTimer();
    }
    _startTimer();
  }

  void _resetTimer() {
    if (_isTimerActive()) {
      _stopTimer();
    }

    setState(() {
      remainingSeconds = widget.time;
    });
  }

  void _incrementTimer() {
    setState(() {
      remainingSeconds++;
    });
  }

  void _decrementTimer() {
    setState(() {
      remainingSeconds--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      if (widget.title != null) ...[
        Text(widget.title!, style: Theme.of(context).textTheme.headline6),
        const SizedBox(height: 12)
      ],
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TimerButton(callback: _decrementTimer, icon: Icons.remove, disabled: _isTimerActive()),
        GestureDetector(
            onTap: _toggleTimer,
            onLongPress: _resetTimer,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: _isTimerActive() ? Colors.redAccent.shade400 : Colors.indigo,
              ),
              child: Text(
                '$remainingSeconds',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )),
        TimerButton(callback: _incrementTimer, icon: Icons.add, disabled: _isTimerActive())
      ])
    ]);
  }
}

class TimerButton extends StatelessWidget {
  const TimerButton({
    super.key,
    required this.callback,
    required this.icon,
    this.disabled = false,
  });

  final Function callback;
  final IconData icon;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.indigoAccent),
        onPressed: disabled
            ? null
            : () {
                callback();
              },
        child: Icon(
          icon,
          size: 30,
        ));
  }
}
