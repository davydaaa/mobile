import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTService {
  static final _client = MqttServerClient('broker.hivemq.com', 'flutter_client_${DateTime.now().millisecondsSinceEpoch}');
  static void Function(String)? onMessage;

  static Future<void> connect() async {
    _client.port = 1883;
    _client.keepAlivePeriod = 20;
    _client.onConnected = () => print('MQTT connected');
    _client.onDisconnected = () => print('MQTT disconnected');
    _client.logging(on: false);
    _client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier(_client.clientIdentifier!)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);

    try {
      await _client.connect();
    } catch (e) {
      print('MQTT connection failed: $e');
      _client.disconnect();
    }

    if (_client.connectionStatus!.state == MqttConnectionState.connected) {
      _client.subscribe('sensor/temperature', MqttQos.atMostOnce);
      _client.updates!.listen((messages) {
        final recMess = messages[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        if (onMessage != null) onMessage!(payload);
      });
    }
  }

  static void listen(void Function(String) callback) {
    onMessage = callback;
  }
}
