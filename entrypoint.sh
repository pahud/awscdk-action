#!/bin/sh -l



output=$(cdk $@)
echo "::set-output name=output::$output"
