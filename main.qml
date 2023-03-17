import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

ApplicationWindow {
	id: application
    visible: true
    width: 600
	height: 500
	property var laala: undefined
	property var history: []
    title: "LAALA"

	color: "#333333"

	ListView {
		id: historyArea

		clip: true

		function scrollToBottom() {
			contentY = contentHeight - height
		}

		anchors {
			left: parent.left
			right: parent.right
			top: parent.top
			bottom: inputArea.top
		}

		model: application.history

		delegate: Message {
			Layout.alignment: Qt.AlignTop
			from: modelData.from
			message: modelData.message
		}
	}

	RowLayout {
		id: inputArea

		anchors {
			left: parent.left
			right: parent.right
			bottom: parent.bottom
		}

		height: 80

		function letsGo(){
			if (input.text == "")
				return;

			var answer = laala.ask(input.text)

			application.history.push({
				"from": "user",
				"message": input.text
			})
			application.history.push({
				"from": "laala",
				"message": answer
			})
			history = history; // forces redraw

			input.text = "" // clears the field

			historyArea.scrollToBottom()
		}

		TextEdit {
			id: input

			Layout.fillWidth: true
			Layout.fillHeight: true

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

			Keys.onReturnPressed: {
				if (shiftPressed) {
					var oldCursor = cursorPosition
					text = text + "\n"
					cursorPosition = oldCursor + 1
				} else {
					inputArea.letsGo()
				}
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
}
