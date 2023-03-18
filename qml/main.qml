import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

ApplicationWindow {
	id: application
	flags: Qt.Window | Qt.CustomizeWindowHints | Qt.WindowMaximizeButtonHint

    visible: true
    width: 600
	height: 720
	property var laala: undefined
	property var history: []
    title: "LAALA"

	color: "#333333"

	WindowResizeAreas {
		anchors.fill: parent
	}

	Rectangle {
		id: topWindowBorder

		height: 32

		color: "#666666"

		MouseArea {
			anchors.fill: parent

			pressAndHoldInterval: 10
			acceptedButtons: Qt.LeftButton
			onPressAndHold: {
				application.startSystemMove()
			}
		}

		anchors {
			left: parent.left
			right: parent.right
		}

		RowLayout {
			anchors.fill: parent

			Text {
				text: "Laala"
				color: "#EEEEEE"
				font.pixelSize: 24
			}

			Item {
				Layout.fillHeight: true
				Layout.fillWidth: true
				height: 1
			}

			Button {
				Layout.fillHeight: true
				width: height
				text: "×"
				font.pixelSize: 24
				onClicked: Qt.quit()
				flat: true
			}
		}
	}

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
			top: topWindowBorder.bottom
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
