//
//  MapViewController.swift
//  myAppUIKit
//
//  Created by Kaikai Liu on 2/8/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationToShow: Coordinate! //CLLocationCoordinate2D!

    @IBAction func doneBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let currentlocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: locationToShow.latitude, longitude: locationToShow.longitude)
        mapView.setCenter(currentlocation, animated: true)

        let zoomRegion = MKCoordinateRegion.init(center: currentlocation, latitudinalMeters: 15000, longitudinalMeters: 15000)
        mapView.setRegion(zoomRegion, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = currentlocation
        mapView.addAnnotation(annotation)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
