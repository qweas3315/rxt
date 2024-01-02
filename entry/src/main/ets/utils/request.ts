import http from '@ohos.net.http';
import { AppConfig } from '../config';

export const post = <T>(url: string, data?: T): Promise<http.HttpResponse> => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    `${AppConfig.baseUrl}${url}`,
    {
      method: http.RequestMethod.POST,
      extraData: data,
      header: {
        'Content-Type': 'application/json'
      }
    });
  // return httpResponse.then((res: http.HttpResponse) => {
  //   let result: IResponse<any>;
  //   if (res.responseCode === 200) {
  //     // return res.
  //   } else {
  //     // response.message = '请求错误';
  //     // response.code = 400;
  //   }
  //   return result;
  // }).catch(() => {
  //   let result: IResponse<any>;
  //   return result;
  // })
}