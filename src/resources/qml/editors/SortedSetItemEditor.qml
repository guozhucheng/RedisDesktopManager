import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1
import QtQuick.Dialogs 1.2

import "."

AbstractEditor {
    id: root
    anchors.fill: parent

    Text {
        Layout.fillWidth: true
        text: "Score:"
    }

    TextField {
        id: scoreText

        Layout.fillWidth: true
        Layout.minimumHeight: 35

        text: ""
        enabled: originalValue != "" || !editingMode
        property string originalValue: ""
        placeholderText: "Score"
        validator: DoubleValidator { locale: "C" } // force point as decimal separator
    }

    Text {
        Layout.fillWidth: true
        text: "Value:"
    }

    TextArea {
        id: textArea
        Layout.fillWidth: true
        Layout.fillHeight: true
        text: ""
        enabled: originalValue != "" || !editingMode
        property string originalValue: ""
    }

    function setValue(rowValue) {
        scoreText.originalValue = rowValue['score']
        scoreText.text = rowValue['score']
        textArea.originalValue = rowValue['value']
        textArea.text = rowValue['value']
    }

    function isValueChanged() {
        return textArea.originalValue != textArea.text
                || scoreText.originalValue != scoreText.text
    }

    function resetAndDisableEditor() {
        textArea.originalValue = ""
        textArea.text = ""
        scoreText.originalValue = ""
        scoreText.text = ""
    }

    function getValue() {
        return {"value": textArea.text, "score": scoreText.text}
    }    

    function isValueValid() {
        var value = getValue()

        return value && value['score'] && value['value']
                && value['score'].length > 0
                && value['value'].length > 0
    }

    function markInvalidFields() {
        keyText.textColor = "black"
        textArea.textColor = "black"
        // Fixme
    }

    function reset() {
        textArea.text = ""
        scoreText.text = ""
    }

}
