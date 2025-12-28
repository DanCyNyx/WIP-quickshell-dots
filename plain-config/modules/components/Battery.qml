import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import qs.modules
pragma Singleton

// Battery component to get info about the system's battery from Upower 
// TODO Battery: add functionality to remove battery info if there is no battery connected
Singleton {
    id: root
    // code gotten from end_4's illogical-impulse repo
    readonly property bool available: UPower.displayDevice.isLaptopBattery & MainConfig.battery.isFunctional
    readonly property var chargeState: UPower.displayDevice.state
    readonly property bool isCharging: chargeState == UPowerDeviceState.Charging
    readonly property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    readonly property real percentage: UPower.displayDevice?.percentage ?? 1
    // Battery levels to warn user
    property bool battLow: available && (percentage <= 30/100)
    property real critLevel: 10
    property bool battCritical: available && (percentage <= critLevel/100)
    // Max charge level of the laptop
    property real maxBattLevel: 60
    property bool battFull: available && (percentage >= maxBattLevel/100)
    // Time left for battery  
    property real timeToEmpty: UPower.displayDevice.timeToEmpty
    property real timeToFull: UPower.displayDevice.timeToFull
    // Suspend and sound options (to be set by a different file)
    property bool automaticSuspend: MainConfig.battery.automaticSuspend
    property bool soundEnabled: true
    property real suspendTime: 10 // Default 10 seconds
    // Booleans to use to notify user
    property bool lowAndNotCharging: battLow && !isCharging
    property bool critAndNotCharging: battCritical && !isCharging && automaticSuspend
    property bool fullAndCharging: battFull && isCharging
    ///////////////////////////////////
    // Booleans and output statements//
    ///////////////////////////////////
    onLowAndNotChargingChanged: {
        if (!root.available || !lowAndNotCharging) return;
        Quickshell.execDetached([
            "notify-send", 
            "Low battery", 
            "Consider plugging in your device", 
            "-u", "critical",
            "-a", "Shell",
            "--hint=int:transient:1",
        ])
        if (root.soundEnabled) MainConfig.audio.playSystemSound("dialog-warning");
    }

    onCritAndNotChargingChanged: {
        if (!root.available || !critAndNotCharging) return;
        Quickshell.execDetached([
            "notify-send", 
            "Battery is Critical", 
            ("Please charge!\nAutomatic suspend triggers in %1s").arg(suspendTime), 
            "-u", "critical",
            "-a", "Shell",
            "--hint=int:transient:1",
        ])
        suspendTimer.running = true
        if (root.soundEnabled) MainConfig.audio.playSystemSound("suspend-error");
    }
    onFullAndChargingChanged: {
        if (!root.available || !fullAndCharging) return;
        Quickshell.execDetached([
            "notify-send",
            /* Translation.tr(*/"Battery full",
            "Unplug the charger to preserve battery health",
            "-a", "Shell",
            "--hint=int:transient:1",
        ]);
        if (root.soundEnabled) MainConfig.audio.playSystemSound("complete");
    }
    
    onIsPluggedInChanged: {
        if (!root.available || !root.soundEnabled) return;
        if (isPluggedIn) {
            MainConfig.audio.playSystemSound("power-plug")
        } else {
            MainConfig.audio.playSystemSound("power-unplug")
        }
    }
    // Process and timer to suspend after suspendTime seconds if batt critical and not charging
    Process {
        id: battsuspend
        command: ["bash","-c", `systemctl suspend || loginctl suspend`]
        running: false
    }
    Timer {
        id: suspendTimer
        interval: 1000 * suspendTime // suspendTime seconds
        running: false
        repeat: false
        // if the battery is critical and not charging after suspend time, process runs
        onTriggered: battsuspend.running = (root.available && critAndNotCharging)
    }    
}