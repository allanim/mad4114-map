//
//  ViewController.swift
//  mad4114-map
//
//  Created by Allan Im on 2018-12-07.
//  Copyright © 2018 Allan Im. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var txtCountry1st: UITextField!
    @IBOutlet weak var txtCountry2nd: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var mapManager = CLLocationManager()
    var annotations : [MKPointAnnotation] = []
    var countryPicker1 = UIPickerView()
    var countryPicker2 = UIPickerView()
    var selectedCountry1: Country?
    var selectedCountry2: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField Delegate
        txtCountry1st.delegate = self
        txtCountry2nd.delegate = self
        
        // Location Manager
        mapManager.delegate = self                            // ViewController is the "owner" of the map.
        mapManager.desiredAccuracy = kCLLocationAccuracyBest  // Define the best location possible to be used in app.
        mapManager.requestWhenInUseAuthorization()            // The feature will not run in background
        mapManager.startUpdatingLocation()                    // Continuously geo-position update
        
        // Map View
        mapView.delegate = self
        
        // point countries
        reloadCountries()
        
        // init picker
        pickUpCountry1()
        pickUpCountry2()
        
    }
    
    func reloadCountries() {
        let source = CLLocation(latitude: 33.5784793, longitude: 126.2921634)
        
        for country in Store.countries {
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(country.latitude, country.longitude)
            pointAnnotation.title = country.name
            mapView.addAnnotation(pointAnnotation)
            annotations.append(pointAnnotation)
        }
    }

    @IBAction func btnGo(_ sender: Any) {
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
            //color
            annotationView?.pinTintColor = UIColor.green
            if annotation.title == selectedCountry1?.name {
                annotationView?.pinTintColor = UIColor.red
            } else if annotation.title == selectedCountry2?.name {
                annotationView?.pinTintColor = UIColor.blue
            }
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    // Drawing a red circle to pin on map
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let circleRenderer = MKCircleRenderer(overlay: overlay)
//        circleRenderer.strokeColor = UIColor.red
//        circleRenderer.lineWidth = 1.0
//        return circleRenderer
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        // Here we define the map's zoom. The value 0.01 is a pattern
        let zoom: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)

        // Store latitude and longitude received from smartphone
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(33.5784793, 126.2921634)
        
        // Based on myLocation and zoom define the region to be shown on the screen
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: zoom)

        // Setting the map itself based previous set-up
        mapView.setRegion(region, animated: true)

        // Showing the blue dot in a map
        //mapView.showsUserLocation = true

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        reload?(true) // Use callback to return data
    }
    
    func pickUpCountry1(){
        
        // input view
        self.countryPicker1 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 230))
        self.countryPicker1.backgroundColor = .white
        self.countryPicker1.delegate = self
        self.txtCountry1st.inputView = self.countryPicker1
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.picker1DoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.picker1CancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.txtCountry1st.inputAccessoryView = toolBar
        
    }
    
    @objc private func picker1DoneClick() {
        self.selectedCountry1 = Store.countries[countryPicker1.selectedRow(inComponent: 0)]
        self.txtCountry1st.text = self.selectedCountry1?.name
        self.txtCountry1st.resignFirstResponder()
        reloadCountries()
    }
    
    @objc func picker1CancelClick() {
        self.txtCountry1st.resignFirstResponder()
    }
    
    func pickUpCountry2(){
        
        // input view
        self.countryPicker2 = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 230))
        self.countryPicker2.backgroundColor = .white
        self.countryPicker2.delegate = self
        self.txtCountry2nd.inputView = self.countryPicker2
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.picker2DoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.picker2CancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.txtCountry2nd.inputAccessoryView = toolBar
        
    }
    
    @objc private func picker2DoneClick(_ textField : UITextField) {
        self.selectedCountry2 = Store.countries[countryPicker2.selectedRow(inComponent: 0)]
        self.txtCountry2nd.text = self.selectedCountry2?.name
        self.txtCountry2nd.resignFirstResponder()
        reloadCountries()
    }
    
    @objc func picker2CancelClick() {
        txtCountry2nd.resignFirstResponder()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Store.countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Store.countries[row].name
    }
}
