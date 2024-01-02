import http from '@ohos.net.http';

const baseUrl = "http://101.201.59.201:9090";

export const userLogin = (data: {
  username: string,
  password: string
}) => {

  const httpRequest = http.createHttp();

  return httpRequest.request(
    baseUrl + '/user/login',
    {
      method: http.RequestMethod.POST,
      extraData: data,
      header: {
        'Content-Type': 'application/json'
      }
    });
}

