//
//  APIService.swift
//  EmojiCommit
//
//  Created by Kang, Su Jin (강수진) on 2021/04/06.
//

import Foundation
import Combine

final class APIService: Requestable {
    var requestTimeOut: Float = 30
    
    func request(_ request: NetworkRequest) -> AnyPublisher<Data, APIServiceError> {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(request.requestTimeOut ?? requestTimeOut)
        
        guard let encodedUrl = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
            return AnyPublisher(Fail<Data, APIServiceError>(error: .internetError))
        }
        
        let result = URLSession.shared
            .dataTaskPublisher(for: request.buildURLRequest(with: url))
            .tryMap { element -> Data in
                if let httpResponse = element.response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    switch HttpStatusCode(rawValue: statusCode) {
                    case .success:
                        break
                    case .notFoundError:
                        throw APIServiceError.clientError
                    case .internalServerError:
                        throw APIServiceError.serverError
                    default:
                        break
                    }
                }
                return element.data
            }
            .mapError({ error -> APIServiceError in
                switch error {
                case let error as APIServiceError:
                    return error
                case let error as NSError:
                    if URLError.Code(rawValue: error.code) == .notConnectedToInternet {
                        return APIServiceError.internetError
                    } else {
                        return APIServiceError.unknowError(error.localizedDescription)
                    }
                }
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        return result
    }
    
    func request<T>(_ request: NetworkRequest) -> AnyPublisher<T, APIServiceError> where T : Decodable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(request.requestTimeOut ?? requestTimeOut)
        
        guard let encodedUrl = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrl) else {
            return AnyPublisher(Fail<T, APIServiceError>(error: .internetError))
        }
        
        let result = URLSession.shared
            .dataTaskPublisher(for: request.buildURLRequest(with: url))
            .tryMap { element -> Data in
                if let httpResponse = element.response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    switch HttpStatusCode(rawValue: statusCode) {
                    case .success:
                        break
                    case .notFoundError:
                        throw APIServiceError.clientError
                    case .internalServerError:
                        throw APIServiceError.serverError
                    default:
                        break
                    }
                }
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error -> APIServiceError in
                switch error {
                case let error as APIServiceError:
                    return error
                case let error as NSError:
                    if URLError.Code(rawValue: error.code) == .notConnectedToInternet {
                        return APIServiceError.internetError
                    } else {
                        return APIServiceError.unknowError(error.localizedDescription)
                    }
                }
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        return result
    }
}
