#!/bin/bash

cat ~/.emacs.d/init.el | perl -pe "s|(\(spacemacs/init\))|\1\n  \(add-to-list 'package\-archives\n\t\t '\(\"melpa-stable\" \. \"https://stable\.melpa\.org/packages/\"\) t\)|sg" > ~/.emacs.d/init.el_temp
mv ~/.emacs.d/init.el_temp ~/.emacs.d/init.el
