import QtQuick 2.15

Rectangle {
	id: widget

	property string from: "user"
	property string message: ""

	color:
		from == "user" ? Qt.darker("skyblue", 1.5) :
		from == "laala" ? Qt.darker("salmon", 1.5) :
		"red"

	Text {
		id: text

		text: widget.message
		font.pixelSize: 24

		color: "#EEEEEE"
	}

	height: text.height
	width: text.width
}

