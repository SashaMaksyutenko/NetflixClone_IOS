//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Sasha Maksyutenko on 23.07.2023.
//

import Foundation
enum Sections:Int{
    case TrendingMovies=0
    case TrendingTv=1
    case Popular=2
    case Upcoming=3
    case TopRated=4
    
}
struct Constants{
    static let API_KEY="ff964588187f7c592b4b2989940575c6"
    static let baseUrl="https://api.themoviedb.org"
}
enum APIError:Error{
   case failedToGetData
}
class APICaller{
    static let shared = APICaller()
    func getTrendingMovies(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url=URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else{return}
        let task=URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data=data, error==nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getTrendingTvs(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url=URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else{return}
        let task=URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data=data, error==nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getUpcomingMovies(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url=URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task=URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data=data,error==nil else {return}
            do{
                let results=try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getPopular(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                  guard let data = data, error == nil else {
                      return
                  }
                  
                  do {
                      let results = try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                      completion(.success(results.results))
                      //print(results)
                  } catch {
                      completion(.failure(APIError.failedToGetData))
                  }
              }
              
              task.resume()
    }
    func getTopRated(completion:@escaping (Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return }
                let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    
                    do {
                        let results=try JSONDecoder().decode(trendingTitleResponse.self, from: data)
                        completion(.success(results.results))
                        //print(results)

                    } catch {
                        completion(.failure(APIError.failedToGetData))
                    }
                }
                task.resume()
    }
}
