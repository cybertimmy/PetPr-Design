import UIKit
import MapKit
import CoreLocation

final class MapScreenViewController: UIViewController {
    
    private let mapScreenView: MapScreenView
    
    override func loadView() {
        super.loadView()
        self.view = mapScreenView
        setupMKMapViewDelegate()
        actionButtons()
        setupTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        self.mapScreenView = MapScreenView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitle() {
        navigationItem.title = "Map"
    }
    
    private func setupMKMapViewDelegate() {
        mapScreenView.mapView.delegate = self
    }
    
    private func actionButtons() {
        mapScreenView.addAdressButton.addTarget(self, action: #selector(addingAnAddress), for: .touchUpInside)
        mapScreenView.routeButton.addTarget(self, action: #selector(buildingARoute), for: .touchUpInside)
        mapScreenView.resetButton.addTarget(self, action: #selector(deletingAndUpdatingARoute), for: .touchUpInside)
    }
}

extension MapScreenViewController {
    @objc private func addingAnAddress() {
        addAddressAlert(title: "Add address", placeholder: "Enter address") { [self] text in
            setupPlaceMark(addressPlace: text)
        }
    }
    @objc private func buildingARoute() {
        for index in 0...MapAnnotationArray.annotationArray.count - 2 {
            createDirectionRequest(startCoordinate: MapAnnotationArray.annotationArray[index].coordinate, destinationCoordinate: MapAnnotationArray.annotationArray[index + 1].coordinate)
        }
        mapScreenView.mapView.showAnnotations(MapAnnotationArray.annotationArray, animated: true)
    }
    @objc private func deletingAndUpdatingARoute() {
        mapScreenView.mapView.removeOverlays(mapScreenView.mapView.overlays)
        mapScreenView.mapView.removeAnnotations(mapScreenView.mapView.annotations)
        MapAnnotationArray.annotationArray = [MKPointAnnotation]()
        mapScreenView.routeButton.isHidden = true
        mapScreenView.resetButton.isHidden = true
    }
}

extension MapScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
}

extension MapScreenViewController {
    private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D ) {
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        let direction = MKDirections(request: request)
        direction.calculate { responce, error in
            if error != nil {
                fatalError()
            }
            guard let responce = responce else {
                self.notificationAlert(title: "Error", message: "Route Unavailable")
                return
            }
            var minRoute = responce.routes[0]
            for route in responce.routes {
                minRoute = (route.distance < minRoute.distance) ? route : minRoute
            }
            self.mapScreenView.mapView.addOverlay(minRoute.polyline)
        }
    }
    
    private func setupPlaceMark(addressPlace: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressPlace) { [self] placeMarks, error in
            if let error = error {
                print(error.localizedDescription)
                notificationAlert(title: "Error", message: "Server is not available")
                return
            }
            guard let placeMarks = placeMarks else {return}
            let placemark = placeMarks.first
            let annotation = MKPointAnnotation()
            annotation.title = "\(addressPlace)"
            guard let placeMarkLocation = placemark?.location else {return}
            annotation.coordinate = placeMarkLocation.coordinate
            MapAnnotationArray.annotationArray.append(annotation)
            if MapAnnotationArray.annotationArray.count > 1 {
                mapScreenView.resetButton.isHidden = false
                mapScreenView.routeButton.isHidden = false
            }
            mapScreenView.mapView.showAnnotations(MapAnnotationArray.annotationArray, animated: true)
        }
    }
}
