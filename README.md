# Active Gate Plugin Build Environment
A Dynatrace Active Gate with Plugin SDK to use for local Plugin Development to overcome the hazzle of getting Python 3.6 venvs

## How to use
### Building the Container
This container is intended to use in Dynatrace Active Gate Plugin development scenarios where you do now want to go through the hazzle of installing an AG, the plugin SDK and the required dependencies locally or in a virtual machine.
Ideally you will have a Dynatrace tenant you can connect to (the initial AG installation will only work with a connection) and where you can deployt our plugins to.

Make sure you place the AG installer and the Plugin SDK with the latest verison. You can download them from your Dynatrace instance. Place them in the ```installers``` directory and name them with ```-latest```.

If your plugin needs any special native dependencies please modify the ```Dockerfile``` and add the libraries there (e.g. via ```pip install ...```)

Build the container by executing ```build.sh```

### Building a Plugin
When building Active Gate plugin I recommend to use this folder structure:

```
| - <pluginname>_plugin             # ensure the directory ends with _plugin
   \ - plugin.json
   \ - <pluginname>.py
  - plugin_deployment               # empty directory which will contain the build plugin

  build_plugin.sh                   # script to call to build the plugin
  plugin_sdk.conf                   # plugin SDK configuraton file (e.g. target Dynatrace Tenant to deploy to)
  plugin_upload.token               # Dynatrace API token to deploy the plugin
```

Optionally you can automatically deploy the plugint o your active gate. Please see ```build_plugin.sh``` and e.g. add a ```scp``` command there to upload.