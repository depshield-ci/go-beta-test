#!/usr/bin/env bash
#
# Copyright (c) 2017-present Sonatype, Inc. All rights reserved.
# Includes the third-party code listed at http://links.sonatype.com/products/nexus/attributions.
# "Sonatype" is a trademark of Sonatype, Inc.
#

set -ex

if [ ! -f go.mod ] ; then
  echo no recognized project descriptor files found - i.e. go.mod &> ${DEFENDER_DATA}/run_go.out
  exit 1
fi

# Get the base path where output will be written
OUTPUT_FILE=$(realpath run_go.out)
echo $OUTPUT_FILE
# Set the start return code to 1, it will be changed if any tree is success
rc=1;

# Find all go.mod files, excluding those in directories ignored by go
while read line; do
  echo "----------" &&>> $OUTPUT_FILE

  # Remove "go.mod" to get the relative path where the file is located
  relativePath=${line/go.mod/""};
  cd $relativePath;
  echo "RelativePath: '$relativePath'" &&>> $OUTPUT_FILE

  # Note the module name, required for parsing
  moduleName=$(cat go.mod | head -n 1);
  echo "ModuleName: '$moduleName'" &&>> $OUTPUT_FILE

  # Note all replace statements in go.mod
  echo "Replace: " &&>> $OUTPUT_FILE
  cat go.mod | grep -i "\s*replace\s*.*\s*=>.*" | while read lineReplace; do
    echo "  ${lineReplace}" &&>> $OUTPUT_FILE
  done;
  echo "" &&>> $OUTPUT_FILE

  # Now get the dependency tree
  set +e
  go mod graph &> ./run_go_local.out
  returnValue=$?
  set -e
  if [ $returnValue -eq 0 ]; then
    echo "SUCCESS" &&>> $OUTPUT_FILE
    echo "Dependencies: " &&>> $OUTPUT_FILE
    rc=$returnValue;
  else
    echo "FAILED" &&>> $OUTPUT_FILE
  fi;
  cat ./run_go_local.out &&>> $OUTPUT_FILE
  cd -;
  echo "----------" &&>> $OUTPUT_FILE
done <<< "$(find . -name 'go.mod' -not -path "*/_*/*" -not -path "*/.*/*" -not -path "*/testdata/*")";
exit $rc;

