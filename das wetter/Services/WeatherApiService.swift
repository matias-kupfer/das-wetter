//
//  WeatherApi.swift
//  das wetter
//
//  Created by Matias Kupfer on 20.02.22.
//

import Foundation

struct Constants {
    static let API_KEY = "4080a5c5f23b76a4edd75dad96b31c9d"
    static let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
}

class WeatherApiService {
    static let shared = WeatherApiService()
    
    func getWeatherByCity(with query: String, completion: @escaping (Result<OpenWeatherApiResponse, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseUrl)?q=\(query)&appid=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(OpenWeatherApiResponse.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
        task.resume()
    }
}
