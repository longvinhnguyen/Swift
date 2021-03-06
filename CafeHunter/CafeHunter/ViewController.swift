/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import MapKit

class ViewController: UIViewController {
  
  private var locationManager: CLLocationManager!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var loginView: FBLoginView!
    
    var lastLocation: CLLocation!
    let searchDistance: CLLocationDistance = 1000
    private var cafes = [Cafe]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.locationManager = CLLocationManager()
    self.locationManager.delegate = self
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh:")
    
    
    
    FBSettings.setDefaultAppID("1496822950570177");
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.checkLocationAuthorizationStatus()
  }
  
  private func checkLocationAuthorizationStatus() {
    if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
        self.mapView.showsUserLocation = true
    } else {
      self.locationManager.requestWhenInUseAuthorization()
    }
  }
    
    private func centerMapOnLocation(location: CLLocation!) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, self.searchDistance, self.searchDistance)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }

    
    private func fetchCafesAroundLocation(location: CLLocation) {
        if !FBSession.activeSession().isOpen {
            let alert = UIAlertController(title: "Error", message: "Login First!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let urlString = "https://graph.facebook.com/v2.0/search/?access_token=\(FBSession.activeSession().accessTokenData.accessToken)&type=place&q=cafe&center=\(location.coordinate.latitude),\(location.coordinate.longitude)&distance=\(Int(searchDistance))"
        
        let url = NSURL(string:urlString)
        println("Requesting from FB with URL: \(url)")
        
        let request = NSURLRequest(URL:url!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            var error: NSError?
            let jsonObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &error)
            if let jsonObject = jsonObject as? [String:AnyObject] {
                if error == nil {
                    println("Data returned from FB:\n\(jsonObject)")
                    
                    if let data = JSONValue.fromObject(jsonObject)?["data"]?.array {
                        var cafes = [Cafe]()
                        for cafeJSON in data {
                            if let cafeJSON = cafeJSON.object {
                                //
                                if let cafe = Cafe.fromJSON(cafeJSON) {
                                    cafes.append(cafe)
                                }
                            }
                        }
                        
                        
                        self.mapView.removeAnnotations(self.cafes)
                        self.cafes = cafes
                        self.mapView.addAnnotations(self.cafes)
                    }
                }
            }
        }
    }
    
    func refresh(sender:UIBarButtonItem) {
        if let location = self.lastLocation {
            self.centerMapOnLocation(location)
            self.fetchCafesAroundLocation(location)
        } else {
            let alert = UIAlertController(title: "Error", message: "No location yet!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self .presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    self.checkLocationAuthorizationStatus()
  }
  
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, didFailToLocateUserWithError error: NSError!) {
        println(error)
        let alert = UIAlertController(title: "Error", message: "Failed to obtain location!", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        let newLocation = userLocation.location
        
        let distance = self.lastLocation?.distanceFromLocation(self.lastLocation)
        
        if (distance == nil || distance > self.searchDistance) {
            self.lastLocation = newLocation
            self.centerMapOnLocation(newLocation)
            self.fetchCafesAroundLocation(newLocation)
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let cafe = annotation as? Cafe {
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as MKPinAnnotationView!
            if view == nil {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
                view.canShowCallout = true
                view.animatesDrop = false
                view.calloutOffset = CGPointMake(-5, 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
            } else {
                view.annotation = annotation
            }
            
            view.pinColor = MKPinAnnotationColor.Red
            return view
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("CafeView") as? CafeViewController {
            if let cafe = view.annotation as? Cafe {
                viewController.cafe = cafe
                viewController.delegate = self
            }
            self.presentViewController(viewController, animated: true, completion: nil)
        }
    }

}

extension ViewController: CafeViewControllerDelegate {
    func cafeViewControllerDidFinish(viewController:CafeViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}






