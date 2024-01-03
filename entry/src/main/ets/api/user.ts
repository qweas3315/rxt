import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { IUserLoginDTO } from '../model/user';

export const userLoginApi = (data: IUserLoginDTO) => {
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