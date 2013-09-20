#!/bin/bash

# Push to current branch by def
git config --global push.default simple 
# Global ignore, just tags atm.
git config --global core.excludesfile '.cvsignore'
