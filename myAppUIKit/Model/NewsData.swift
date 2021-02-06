//
//  NewsData.swift
//  myAppUIKit
//
//  Created by Kaikai Liu on 2/6/21.
//

//import Foundation

import UIKit
import MapKit

class NewsData {
    //MARK: Properties
    var identifier: Int
    var title: String
    var name: String?
    var story: String?
    var photo: String? //UIImage?
    var rating: Int
    var weblink: URL?
    var coordinate: CLLocationCoordinate2D?
    
    init?(identifier: Int, title: String, name: String?, story: String?, photo: String?, rating: Int, weblink: URL?, coordinate: CLLocationCoordinate2D?) {
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
}
