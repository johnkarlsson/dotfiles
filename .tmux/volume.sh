#!/bin/bash
echo "#[fg=colour240]Vol#[default] $(pamixer --get-volume)%$(pamixer --get-mute | sed -e 's/true/ #[fg=colour240](off)#[default]/' -e 's/false//')"
