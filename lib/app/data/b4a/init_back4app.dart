import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class InitBack4app {
  InitBack4app() {
    // init();
  }

  Future<bool> init() async {
    const keyApplicationId = 'SLWtrlBJSzdUpAvA2Jh1aXkr87k65vuB3Mjvkjco';
    const keyClientKey = 'tOL1RPSDXUlWQ7m6ZtPX8fTrtKfvqYpYqqtuyzgZ';
    const keyParseServerUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(
      keyApplicationId,
      keyParseServerUrl,
      clientKey: keyClientKey,
      autoSendSessionId: true,
      debug: true,
    );
    return (await Parse().healthCheck()).success;
  }
}
