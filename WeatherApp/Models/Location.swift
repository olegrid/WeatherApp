//
//  Location.swift
//  WeatherApp
//
//  Created by Aleh on 09/11/2023.
//

import Foundation

struct Location: Codable {
    let name: String
    let state: String
    let country: String
    let lat: Double
    let lon: Double
    
    static func initWithDictioary(_ dict: [String: Any]) -> Location? {
        guard let name = dict["name"] as? String,
              let state = dict["state"] as? String,
              let country = dict["country"] as? String,
              let lat = dict["lat"] as? Double,
              let lon = dict["lon"] as? Double else
        {
            return nil
        }
        return Location(name: name, state: state, country: country, lat: lat, lon: lon)
    }
    
}


/*{"name":"Homyel","local_names":{"zh":"戈梅利","ru":"Гомель","el":"Γόμελ","feature_name":"Homieĺ","tr":"Gomel","tw":"戈梅利","uk":"Гомєль","be":"Гомель","sr":"Гомељ","ka":"გომელი","es":"Gómel","ascii":"Homieĺ","et":"Gomel","he":"הומל","ar":"غوميل","hu":"Homel","ko":"호몔","nl":"Homel","ja":"ホメリ","lv":"Homjeļa","pl":"Homel","vo":"Homyel","ur":"گومل","de":"Homel","lt":"Gomelis","fa":"گومل","eo":"Homel","sk":"Homeľ","en":"Homyel","ta":"கோமெல்","fr":"Homiel","no":"Homjel","bg":"Гомел","sg":"戈梅利","th":"กอเมล"},"lat":52.4238936,"lon":31.0131698,"country":"BY","state":"Homyel Region"}*/
