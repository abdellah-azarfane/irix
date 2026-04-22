import QtQuick
import Quickshell
import Niri 0.1 

Item {
    Niri {
        id: niri 
    }

    Row {
        Repeater {
            model: niri.workspaces
            
            delegate: Rectangle {
                width: 24
                height: 24
                color: modelData.isFocused ? "blue" : "gray" 
            }
        }
    }
}