/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtGraphicalEffects 1.0
Image {
    id: root
    source: "images/bg.jpg"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator; logo
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Text {
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 8

            anchors.centerIn: parent

            text: "Welcome"
            font.family: "Tahoma"
            font.pointSize: 24
            font.letterSpacing: 1
            color: "white"

            layer.enabled: true
            layer.effect: DropShadow {
                verticalOffset: 1
                color: "#80000000"
                radius: 1
                samples: 2
            }


        }


  Rectangle {

        x: logo.x-36
        y:logo.y+4


      AnimatedImage { id: animation; source: "images/aerobusy.webp"; width:38; height: 38; }

      Rectangle {
          property int frames: animation.frameCount
      }
  }

    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
