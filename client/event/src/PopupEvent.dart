//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Thu, May 10, 2012  3:33:05 PM
// Author: tomyeh

/**
 * A popup event. It is a broadcast event used to notify popup views and elements
 * that another popup is showing. By popup we mean a UI object that is shown up
 * only in short period of time, and dismissed as soon as the user takes an action.
 * For example, clicking somewhere else.
 * <p>A popup shall listen to this event by registering the listener to [broadcaster].
 * When the listener is called, it shall invoke [shallClose] to check if the popup
 * has to be closed.
 */
class PopupEvent extends ViewEvent<Object> {
	/** Constructor.
	 * The source parameter is either an instance of [View], a DOM element, or null.
	 * If null, it means all pop ups shall be closed.
	 */
	PopupEvent(var source, [String type="popup"]):
	super(null, type, source) {
	}
	/** Returns the UI object triggers this event.
	 * It is either a view or a DOM element.
	 */
	get source() => data;

	/** Whether the given popup shall be closed.
	 */
	bool shallClose(popup) {
		if (source === null)
			return true;

		var srcNode, popNode;
		if (source is View) {
			if (popup is View)
				return !source.isDescendantOf(popup);
			srcNode = source.node;
			popNode = popup;
		} else {
			srcNode = source;
			popNode = popup is View ? popup.node: popup;
		}
		return !new DomQuery(srcNode).isDescendantOf(popNode);
	}
}
