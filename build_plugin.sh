#!/bin/bash

# Builds and optionally deploys the plugin,
# using a Docker container with an AG and the SDK installed to avoid the hazzle of setting up a build environment locally or on an AG itself
# This might require to add additional python modules (native) to the Docker container if required by the plugin.

# Make sure to create two files in this directory to configure the plugin upload
# - plugin_sdk.conf - content: "pluginUploadUrls https://<your dt tenant url>:443/api/v1/remoteplugins"
# - plugin_upload.token - content: plain DT API token with permissions to upload plugins

docker run \
  -v ${PWD}/plugin_sdk.conf:/opt/dynatrace/remotepluginmodule/agent/conf/plugin_sdk.conf \
  -v ${PWD}/plugin_upload.token:/opt/dynatrace/remotepluginmodule/agent/conf/plugin_upload.token \
  -v ${PWD}/$(ls -1 -d *_plugin):/plugin \
  -v ${PWD}/plugin_deployment:/opt/dynatrace/remotepluginmodule/plugin_deployment ag_plugindev plugin_sdk build_plugin


# upload the build plugin to Active Gate, make sure the user has permissions to create files in the target directory
# scp -q -r plugin_deployment/* user@dt-ag-01.local:/opt/dynatrace/remotepluginmodule/plugin_deployment/