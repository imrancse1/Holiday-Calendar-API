//
//  Holiday.swift
//  CalendarAPI
//
//  Created by Imran Hossain on 1/18/20.
//  Copyright © 2020 Imran Hossain. All rights reserved.
//

import Foundation

struct HolidayResponse:Decodable {
    var response:Holidays
}

struct Holidays:Decodable {
    var holidays:[HolidayDetail]
   
}

struct HolidayDetail:Decodable {
    var name: String
    
    var date:DeteInfo
}

struct DeteInfo:Decodable {
    var iso:String
}


