@objc(RNAdServices)
class RNAdServices: NSObject {
    var retries = 0

    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }

    @objc(getAttributionToken:withRejecter:)
    func getAttributionToken(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
#if targetEnvironment(simulator)
        reject("", "Cannot access attribution token from simulator", nil)
        return;
#else
        if #available(iOS 14.3, *) {
            do {
                let token = try AAAttribution.attributionToken()
                resolve(token)
            } catch (let error){
                reject("", "AdServices error", error)
            }
        } else {
            reject("", "AdServices is only available after iOS 14.3", nil)
        }
#endif
    }

    @objc(getAttributionData:withResolver:withRejecter:)
    func getAttributionData(token: String, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) -> Void {
        var request = URLRequest.init(url: URL(string: "https://api-adservices.apple.com/api/v1/")!)
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = token.data(using: String.Encoding.utf8)

        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {                                              // check for fundamental networking error
                      reject("", "Network error", error)
                      return
                  }
            guard (200 ... 299) ~= response.statusCode else {
                if ((response.statusCode == 404 || response.statusCode == 500) && self.retries < 5) {
                    self.retries = self.retries + 1
                    self.getAttributionData(token: token, resolve: resolve, reject: reject)
                    return;
                }
                self.retries = 0
                reject("", "Network error: wrong status code \(response.statusCode)", nil)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                resolve(json)
            } catch (let error) {
                reject("", "JSONSerialization error", error)
            }
        }
        session.resume()
    }
}
