import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { IShoppingModel } from '../model/order';

export const getCartListApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/cart/show`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}