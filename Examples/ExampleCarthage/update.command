#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

cd "$DIR"

# Download dependencies without building
carthage update --no-build


# Build modified dependencies
carthage build --platform iOS --use-xcframeworks