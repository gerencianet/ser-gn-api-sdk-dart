import 'package:gerencianet/gerencianet.dart';
import 'package:test/test.dart';
import '../../../examples/default/subscription/updateSubscriptionMetadata.dart';
import '../../../examples/default/subscription/createSubscription.dart';
import '../../../examples/default/subscription/createPlan.dart';
import '../../credentials.dart';

void main() async {
  Gerencianet gn = Gerencianet(CREDENTIALS_DEFAULT);
  testUpdateSubscriptionMetadata(gn);
}

dynamic testUpdateSubscriptionMetadata(Gerencianet gn) async {
  test('subscription update metadata', () async {
    dynamic plan = _verifyCreatePlan(await createPlan(gn));
    dynamic subscription = _verifyCreateSubscription(
        await createSubscription(gn, plan['data']['plan_id']));
    _verifyUpdateSubscriptionMetadata(await updateSubscriptionMetadata(
        gn, subscription['data']['subscription_id']));
  });
}

dynamic _verifyUpdateSubscriptionMetadata(dynamic response) {
  expect(response.keys.toList(), equals(['code']));
  expect(response['code'], equals(200));
  return response;
}

dynamic _verifyCreateSubscription(dynamic response) {
  expect(response.keys.toList(), equals(['code', 'data']));
  expect(response['code'], equals(200));
  expect(
      response['data'].keys.toList(),
      equals(
          ['subscription_id', 'status', 'custom_id', 'charges', 'created_at']));
  return response;
}

dynamic _verifyCreatePlan(dynamic response) {
  expect(response.keys.toList(), equals(['code', 'data']));
  expect(response['code'], equals(200));
  expect(response['data'].keys.toList(),
      equals(['plan_id', 'name', 'interval', 'repeats', 'created_at']));
  return response;
}
