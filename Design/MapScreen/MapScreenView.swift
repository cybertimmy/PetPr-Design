import UIKit
import MapKit

final class MapScreenView: UIView {
    
    public let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    private var buttonsStackView: UIStackView!
    
    public let addAdressButton: UIButton = {
            let button = UIButton()
            button.setTitle("Find address", for: .normal)
            button.titleLabel?.font = UIFont.lightFont(ofSize: 15)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = .none
            return button
    }()
    
    public let routeButton: UIButton = {
            let button = UIButton()
            button.setTitle("Route", for: .normal)
            button.titleLabel?.font = UIFont.lightFont(ofSize: 15)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = .none
            button.isHidden = true
            return button
    }()
    
    public let resetButton: UIButton = {
            let button = UIButton()
            button.setTitle("Reset", for: .normal)
            button.titleLabel?.font = UIFont.lightFont(ofSize: 15)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = .none
            button.isHidden = true
            return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        setupApperiance()
        setupBgColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBgColor() {
        self.backgroundColor = UIColor.darkBGColor()
    }
    
    private func setupStackView() {
        buttonsStackView = UIStackView(arrangedSubviews: [addAdressButton,
                                                             routeButton,
                                                             resetButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 15
        buttonsStackView.axis = .horizontal
    }
    
    private func setupApperiance() {
        self.addSubviews(mapView,buttonsStackView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            buttonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            buttonsStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
}
