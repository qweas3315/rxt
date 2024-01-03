import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { ISearchDTO } from '../model/order';

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