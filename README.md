# Pre-work - TipYall

TipYall is a tip calculator application for iOS.

Submitted by: Gil Birman

Time spent: 8.5hrs

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [X] UI animations (in the `¯\_(ツ)_/¯` game)
* [X] Remembering the bill amount across app restarts (if <10mins)
* [X] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

* Add a `¯\_(ツ)_/¯` button which opens the tipping game
* Tipping game walks user through series of questions and calculates final tip between low and high settings
using weighted average based on game score

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/vXefFiF.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- The code is a lot more verbose than I am used to when writing JavaScript.
Part of this is probably because I don't understand a lot of best-practices.

- I put commonly-used functions and constants in `common.swift`. Coming from the JavaScript
modulified world I hate using globals but am not sure the best way to do this sort of thing
in Swift.

- I'm reading and writing to and from `NSUserDefaults` all the time to avoid any data
sync problems. Is there any problem with doing this?

- All the switch statements are bothering me. I almost never use them in JS. Hopefully there's a sleeker way.

- When and how is the best way to unwrap optionals?

## License

    Copyright 2016 Gil Birman

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
