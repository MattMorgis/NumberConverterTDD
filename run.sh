#!/bin/bash

# Remove old build
rm -rf build

# Make directory for .class output files
mkdir build
mkdir build/production/
mkdir build/test/

# Compile production code
javac -d build/production/ src/*
if [ $? -ne 0 ]; then
    echo 'Production Code Failed to Compile!'
    exit $?
fi

# Compile test code
javac -d build/test/ -cp lib/junit-4.10.jar:build/production test/*
if [ $? -ne 0 ]; then
    echo 'Test Code Failed to Compile!'
    exit $?
fi

# Run the tests!
java -cp build/test/:build/production/:lib/junit-4.10.jar org.junit.runner.JUnitCore NumberConverterTest
