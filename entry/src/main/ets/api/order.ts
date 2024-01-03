import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { ISearchDTO } from '../model/order';

export const searchAllByKeys = (data: ISearchDTO) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    `${AppConfig.baseUrl}/order/searchAllByKeys/${data.keyword}/${data.pageNum}`,
    {
      method: http.RequestMethod.POST,
      extraData: data,
      header: {
        'Content-Type': 'application/json'
      }
    });
}