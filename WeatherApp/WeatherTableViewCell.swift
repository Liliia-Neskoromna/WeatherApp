import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var imageWeatherIcon: UIImageView!
    @IBOutlet weak var testImage: UILabel!
    
    @IBOutlet weak var bigButton: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.bigButtonTapped(sender:)))
        self.bigButton?.addGestureRecognizer(tap)
    }
    
    @objc func bigButtonTapped(sender: UITapGestureRecognizer) {
        print("bigButtonTapped")
    }
}
