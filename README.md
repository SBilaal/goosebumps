<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A totally not useless Flutter package for randomly playing horror-themed sounds.

![Scream Clip](https://media.giphy.com/media/xT9IgvEOwRzUcZDRiU/giphy.gif)

## Overview

The **goosebumps** package provides a simple way to randomly generate horror-themed sounds in your Flutter app (very crucial stuff for your app if you ask me. Absolutely not useless🙃.). It also lets you control the frequency at which the audio clips are played and provides an option to disable the sound by shaking the device (nifty, that.😌).

<!-- ![Scream Clip](https://media.giphy.com/media/zpgmyQg3qOVqw/giphy.gif)
![Scream Clip](https://media.giphy.com/media/zXKA3p9aR3u7u/giphy.gif) -->

## Requirements
On Android:
- Include the VIBRATE permission in AndroidManifest.xml:
    ```xml
    <uses-permission android:name="android.permission.VIBRATE"/>
    ```

- Set `compileSDKVersion` to 33 in **android\app\build.gradle**.


## Usage

Import the **goosebumps** package:

```dart
import 'package:goosebumps/goosebumps.dart';
```

Initialize horror sounds generation:

```dart
await Horror.init();
```

This initializes the horror sounds generator with the default settings. The audio clips will be played at a very low frequency.

You can customize the frequency using the `Frequency` class. The smaller the frequency value, the fewer times the audio clip is played. The `Frequencies` class provides some predefined frequency constants:

* `Frequencies.veryLow`
* `Frequencies.low`
* `Frequencies.medium`
* `Frequencies.high`
* `Frequencies.veryHigh`

You can also pass a `Frequency` object to the `init()` method to set a custom frequency:

```dart
// That's really low by the way.
await Horror.init(frequency: Frequency(milliHertz: 2));
```

By default, shaking the device will toggle the sound generation on or off. When the device is shook, it vibrates for one second to indicate that it is disabled and half a second to indicate that it is enabled. 

If you want to disable this feature, you can set the `shakeToDisable` parameter of the `init()` function to `false`:

```dart
await Horror.init(shakeToDisable: false);
```

For an even better chance at staying hidden, you can use the below API instead of `Horror.init()`:
```dart
WidgetFlutterBinding.ensureInitialized();
```
It looks just like `WidgetsFlutterBinding.ensureInitialized()` from flutter. It even shows the same docs! And since `WidgetsFlutterBinding.ensureInitialized()` is alread called inside `Horror.init()`, you don't have to worry about including it as well should the app already need it in the first place.

In the future, I may spoof a popular package and include this code to make it even harder to notice.

## Contribution
Contributions to the **goosebumps** package are welcome! If you find any issues, have suggestions for improvements, or would like to add new features, feel free to contribute. Here's how you can get involved:

1. Fork the repository on GitHub.
2. Create a new branch with a descriptive name for your feature or bug fix.
3. Make your changes and ensure that the code follows the project's style guidelines.
4. Write tests to cover your changes and ensure that existing tests pass.
5. Commit your changes and push the branch to your forked repository.
6. Submit a pull request to the main repository, describing your changes in detail.

Please ensure that your pull request adheres to the following guidelines:

* Provide a clear and descriptive title for your pull request.
* Include a detailed description of the changes you have made.
* If your pull request addresses an existing issue, reference it in the description using the **#issue_number** format.
* Ensure that your code is well-documented, follows best practices, and is properly formatted.
* Include relevant tests for the changes you have made.

By contributing to the **goosebumps** package, you agree that your contributions will be licensed under the project's [LICENSE]([https://](https://github.com/SBilaal/goosebumps/blob/main/LICENSE)).

Thank you for your interest in improving the **goosebumps** package! Your contributions are greatly appreciated.


## License
This package is licensed under the BSD-2 License. See the [LICENSE](https://github.com/SBilaal/goosebumps/blob/main/LICENSE) file for more details.

## Issues and Feedback
Please file [issues](https://github.com/SBilaal/goosebumps/issues) to send feedback or report a bug. Thank you!
