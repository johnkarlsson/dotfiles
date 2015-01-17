#!/bin/sh

# Three finger middle click.
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient ClickFinger1=1
synclient ClickFinger2=3
synclient ClickFinger3=2

# Allow releasing for 300ms while dragging (double tap).
synclient LockedDrags=1
synclient LockedDragTimeout=300

# Disable top corners to avoid accidental clicks when typing.
synclient LTCornerButton=0
synclient RTCornerButton=0
# Default bottom right = middle click. Good idea but use mouse1 for now.
synclient RBCornerButton=1
# Default bottom left = disabled for no reason. Set to mouse1.
synclient LBCornerButton=1

# Default sensitivity 75 (low value = higher sensitivity)
synclient FingerHigh=90

# Same horizontal scrolling as vertical.
synclient HorizEdgeScroll=1
synclient HorizTwoFingerScroll=1
