//
//  NewsData.swift
//  myAppUIKit
//
//  Created by Kaikai Liu on 2/6/21.
//

//import Foundation

import UIKit
import MapKit
import os.log

class NewsData {
    //MARK: Properties
    var identifier: Int
    var title: String
    var name: String?
    var story: String?
    var photo: UIImage? //String? //UIImage?
    var rating: Int
    var weblink: URL?
    var coordinate: CLLocationCoordinate2D?
    
    init?(identifier: Int, title: String, name: String?, story: String?, photo: UIImage?, rating: Int, weblink: URL?, coordinate: CLLocationCoordinate2D?) {
        // Initialization should fail if there is no name or if the rating is negative.
//        if name.isEmpty || rating < 0  {
//            return nil
//        }
        guard !title.isEmpty else {
            return nil
        }
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.identifier = identifier
        self.title = title
        self.name = name
        self.story = story
        self.photo = photo
        self.rating = rating
        self.weblink = weblink
        self.coordinate = coordinate
    }
    
    // MARK: - Support for loading data
    static var defaultData: [NewsData] = {
        return loadDataFromPlistNamed("localdata")
        //return loadDataFromCode()
    }()
    
    static func loadDataFromCode() -> [NewsData] {
        guard let news1 = NewsData.init(identifier: 1, title: "testing the news title", name: "me", story: "test the story", photo: UIImage(named: "Image1"), rating: 3, weblink: URL(string: "www.google.com"), coordinate: nil) else {
            fatalError("Unable to instantiate data 1")
        }
        guard let news2 = NewsData.init(identifier: 1, title: "testing the news title testing the news title testing the news title testing the news title", name: "me", story: "test the story2", photo: UIImage(named: "Image2"), rating: 1, weblink: URL(string: "www.google.com"), coordinate: nil) else {
            fatalError("Unable to instantiate data 2")
        }
        guard let news3 = NewsData.init(identifier: 1, title: "testing the news title testing the news title testing the news title testing the news title testing the news title", name: "me", story: "test the story", photo: UIImage(named: "Image3"), rating: 5, weblink: URL(string: "www.google.com"), coordinate: nil) else {
            fatalError("Unable to instantiate data 3")
        }
        var mydata = [NewsData]()
        mydata += [news1, news2, news3]
        return mydata
    }
    
    static func loadDataFromPlistNamed(_ plistName: String) -> [NewsData] {
      guard
        let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
        let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
        else {
          fatalError("An error occurred while reading \(plistName).plist")
        }
        
        var mynewsData: [NewsData] = []
        
        for dict in dictArray {
            guard
              let identifier    = dict["identifier"]    as? Int,
              let name          = dict["name"]          as? String,
              let thumbnailName = dict["thumbnailName"] as? String,
              let title         = dict["title"]         as? String,
              let story         = dict["story"]         as? String,
              let userRating    = dict["userRating"]    as? Int,
              let webLink       = dict["webLink"]       as? String,
              let latitude      = dict["latitude"]      as? Double,
              let longitude     = dict["longitude"]     as? Double
              else {
                fatalError("Error parsing dict \(dict)")
            }
            let webURL = URL(string: webLink)!
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            guard let onenewsdata = NewsData.init(identifier: identifier, title: title, name: name, story: story, photo: UIImage(named: thumbnailName), rating: userRating, weblink: webURL, coordinate: coordinate) else { fatalError("Error creating news") }
            mynewsData.append(onenewsdata)
        }
        
        return mynewsData
    }

}
