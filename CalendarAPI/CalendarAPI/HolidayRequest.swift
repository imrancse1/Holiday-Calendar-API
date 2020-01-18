//
//  HolidayRequest.swift
//  CalendarAPI
//
//  Created by Imran Hossain on 1/18/20.
//  Copyright © 2020 Imran Hossain. All rights reserved.
//

import Foundation

enum HolidayError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    let resourceURL:URL
    let API_KEY = "96eeb99e9787b794b46cf0157811ecc28370d593"
    
    init(countryCode:String) {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        //print(currentYear)
        
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
        
    }
    
    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
            
            
        }
        dataTask.resume()
    }
    
}
