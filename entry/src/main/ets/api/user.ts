import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { IUser, IUserLoginDTO, IUserRegisterDTO } from '../model/user';

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

export const getUserInfoApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/loginSelectByUsername`, {
    method: http.RequestMethod.GET,
    header: {
      Authorization: globalThis.token
    }
  })
}

export const editUserInfoApi = (data: IUser) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/loginUpdateByUsername`, {
    method: http.RequestMethod.POST,
    header: {
      Authorization: globalThis.token
    },
    extraData: data
  })
}