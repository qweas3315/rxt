import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { IExpert } from '../model/question';
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

export const updatePasswordApi = (newPassword: string, oldPassword: string) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/loginUpdatePassword`, {
    method: http.RequestMethod.POST,
    header: {
      Authorization: globalThis.token
    },
    extraData: {
      newPassword: newPassword,
      oldPassword: oldPassword
    }
  })
}

export const searchExpertApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/searchexpert`, {
    method: http.RequestMethod.GET,
    header: {
      Authorization: globalThis.token
    }
  })
}

export const updateExpertApi = (data: IExpert) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/addUpdexpert`, {
    method: http.RequestMethod.POST,
    header: {
      Authorization: globalThis.token
    },
    extraData: data
  })
}

export const getUserListApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/search/1`, {
    method: http.RequestMethod.GET,
    header: {
      Authorization: globalThis.token
    }
  })
}

export const updateUserApi = (data: IUser) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/${data.userName}`, {
    method: http.RequestMethod.PUT,
    header: {
      Authorization: globalThis.token
    },
    extraData: data
  })
}

export const deleteUserApi = (content: string) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(`${AppConfig.baseUrl}/user/${content}`, {
    method: http.RequestMethod.DELETE,
    header: {
      Authorization: globalThis.token
    }
  })
}