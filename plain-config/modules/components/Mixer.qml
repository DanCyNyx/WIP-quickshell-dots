import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import qs.modules
import qs.modules.icons
ScrollView {
    id: root
    property real sliderWidth: 100
    contentWidth: availableWidth
    //contentHeight: availableHeight + 20
    padding: 5
    PwObjectTracker {
        objects: [Audio.sink, Audio.source]
    }
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5
        
        ColumnLayout {
            id: mixerEntry
            property PwNode node: Audio.sink

            // bind the node so we can read its properties
            PwObjectTracker { objects: [ mixerEntry.node ] }

            RowLayout {
                Label {
                    text: {
                        // application.name -> description -> name
                        const app = mixerEntry.node.properties["application.name"] ?? (mixerEntry.node.description != "" ? mixerEntry.node.description : mixerEntry.node.name);
                        const media = mixerEntry.node.properties["media.name"];
                        return media != undefined ? `${app} - ${media}` : app;
                    }
                    // Keeps the button within the confines of the ScrollView's width
                    width: root.width - sinkButton.width
                    maximumLineCount:1
                    wrapMode:Text.Wrap
                }

                Button {
                    id: sinkButton
                    text: mixerEntry.node.audio.muted ? "unmute" : "mute"
                    onClicked: mixerEntry.node.audio.muted = !mixerEntry.node.audio.muted
                }
            }

            RowLayout {
                Label {
                    Layout.preferredWidth: 50
                    text: `${Math.floor(mixerEntry.node.audio.volume * 100)}%`
                }

                StyledSlider {
                    Layout.preferredWidth: sliderWidth
                    //Layout.fillWidth: true
                    value: mixerEntry.node.audio.volume*100
                    onValueChanged: mixerEntry.node.audio.volume = value/100
                }
            }
        }
        Rectangle {
            Layout.fillWidth: true
            color: MainConfig.colors.secondary
            implicitHeight: 1
            radius: height/2
        }
        // Repeater for easyeffects controlled applications
        // Linktracking done in Audio.qml to filter out non-stream link sources
        Repeater {
            model: Audio.eeStreamLinkGroups
            ColumnLayout {
                id: eeMixerEntry
                required property var modelData
                property PwNode node: modelData?.source
                Component.onCompleted:{
                    const name = eeMixerEntry.node.name
                    console.log(`Easy Effects-${name}'s state = `,eeMixerEntry.modelData.state)
                }
                // bind the node so we can read its properties
                PwObjectTracker { objects: [ eeMixerEntry.node ] }

                RowLayout {
                    Label {
                        text: {
                            // application.name -> description -> name
                            const app = eeMixerEntry.node.properties["application.name"] ?? (eeMixerEntry.node.description != "" ? eeMixerEntry.node.description : eeMixerEntry.node.name);
                            const media = eeMixerEntry.node.properties["media.name"];
                            return media != undefined ? `Easy Effects - ${app} - ${media}` : app;
                        }
                        width: root.availableWidth - eeButton.width
                        maximumLineCount:1
                        wrapMode:Text.Wrap
                    }

                    Button {
                        id: eeButton
                        text: eeMixerEntry.node.audio.muted ? "unmute" : "mute"
                        onClicked: eeMixerEntry.node.audio.muted = !eeMixerEntry.node.audio.muted
                    }
                }

                RowLayout {
                    Label {
                        Layout.preferredWidth: 50
                        text: `${Math.floor(eeMixerEntry.node.audio.volume * 100)}%`
                    }

                    StyledSlider {
                        Layout.preferredWidth: sliderWidth
                        // Layout.fillWidth: true
                        value: eeMixerEntry.node.audio.volume*100
                        onValueChanged: eeMixerEntry.node.audio.volume = value/100
                    }
                }
            }
        }
        // Repeater for non Easy effects applications
        // Linktracking done in Audio.qml to filter out non-stream link sources
        Repeater {
            model: Audio.nonEEStreamLinkGroups 
            ColumnLayout {
                id: streamsMixerEntry
                required property var modelData
                property PwNode node: modelData?.source
                Component.onCompleted:{
                    const name = streamsMixerEntry.node?.name
                    console.log(`${name}'s state = `,streamsMixerEntry.modelData.state)
                }
                // bind the node so we can read its properties
                PwObjectTracker { objects: [ streamsMixerEntry.node ]}
                // The Lazy Loader prevents items from being shown unless they aren't from easyeffects
                RowLayout {
                    Label {
                        text: {
                            // application.name -> description -> name
                            const app = streamsMixerEntry.node.properties["application.name"] ?? (streamsMixerEntry.node?.description != "" ? streamsMixerEntry.node.description : streamsMixerEntry.node.name);
                            const media = streamsMixerEntry.node.properties["media.name"];
                            return media != undefined ? `${app} - ${media}` : app;
                        }
                        width: root.availableWidth - streamsButton.width
                        maximumLineCount:1
                        wrapMode:Text.Wrap
                    }

                    Button {
                        id:streamsButton
                        text: streamsMixerEntry.node.audio.muted ? "unmute" : "mute"
                        onClicked: streamsMixerEntry.node.audio.muted = !streamsMixerEntry.node.audio.muted
                    }
                }

                RowLayout {
                    Label {
                        Layout.preferredWidth: 50
                        text: `${Math.floor(streamsMixerEntry.node.audio.volume * 100)}%`
                    }

                    StyledSlider {
                        Layout.preferredWidth: sliderWidth
                        //Layout.fillWidth: true
                        value: streamsMixerEntry.node.audio.volume*100
                        onValueChanged: streamsMixerEntry.node.audio.volume = value/100
                    }
                }
            }
        }
        Item {
            Layout.fillWidth: true
            // color: 'transparent'
            implicitHeight: 10
        }
    }
}