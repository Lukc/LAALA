import QtQuick 2.15

Item {
	id: widget

	property string from: "user"
	property string message: ""
	property int maximumWidth: 999

	Rectangle {
		color: "olive"
		anchors.fill: parent
	}

	Rectangle {
		id: background

		color:
			from == "user" ? Qt.darker("skyblue", 1.5) :
			from == "laala" ? Qt.darker("salmon", 1.5) :
			"red"

		anchors.fill: text
	}

	TextInput {
		id: text

		text: widget.message
		font.pixelSize: 24

		readOnly: true
		selectByMouse: true

		color: "#EEEEEE"

		wrapMode: TextInput.WordWrap
		width: Math.min(implicitWidth, parent.maximumWidth)
	}

	height: text.height
	width: text.width
}

