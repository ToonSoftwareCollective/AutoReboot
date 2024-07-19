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
		lastStart = "(laatste start: " + dateStr + " " + timeStr	+ ")"
	
		// calculate new restart interval to two days later at 03:30
		var nowUtc = Date.UTC(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes(), now.getSeconds(),now.getMilliseconds());
		var nextRestartDate = Date.UTC(now.getFullYear(), now.getMonth(), now.getDate() + 2, 3, 30, 0, 0);
		timeStr = "03:00"
		dateStr = i18n.dateTime(nextRestartDate , i18n.date_yes)

		datetimeTimer.interval = nextRestartDate - nowUtc;
		datetimeTimer.start();
		console.log("Autorestart in:" + (nextRestartDate - nowUtc) + " ms from: " + now);
	}

	Timer {
		id: datetimeTimer
		triggeredOnStart: false
		running: false
		repeat: false
		onTriggered: {
			restartToon()
		}
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
