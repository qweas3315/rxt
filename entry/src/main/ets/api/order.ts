import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { IOrderInfo, ISearchDTO } from '../model/order';

export const searchAllByKeys = (data: ISearchDTO) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/order/searchAllByKeys/${data.keyword}/${data.pageNum}`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      }
    });
}

export const getOrderPage = (current: number) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/order/All/${current}`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      }
    });
}

export const getGoodsPage = (type: string, pageNum: number) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/order/${type}/${pageNum}`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      }
    });
}

export const getUserBuyGoods = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/order/selectBuys`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const getUserSellGoodsList = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/order/selectSells`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const getUserPurchaseGoodsList = (type: string, current: number) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/order/search/${type}/${current}`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const addUserPurchaseGoods = (data: IOrderInfo) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/order`),
    {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const editUserPurchaseGoods = (data: IOrderInfo) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/order/${data.orderId}`),
    {
      method: http.RequestMethod.PUT,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}

export const deleteUserPurchaseGoods = (orderId: number) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/order/${orderId}`),
    {
      method: http.RequestMethod.DELETE,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}