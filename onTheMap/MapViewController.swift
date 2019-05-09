//
//  MapViewController.swift
//  onTheMap
//
//  Created by Waiel Eid on 9/5/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MKMapViewDelegate{


    @IBOutlet weak var mapView: MKMapView!
    var studiesnts: [StudentInformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // load the map data
        getMapData();
    }
    

    
    func getMapData(){
        
        
    }
    


}
