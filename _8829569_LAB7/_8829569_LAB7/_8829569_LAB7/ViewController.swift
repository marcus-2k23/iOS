//
//  ViewController.swift
//  8829569_LAB7
//
//  Created by user228630 on 7/18/23.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var currentSpeedLabel: UILabel!
    @IBOutlet weak var mapViewOutlet: MKMapView!
    @IBOutlet weak var redBarLabel: UILabel!
    @IBOutlet weak var greenBarLabel: UILabel!
    
    @IBOutlet weak var maxAccelerationLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var averageSpeedLabel: UILabel!
    @IBOutlet weak var maxSpeedLabel: UILabel!
    
    var tripRunning = false
    var startLocation: CLLocation?
    var lastLocation: CLLocation?
    var tripStartTime: Date?
    var currentSpeedData: CLLocationSpeed = 0.0
    var maxSpeedData: CLLocationSpeed = 0.0
    var speedAllowed: CLLocationSpeed = 31.94
    var maxAcceleration: Double = 0.0
    var lastAcceleration: Double = 0.0
    var distanceTravelled: CLLocationDistance = 0.0
    
    
    @IBAction func startTripButton(_ sender: Any) {
        manager.startUpdatingLocation()
        tripRunning = true
        tripStartTime = Date()
        startLocation = manager.location
        greenBarLabel.backgroundColor = .green
        maxSpeedData = 0.0
        maxSpeedLabel.text = "0.0"
        distanceTravelled = 0.0
        maxAcceleration = 0.0
        currentSpeedLabel.text = "0.0"
        averageSpeedLabel.text = "0.0"
        distanceLabel.text = "0.0"
        maxAccelerationLabel.text = "0.0"
        
    }
    
    
    @IBAction func stopTripButton(_ sender: Any) {
        tripRunning = false
        manager.stopUpdatingLocation()
        greenBarLabel.backgroundColor = .gray
        
    }
    
    
    let manager = CLLocationManager()
    var sum = 0.0
    var speedArray : [Double] = []
    
    
    var acceleration = 0.0
    
    
    var previousSpeed = 0.0
    var previousTime = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        mapViewOutlet.showsUserLocation = true
        mapViewOutlet.userTrackingMode = .follow
        
        // Do any additional setup after loading the view.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
    
        
        // Calculate speed
        currentSpeedData = location.speed
        currentSpeedLabel.text = String(format: "%.1f km/h", currentSpeedData * 3.6)
        sum += currentSpeedData
        speedArray.append(currentSpeedData)
        
        // Calculate max speed
        maxSpeedData = max(maxSpeedData, location.speed)
        maxSpeedLabel.text = String(format: "%.1f km/h", maxSpeedData * 3.6)
        
        let averageSpeedValue = (sum/Double(speedArray.count))
        averageSpeedLabel.text = String(format: "%.1f km/h", averageSpeedValue * 3.6 )
        
        // Check if speed exceeds the limit
        
        redBarLabel.backgroundColor = (currentSpeedData > speedAllowed) ? .red : .gray
        
        // Update the map view
        if tripRunning {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
            mapViewOutlet.setRegion(region, animated: true)
        }
        
        // Calculate distance
        if let startLocation = startLocation {
            distanceTravelled += location.distance(from: startLocation)
        }
        distanceLabel.text = String(format: "%.2f km", distanceTravelled / 1000)
        if(lastLocation != nil){
        let deltaT = location.timestamp.timeIntervalSince(tripStartTime!) - (lastLocation?.timestamp.timeIntervalSince(tripStartTime!))!
        let deltaV = currentSpeedData - previousSpeed
        acceleration = deltaV/deltaT
        if(maxAcceleration < acceleration){
            maxAcceleration = acceleration
        }
        }
        print(acceleration)
        maxAccelerationLabel.text = String(format: "%.1f m/s²", maxAcceleration)
        // Calculate acceleration
        if let previousLocation = locations.dropLast().last {
            let timeInterval = location.timestamp.timeIntervalSince(previousLocation.timestamp)
            let acceleration = abs((location.speed - previousLocation.speed) / timeInterval)
            maxAcceleration = max(maxAcceleration, acceleration)
            maxAccelerationLabel.text = String(format: "%.2f m/s²", maxAcceleration)
        }
        
        

        
        lastLocation = location
        previousSpeed = currentSpeedData
        
        
    }

    func render(_ location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let pin = MKPointAnnotation()
        
        pin.coordinate = coordinate
        mapViewOutlet.addAnnotation(pin)
        mapViewOutlet.setRegion(region, animated: true)
        
    }
    
    

    

}

