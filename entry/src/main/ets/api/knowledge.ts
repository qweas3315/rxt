import http from '@ohos.net.http';
import { AppConfig } from '../config'
import { IKnowledge } from '../model/knowledge';

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

export const getExpertKnowledgeApi = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/knowledge/selectByUsername`),
    {
      method: http.RequestMethod.GET,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      }
    });
}

export const deleteKnowledgeApi = (id: string) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/knowledge/${id}`),
    {
      method: http.RequestMethod.DELETE,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: {
        knowledgeId: id
      }
    });
}

export const updateKnowledgeApi = (data: IKnowledge) => {
  const httpRequest = http.createHttp();
  return httpRequest.request(
    encodeURI(`${AppConfig.baseUrl}/knowledge/${data.knowledgeId}`),
    {
      method: http.RequestMethod.PUT,
      header: {
        'Content-Type': 'application/json',
        'Authorization': globalThis.token
      },
      extraData: data
    });
}