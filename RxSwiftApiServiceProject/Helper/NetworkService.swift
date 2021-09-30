//
//  NetworkService.swift
//  RxSwiftApiServiceProject
//
//  Created by zapbuild on 17/09/21.
//

import Foundation

enum Method: String {
    case post = "POST"
    case get = "GET"
}

enum Result<T, E> where E: Error  {
    case success(T)
    case failure(E)
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}


class NetworkService{
    func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(.success(obj))
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }.resume()
    }
    
    
    func apiCall<T: Decodable>(urlString: String, parameters: [String:Any], method:Method, completion: @escaping (Result<T, Error>) -> ()) {
       
        guard let request = createRequest(urlString: urlString, parameters: parameters, method: method) else {
            completion(.failure(Error.self as! Error))
            return
        }
        
        let configuration = URLSessionConfiguration.default;
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        session.dataTask(with: request) { (data, response, err) in
            DispatchQueue.main.async(execute: {
                if (data != nil && err == nil) {
                    do {
                        let obj = try JSONDecoder().decode(T.self, from: data!)
                        print(obj)
                        completion(.success(obj))
                    } catch  {
                        completion(.failure(error))
                    }
                }else{
                    completion(.failure(err!))
                }

            })
            
        }.resume()
    }
    
    private func createRequest(urlString: String, parameters:[String:Any], method: Method) -> URLRequest?{
        
        let urlStr = URL(string: urlString)
        
        var request: URLRequest?
        
        if let urlStr = urlStr {
            request = URLRequest(url: urlStr)
        }
        if method == .post{
            do {
                request?.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
             } catch let error {
                 print(error.localizedDescription)
             }
        }
        

         request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request?.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request?.timeoutInterval = 20.0
        request?.httpMethod = method.rawValue
        return request
    }
}
