//
//  EventMapViewController.swift
//  Assembly
//
//  Created by Dennis Hou on 13/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
//  Derived from https://www.raywenderlich.com/109888/google-maps-ios-sdk-tutorial
//  and Google's official SDK documentation https://developers.google.com/maps/documentation/ios-sdk

import UIKit
import GoogleMaps

class EventMapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate  {

    // MARK: - Properties
    var selectedEventDetails:[String:AnyObject]?
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationAddress: UILabel!
    
    @IBOutlet weak var openGMButton: UIButton!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
    @IBOutlet var superView: UIView!
    
    // For consistent zoom level
    let zoomLevel:Float = 17
    // User's Location
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
    // Venue Location
    var venueLat:CLLocationDegrees = 0
    var venueLong:CLLocationDegrees = 0
    
    
    
    
    // MARK: - Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLocationDetails()
        self.navigationItem.title = "Maps"
        
        startUpMaps()
        
        // Assign venue location
        venueLat = (selectedEventDetails!["venue"]?["lat"] as? Double)!
        venueLong = (selectedEventDetails!["venue"]?["lon"] as? Double)!
        
        initMapCamera()
        setUpMarker()
        
        mapView.delegate = self



        
        drawButtonBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: Styles
    func drawButtonBorder(){
        let topBorder = CALayer()
        topBorder.frame = CGRectMake(0, 0, openGMButton.frame.width, 0.5)
        topBorder.backgroundColor = UIColor(red:0.77,green:0.77,blue:0.77,alpha:1.00).CGColor
        openGMButton.layer.addSublayer(topBorder)
    }
    
    
    // MARK: GMap Button

    @IBAction func openGMButtonTapped(sender: UIButton) {
        print("OPEN GMAPS")
        
        
        let latString:String = String(venueLat)
        let longString:String = String(venueLong)
        
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "comgooglemaps://?center="+latString+","+longString+"&zoom=14&views=traffic")!)
        } else {
            print("Can't use comgooglemaps://");
            
            // Show popup alert if user has no Google Maps
            let alert = UIAlertController(title: "Oops!", message: "Looks like you don't have Google Maps in your device. \nInstalling Google Maps should fix this.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Location Labels
    func loadLocationDetails(){
        if selectedEventDetails != nil{
            if selectedEventDetails!["venue"]?["name"] != nil{
                locationName.text = (selectedEventDetails!["venue"]?["name"] as? String)!
                locationAddress.text = (selectedEventDetails!["venue"]?["address_1"] as? String)!
            }
            else{
                locationName.text = "Available to members only."
                locationAddress.text = ""
            }
        }
    }
    
    
    // MARK: - Start Map View
    func startUpMaps(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    
    // MARK: - Map Camera
    func initMapCamera(){
        let camera = GMSCameraPosition.cameraWithLatitude(venueLat, longitude: venueLong, zoom: zoomLevel)
        self.mapView.camera = camera
    }
    
    
    // MARK: - Marker
    func setUpMarker(){
        
        let currentLocation = CLLocationCoordinate2DMake(venueLat, venueLong)
        let marker = GMSMarker(position:currentLocation)
        marker.title = (selectedEventDetails!["venue"]?["name"] as? String)!
        marker.icon = UIImage(named: "Marker Filled")
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
        
    }
    
    
    // MARK: Location Manager
    // Executes function when user grants permission to use location data
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            // Invoke GPS update
            locationManager.startUpdatingLocation()
            // Shows user's location as that iconic blue dot :)
            mapView.myLocationEnabled = true
            // Shows location button that centers camera to user's location
            mapView.settings.myLocationButton = true
        }
    }
    
    
    // Updates user's current location on the map
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
        }
    }


    
    // MARK: - Rotation
    // Change Google Map's padding according to rotation 
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 40.0, right: 0.0)
            mapView.padding = mapInsets
            
        } else {
            let mapInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            mapView.padding = mapInsets
        }
    }
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
