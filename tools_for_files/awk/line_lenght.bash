#!/usr/bin/bash

FN=$1

awk '{print NR, length}' "${FN}"

