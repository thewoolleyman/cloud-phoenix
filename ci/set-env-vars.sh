#!/usr/bin/env bash

BUILD_NUMBER=${BUILDKITE_BUILD_NUMBER:-${BUILD_NUMBER}}

# CF
CF_ORG=${CF_ORG:-cwoolley-sandbox}
CF_SPACE=${CF_SPACE:-staging}
CF_API_ENDPOINT=${CF_API_ENDPOINT:-https://api.run.pivotal.io}