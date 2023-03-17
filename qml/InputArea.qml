
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

RowLayout {
	id: inputArea

	signal input(string text)

	anchors {
		left: parent.left
		right: parent.right
		bottom: parent.bottom
	}

	height: input.height

	function letsGo(){
		if (input.text == "")
			return;

		inputArea.input(input.text)

		input.text = "" // clears the field
	}

	TextEdit {
		id: input

		Layout.fillWidth: true
		Layout.minimumHeight: 80

		font.pixelSize: 24
		color: "#EEEEEE"

		verticalAlignment: Qt.AlignVCenter

		property bool shiftPressed: false

		Keys.onPressed: function(event) {
			if (event.key == Qt.Key_Shift) {
				shiftPressed = true
			}
		}
		Keys.onReleased: function(event) {
			if (event.key == Qt.Key_Shift) {
				shiftPressed = false
			}
		}

		Keys.onReturnPressed: function(event) {
			if (shiftPressed) {
				var oldCursor = cursorPosition
				text = text + "\n"
				cursorPosition = oldCursor + 1
			} else {
				inputArea.letsGo()
			}

			event.accepted = true
		}
	}

	Button {
		id: letsGoButton

		text: "letsu go"
		Layout.fillHeight: true

		font.pixelSize: 24

		onClicked: inputArea.letsGo()

		background: Rectangle {
			color: "#555555"
		}
		contentItem: Text {
			text: parent.text
			font: parent.font
			color: "#EEEEEE"
			verticalAlignment: Text.AlignVCenter
		}
	}
}
