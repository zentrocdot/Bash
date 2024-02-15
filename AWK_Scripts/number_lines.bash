#!/usr/bin/bash

FN=$1

awk '{print NR, $0}' "${FN}"
