import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { IReserve } from '../model/reserve';

export const addReserveApi = (data: IReserve) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/reserve/add`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const getUserReserveApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/reserve/selectByKind/questioner`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
    });
}