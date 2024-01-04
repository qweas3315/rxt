import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { IAddress } from '../model/address';

export const getAllAddressApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/address/selectByOwnName`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const getDefaultAddressApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/address/selectDefaultByOwnName`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const deleteAddressApi = (id: number) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/address/delete/${id}`),
    {
      method: http.RequestMethod.DELETE,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const editAddressApi = (data: IAddress) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/address/defaultAddressInfoUpdate`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const addAddressApi = (data: IAddress) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/address/add`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}