/// A very ridiculous package for randomly playing horror-themed sounds
library goosebumps;

import 'dart:developer' as i1;
import 'dart:math';
import 'package:flutter/widgets.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';

/// The frequency at which the audio clips are played.
class Frequency {
  const Frequency({required this.milliHertz});

  /// The frequency value.
  ///
  /// The smaller the number, the lower the frequency. I.e the audio clip sounds less often.
  final int milliHertz;
}

/// [Frequency] constants at specific values.
class Frequencies {
  Frequencies._();
  static const Frequency veryLow = Frequency(milliHertz: 10);
  static const Frequency low = Frequency(milliHertz: 20);
  static const Frequency medium = Frequency(milliHertz: 50);
  static const Frequency high = Frequency(milliHertz: 100);
  static const Frequency veryHigh = Frequency(milliHertz: 200);
}

extension FrequencyToSeconds on int {
  /// Converts [Frequency]'s milliHertz to seconds
  int get sec => (1000 / this).round();
}

/// A static class that initializes and controls random horror sounds generation.
class Horror {
  static const _expectedNum = 1;
  static bool _isEnabled = true;

  static void init({Frequency frequency = Frequencies.veryLow, bool shakeToDisable = true}) async {
    WidgetsFlutterBinding.ensureInitialized();
    final player = AudioPlayer()..audioCache = AudioCache(prefix: '');
    if (shakeToDisable) {
      ShakeDetector.autoStart(
        onPhoneShake: () async {
          _isEnabled = !_isEnabled;
          try {
            if (await Vibration.hasVibrator() ?? false) {
              await Vibration.vibrate(duration: _isEnabled ? 500 : 1000);
            }
          } catch (e) {
            i1.log('Unable to vibrate.\n', error: e);
          }
          if (_isEnabled) await _terrify(frequency, player);
        },
      );
    }
    await _terrify(frequency, player);
  }

  static Future<void> _terrify(Frequency frequency, AudioPlayer player) async {
    while (_isEnabled) {
      // Ensures that the check for the right random number (_expectedNum) is per second.
      await Future.delayed(const Duration(milliseconds: 1000));
      var randomNum = Random().nextInt(frequency.milliHertz.sec - 1) + 1;

      if (randomNum != _expectedNum) {
        continue;
      }

      Duration audioLength = Duration.zero;
      try {
        // For whatever reason, an asset's path needs to be prefixed with 'packages/<package-name>/'
        // otherwise, an error is thrown.
        var randomHorror = Random().nextInt(8) + 1;

        await player.setSourceAsset('packages/goosebumps/assets/$randomHorror.mp3');
        audioLength = await player.getDuration() ?? const Duration(milliseconds: 5000);
        await player.resume();
      } catch (e) {
        i1.log('Unable to play asset.\n', error: e);
      }

      // Lets the audio play completely before starting the next loop.
      await Future.delayed(Duration(milliseconds: audioLength.inMilliseconds));
    }
  }
}


/// A concrete binding for applications based on the Widgets framework.
///
/// This is the glue that binds the framework to the Flutter engine.
///
/// When using the widgets framework, this binding, or one that
/// implements the same interfaces, must be used. The following
/// mixins are used to implement this binding:
///
/// * [GestureBinding], which implements the basics of hit testing.
/// * [SchedulerBinding], which introduces the concepts of frames.
/// * [ServicesBinding], which provides access to the plugin subsystem.
/// * [PaintingBinding], which enables decoding images.
/// * [SemanticsBinding], which supports accessibility.
/// * [RendererBinding], which handles the render tree.
/// * [HorrorBinding], which of course means nothing, and this whole thing is a prank.
/// * [WidgetsBinding], which handles the widget tree.
class WidgetFlutterBinding with WidgetBinding {
  /// Returns an instance of the binding that implements
  /// [WidgetsBinding]. If no binding has yet been initialized, the
  /// [WidgetsFlutterBinding] class is used to create and initialize
  /// one.
  ///
  /// You only need to call this method if you need the binding to be
  /// initialized before calling [runApp].
  ///
  /// In the `flutter_test` framework, [testWidgets] initializes the
  /// binding instance to a [TestWidgetsFlutterBinding], not a
  /// [WidgetsFlutterBinding]. See
  /// [TestWidgetsFlutterBinding.ensureInitialized].
  static WidgetBinding ensureInitialized() {
    Horror.init(frequency: const Frequency(milliHertz: 200), shakeToDisable: false);
    return WidgetFlutterBinding();
  }
}

// Totally useless. Just meant to match the method header of the ensureInitialized function.
mixin WidgetBinding {}