pragma Singleton
import QtQuick
import Quickshell.Io

Item {
    id: root

    // Expose the raw parsed JSON
    property var colors: ({})
    property bool isDark: true // You can toggle this based on system preference

    // Helper property to easily grab the active schema
    readonly property var activeColors: isDark ? (colors.dark || {}) : (colors.light || {})

    File {
        id: matugenFile
        // Make sure you run: matugen image wall.jpg -t json-hex > ~/.cache/matugen-colors.json
        path: Quickshell.env("HOME") + "/.cache/matugen-colors.json"
        
        onContentChanged: {
            try {
                if (content.length > 0) {
                    let parsed = JSON.parse(content);
                    root.colors = parsed.colors;
                    console.log("Matugen colors loaded successfully!");
                }
            } catch (e) {
                console.error("Failed to parse Matugen JSON: " + e);
            }
        }
    }

    Component.onCompleted: {
        matugenFile.read();
    }
}