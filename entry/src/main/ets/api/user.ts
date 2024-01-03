import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { IUserLoginDTO, IUserRegisterDTO } from '../model/user';

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

export const userRegisterApi = (data: IUserRegisterDTO) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    `${AppConfig.baseUrl}/user/add`,
    {
      method: http.RequestMethod.POST,
      extraData: data,
      header: {
        'Content-Type': 'application/json'
      }
    });
}