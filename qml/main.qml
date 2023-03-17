import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

ApplicationWindow {
	id: application
    visible: true
    width: 600
	height: 720
	property var laala: undefined
	property var history: []
    title: "LAALA"

	color: "#333333"

	ListView {
		id: historyArea

		anchors.margins: 16

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

		delegate: Loader {
			sourceComponent: modelData.type == "separator" ? separator : textMessage

			Component {
				id: textMessage

				Message {
					Layout.alignment: Qt.AlignTop
					from: modelData.from
					message: modelData.message
				}
			}

			/* Some arbitrary spacing. Takes some space, doesn't actually draw. */
			Component {
				id: separator

				Item {
					height: 8
					width: 8
				}
			}
		}
	}

	InputArea {
		id: inputArea

		anchors.margins: 16

		onInput: function(text) {
			var answer = laala.ask(text)

			if (application.history.length > 0) {
				application.history.push({
					"type": "separator"
				})
			}

			application.history.push({
				"from": "user",
				"message": text
			})
			application.history.push({
				"from": "laala",
				"message": answer
			})
			history = history; // forces redraw

			historyArea.scrollToBottom()
		}
	}
}
