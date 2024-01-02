import http from '@ohos.net.http';
import { AppConfig } from '../config'

export const userLogin = (data: {
  username: string,
  password: string
}) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    `${AppConfig.baseUrl}/user/login`,
    {
      method: http.RequestMethod.POST,
      extraData: data,
      header: {
        'Content-Type': 'application/json'
      }
    });
}