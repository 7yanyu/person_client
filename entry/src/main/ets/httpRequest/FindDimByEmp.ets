import http from '@ohos.net.http';
import { DimUser } from '../entiy/dimission';
import { Baseurl } from '../module/BaseUrl';

export function findDimByEmp(id: number): Promise<DimUser> {
  return new Promise<DimUser>((resolve, reject) => {
    let httpRequest = http.createHttp();
    console.log('id' + id.toString());
    const url = `${Baseurl()}dimission/findbyemp?emp_ID=${encodeURIComponent(id)}`;

    httpRequest.request(
      url,
      {
        method: http.RequestMethod.GET
      }
    )
      .then(response => {
        if (response.result) {
          try {
            const result = JSON.parse(response.result.toString());
            console.log('1:', JSON.stringify(result));
            resolve(result);
          } catch (error) {
            console.error('Error parsing JSON:', error);
            reject(new Error('Error parsing JSON response'));
          }
        } else {
          reject(new Error('No result in response'));
        }
      })
      .catch(error => {
        console.error('HTTP request failed:', error);
        reject(new Error('HTTP request failed'));
      });
  });
}