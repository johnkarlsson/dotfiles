#!/bin/bash
echo "$(pamixer --get-volume)%$(pamixer --get-mute | sed -e 's/true/ (off)/' -e 's/false//')"
