import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import DigiShow 1.0

import "components"

MwInterfaceListView {

    id: interfaceListView

    interfaceType: "dmx"

    dataModel: ListModel {

       ListElement {
           name: "_new"
           type: ""
           mode: ""
           comPort: ""
       }
    }

    delegate: Rectangle {

        width: gridView.cellWidth
        height: gridView.cellHeight
        color: "transparent"

        MwInterfaceListItem {

            Item {
                anchors.fill: parent
                visible: model.name !== "_new"

                COptionButton {
                    id: buttonDmxComPort
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 20
                    text: {
                        if (model.comPort===undefined || model.comPort==="") return qsTr("Automatic")
                        return model.comPort
                    }

                    onClicked: {
                        menuDmxComPort.selectOptionWithTag(model.comPort===undefined ? "" : model.comPort)
                        menuDmxComPort.showOptions()
                    }

                    COptionMenu {
                        id: menuDmxComPort

                        optionItems: {
                            var items = listOnline["dmx"]
                            var options = [ { text:  qsTr("Automatic"), value: -1, tag: "" } ]
                            for (var n=0 ; n<items.length ; n++) {
                                options[n+1] = {
                                    text: items[n]["comPort"],
                                    value: n,
                                    tag: items[n]["comPort"]
                                }
                            }
                            return options
                        }

                        onOptionSelected: {
                            var options = {
                                comPort: selectedItemTag
                            }
                            updateInterface(model.index, options)
                        }
                    }

                    Label {
                        anchors.left: parent.left
                        anchors.bottom: parent.top
                        anchors.bottomMargin: 10
                        font.pixelSize: 11
                        text: qsTr("USB Serial Port")

                    }
                }
            }
        }
    }

    Component.onCompleted: {

    }
}


