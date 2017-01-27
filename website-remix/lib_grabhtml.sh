#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function grabhtml__save_prettier_html () {
  local CHC="$(readlink -m "$BASH_SOURCE"/..)/cache"
  mkdir -p "$CHC"
  local URL_PATH="$1"; shift
  URL_PATH="${URL_PATH%%#*}"
  local SRC_URL="http://www.wave-gotik-treffen.de/${URL_PATH#/}"

  local SAVE_BFN="${URL_PATH%%\?*}"
  SAVE_BFN="${SAVE_BFN%/}"
  SAVE_BFN="${SAVE_BFN##*/}"
  local SAVE_ORIG="$CHC/$SAVE_BFN.@$(date +%y%m%d).orig"
  [ -s "$SAVE_ORIG" ] || wget -c "$SRC_URL" -O "$SAVE_ORIG" || return $?

  local SAVE_CLEAN="$SAVE_BFN"
  SAVE_CLEAN="${SAVE_CLEAN%.php}"
  SAVE_CLEAN="${SAVE_CLEAN%.html}"
  SAVE_CLEAN="$CHC/$SAVE_CLEAN.html"
  sed -re '
    : read_all
    $!{N;b read_all}
    s~^.*id="maincontent"[^<>]*>\s*~~
    s~\s*<div class="wgtfooter">\s*<footer.*$~~
    s~\t~  ~g
    s~\s*(<(table|h[1-6])\b)~\n\1~g
    s~\s*(<div class="col )~\n\n\1~g
    s~\s*(<(tr|caption)\b)~\n  \1~g
    s~\s*(<(t[dh])\b)~\n    \1~g
    ' -- "$SAVE_ORIG" >"$SAVE_CLEAN" || return $?
  return 0
}










[ "$1" == --lib ] && return 0; grabhtml__"$@"; exit $?
