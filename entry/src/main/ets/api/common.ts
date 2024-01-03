import http from '@ohos.net.http';
import { AppConfig } from '../config';

export const getIP = () => {
  const httpRequest = http.createHttp();
  return httpRequest.request('http://checkip.amazonaws.com/');
}

export const getLocation = (ip: string) => {
  const httpRequest = http.createHttp();
  return httpRequest.request('https://openlocation-drcn.platform.dbankcloud.com/networklocation/v1/ipLocation', {
    method: http.RequestMethod.POST,
    extraData: { ip: ip },
    header: {
      'Authorization': `Bearer ${AppConfig.hmsKey}`,
      'Content-Type': 'application/json',
      'x-forwarded-for': `${ip}`
    }
  })
}