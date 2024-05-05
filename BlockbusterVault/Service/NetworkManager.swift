//
//  NetworkManager.swift
//  BlockbusterVault
//
//  Created by Dev on 14/03/2024.
//

import Foundation

enum ResultType: Error {
    case Success
    case NoData
    case Fetching
}

struct NetworkManager {
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    let requestBuilder: RequestBuilderDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler(),
         requestBuilder: RequestBuilderDelegate = RequestBuilder()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
        self.requestBuilder = requestBuilder
    }
    
    func fetchRequest<T: Codable>(type: T.Type, url: String) async throws -> T {
        let request = requestBuilder.createRequest(with: url)
        do {
            let apiResponse = try await aPIHandler.fetchData(with: request)
            return try await responseHandler.fetchModel(type: type, data: apiResponse)
        } catch {
            throw error
        }
    }
}

// MARK: Request Builder

protocol RequestBuilderDelegate {
    func createRequest(with url: String) -> NSMutableURLRequest
}

struct RequestBuilder: RequestBuilderDelegate {
    
    let headers = [
        "accept": "application/json",
        "Authorization": Bundle.main.object(forInfoDictionaryKey: "AUTH_TOKEN") as! String
    ]
    
    func createRequest(with url: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
}

// MARK: API Handler

protocol APIHandlerDelegate {
    func fetchData(with request: NSMutableURLRequest) async throws -> Data
}

struct APIHandler: APIHandlerDelegate {
    func fetchData(with request: NSMutableURLRequest) async throws -> Data {
        do {
            let (data,response) = try await URLSession.shared.data(for: request as URLRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ResultType.NoData
            }
            return data
        } catch {
            throw error
        }
    }
}

// MARK: Response Handler

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) async throws -> T
}

struct ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data) async throws -> T {
        do {
            return try JSONDecoder().decode(type.self, from: data)
        } catch let error as NSError {
            print(error)
            throw error
        }
    }
}
