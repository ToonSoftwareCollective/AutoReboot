import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0
import BxtClient 1.0

App {
	id: autoRebootApp

	property url tileUrl : "AutoRebootTile.qml"
	property url thumbnailIcon: "qrc:/tsc/refresh.png"
	property string configMsgUuid : ""

	property string timeStr
	property string dateStr
	property string lastStart



	function init() {
		registry.registerWidget("tile", tileUrl, autoRebootApp, null, {thumbLabel: qsTr("Auto Reboot"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
	}

	Component.onCompleted: {
 		var now = new Date()
		var now2 = now.getTime()
		timeStr = i18n.dateTime(now2, i18n.time_yes)
		dateStr = i18n.dateTime(now2, i18n.date_yes)
		lastStart = "(laaste start: " + dateStr + " " + timeStr	+ ")"
	}


	function updateClockTiles() {
		var now = new Date()
		var now2 = now.getTime()
		timeStr = i18n.dateTime(now2, i18n.time_yes)
		dateStr = i18n.dateTime(now2, i18n.mon_full)
		var day = parseInt(now.getDay())
		if ((day == 1 || day == 3 || day == 5) & (timeStr == "3:30" || timeStr == "03:30") ){console.log(timeStr);console.log(day);console.log("restarting");restartToon()}
	}

	Timer {
		id: datetimeTimer
		interval: 60000
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: {updateClockTiles()}
	}
	
	function restartToon() {
		var restartToonMessage = bxtFactory.newBxtMessage(BxtMessage.ACTION_INVOKE, configMsgUuid, "specific1", "RequestReboot")
		bxtClient.sendMsg(restartToonMessage)
	}

	BxtDiscoveryHandler {
		id: configDiscoHandler
		deviceType: "hcb_config"
		onDiscoReceived: {
			configMsgUuid = deviceUuid
		}
	}
}
