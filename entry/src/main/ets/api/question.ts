import http from '@ohos.net.http';
import { AppConfig } from '../config'

export const getQuestionList = (current: number) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/question/findAllQues/${current}`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}