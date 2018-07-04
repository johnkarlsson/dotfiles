#!/bin/bash
TOTAL=$(free | sed -r 's/ +/\t/g' | cut -f 2 | head -n 2 | tail -n 1)
FREE=$(free | sed -r 's/ +/\t/g' | cut -f 3 | head -n 2 | tail -n 1)
PERC=$(python -c "print('{:.0f}%'.format($FREE / $TOTAL * 100))")
echo "#[fg=colour240]Mem#[default] $PERC"
