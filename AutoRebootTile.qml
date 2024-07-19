
import QtQuick 2.1
import qb.components 1.0

Tile {
	id: autoRebootTile
        property bool dimState: screenStateController.dimmedColors


	Text {
		id: tileTitle
		anchors {
			baseline: parent.top
			baselineOffset: isNxt? 30 : 20
			horizontalCenter: parent.horizontalCenter
		}
		font {
			family: qfont.bold.name
			pixelSize: qfont.tileTitle
		}
		color: !dimState? "black" : "white"
		text: "  Volgende\nAuto Reboot"
	}
	Text {
		id: txtDate
		text: app.dateStr
		color: dimmableColors.clockTileColor
		anchors {
			horizontalCenter: parent.horizontalCenter
			top: tileTitle.bottom
			topMargin:isNxt? 20 : 15
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: qfont.tileTitle
		font.family: qfont.regular.name
		visible: !dimState
	}

	Text {
		id: txtTimeBig
		text: app.timeStr
		color: dimmableColors.clockTileColor
		anchors {
			horizontalCenter: parent.horizontalCenter
			top: txtDate.bottom
		}

		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: qfont.tileTitle
		font.family: qfont.regular.name
	}



	Text {
		id: txtLast
		text: app.lastStart
		color: dimmableColors.clockTileColor
		anchors {
			horizontalCenter: parent.horizontalCenter
			top: txtTimeBig.bottom
			topMargin:isNxt? 15 : 12
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt? 15 : 12
		font.family: qfont.regular.name
		visible: !dimState
	}



}
