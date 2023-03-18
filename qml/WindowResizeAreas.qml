import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Item {
	MouseArea{
		id : bottomRightResizer
		width: 12
		height: 12
		anchors.bottom: parent.bottom
		anchors.right: parent.right

		cursorShape: Qt.SizeFDiagCursor
		acceptedButtons: Qt.LeftButton
		pressAndHoldInterval: 100
		onPressAndHold: {
			application.startSystemResize(Qt.BottomEdge | Qt.RightEdge)
		}
	}

	MouseArea {
		id : bottomLeftResizer
		width: 12
		height: 12
		anchors.bottom: parent.bottom
		anchors.left: parent.left

		cursorShape: Qt.SizeBDiagCursor
		acceptedButtons: Qt.LeftButton
		pressAndHoldInterval: 100
		onPressAndHold: {
			application.startSystemResize(Qt.BottomEdge | Qt.LeftEdge)
		}
	}

	MouseArea {
		id : bottomResizer
		height: 12
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.leftMargin: 12
		anchors.rightMargin: 12

		cursorShape: Qt.SizeVerCursor
		acceptedButtons: Qt.LeftButton
		pressAndHoldInterval: 100
		onPressAndHold: {
			application.startSystemResize(Qt.BottomEdge)
		}
	}
}
