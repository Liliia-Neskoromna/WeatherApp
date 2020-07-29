import Foundation
import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    static var reuseId: String = "HourlyWeatherCell"
    
    let icon = UIImageView()
    let dt = UILabel()
    let temp = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 1, alpha: 1)
        setupElements()
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    func setupElements() {
        temp.translatesAutoresizingMaskIntoConstraints = false
        dt.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with city: AppHourlyDailyItem) {
        temp.text = String(city.temp.day)
        temp.textColor = .systemBlue
        temp.font = UIFont(name: "avenir", size: 18)
        dt.text = String(city.dt)
        dt.textColor = .darkGray
        dt.font = UIFont(name: "avenir", size: 20)
        for element in city.weather {
            icon.image = UIImage(named: element.icon)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Setup Constraints
extension HourlyWeatherCell {
    func setupConstraints() {
        addSubview(temp)
        addSubview(dt)
        addSubview(icon)
        
        // oponentImageView constraints
        icon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // oponentLabel constraints
        dt.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        dt.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //dt.leadingAnchor.constraint(equalTo: trailingAnchor, constant: 6).isActive = true
        //dt.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 75).isActive = true

        // lastMessageLabel constraints
        temp.topAnchor.constraint(equalTo: dt.bottomAnchor, constant: 47).isActive = true
        //temp.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 30).isActive = true
        temp.trailingAnchor.constraint(equalTo: self.leadingAnchor, constant: 76).isActive = true
    }
}

