#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-



function remix_orte () {
  local SELFPATH="$(readlink -m "$BASH_SOURCE"/..)"
  cd "$SELFPATH" || return $?

  ./lib_grabhtml.sh save_prettier_html info/orte.php

  return 0
}










[ "$1" == --lib ] && return 0; remix_orte "$@"; exit $?
