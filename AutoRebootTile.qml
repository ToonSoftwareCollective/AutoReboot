
import QtQuick 2.1
import qb.components 1.0

Tile {
	id: autoRebootTile
        property bool dimState: screenStateController.dimmedColors


	Text {
		id: tileTitle
		anchors {
			baseline: parent.top
			baselineOffset: 30
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.regular.name
			pixelSize: qfont.tileTitle
		}
		color: !dimState? "black" : "white"
		text: "Auto Reboot"
	}

	Text {
		id: txtTimeBig
		text: app.timeStr
		color: dimmableColors.clockTileColor
		anchors.centerIn: parent
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: dimState ? qfont.clockFaceText : qfont.timeAndTemperatureText
		font.family: qfont.regular.name
	}

	Text {
		id: txtLast
		text: app.lastStart
		color: dimmableColors.clockTileColor
		anchors {
			horizontalCenter: parent.horizontalCenter
			top: txtTimeBig.bottom
			topMargin:2
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: 11
		font.family: qfont.regular.name
		visible: !dimState
	}

	Text {
		id: txtDate
		text: app.dateStr
		color: dimmableColors.clockTileColor
		anchors {
			horizontalCenter: parent.horizontalCenter
			baseline: parent.bottom
			baselineOffset: designElements.vMarginNeg16
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: qfont.tileTitle
		font.family: qfont.regular.name
		visible: !dimState
	}




}
