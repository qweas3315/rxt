import http from '@ohos.net.http';
import { AppConfig } from '../config'

export const getKnowledgePageApi = (current: number) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/knowledge/${current}`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json'
      }
    });
}