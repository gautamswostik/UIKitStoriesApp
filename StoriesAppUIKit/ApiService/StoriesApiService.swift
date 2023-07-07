//
//  StoriesApiService.swift
//  StoriesAppUIKit
//
//  Created by swostik gautam on 07/07/2023.
//

import Foundation
import Alamofire


class StoriesApiService {
    func fetchStories(completion: @escaping(Result<[StoriesModel] , Error>) -> Void) {
        AF.request("https://shortstories-api.onrender.com/stories" , method: .get)
            .validate(statusCode: 200..<500)
            .response { response in
                switch response.result {
                case .success(let data):
                    if((200...299).contains(response.response!.statusCode)){
                        guard let stories = data else {return}
                        let decoder = JSONDecoder()
                        do{
                            let stories = try decoder.decode([StoriesModel].self, from: stories)
                            completion(.success(stories))
                        } catch let error{
                            completion(.failure(ApiError.parsing(error as? DecodingError)))
                        }
                    }else {
                        completion(.failure(ApiError.badResponse(statusCode: response.response!.statusCode)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
    }
}

enum ApiError: Error {
    case badURL
    case badResponse(statusCode:Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "Please check is provided url is right or wrong"
        case .parsing(let error):
            return "Encountered error while decoding \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "Error while processing data \(statusCode)"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        case .unknown:
            return "Something went wrong"
        }
    }
}
