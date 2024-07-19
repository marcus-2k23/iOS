
import UIKit
import CoreLocation
import MapKit
import Foundation

// MARK: - Welcome
struct Everything: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

class ViewController: UIViewController , CLLocationManagerDelegate, MKMapViewDelegate{

    
    @IBOutlet weak var weatherImageOutlet: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherDescriptionOutlet: UILabel!
    @IBOutlet weak var weatherTempretureOutlet: UILabel!
    @IBOutlet weak var weatherHumidityOutlet: UILabel!
    @IBOutlet weak var windSpeedOutlet: UILabel!
    
    
    let manager  = CLLocationManager()
    let API_KEY = "c71f30bacee3a544b1259c975a6a1e54"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        self.getWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
    }
    func getWeatherData( latitude : CLLocationDegrees,  longitude : CLLocationDegrees) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(API_KEY)";
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          let jsonDecoder = JSONDecoder()
            do{
                let weatherData = try
                    jsonDecoder.decode(Everything.self, from: data)
                print(weatherData)
                
                DispatchQueue.main.async {
                    self.cityName.text = "\(weatherData.name)"
                    self.weatherDescriptionOutlet.text = "\(weatherData.weather[0].description)"
                    self.weatherTempretureOutlet.text = "\(String(format: "%.1f", weatherData.main.temp - 273.15))°"
                    self.weatherHumidityOutlet.text = "Humidity : \(weatherData.main.humidity)%"
                    self.windSpeedOutlet.text = "Wind : \(String(format: "%.1f", weatherData.wind.speed * 3.6)) km/h"
                    let iconURLString = "https://openweathermap.org/img/wn/\(weatherData.weather[0].icon).png"
                    self.setImage(from: iconURLString)
                }
                
            }catch{
                print("Can't Decode")
            }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()

        
    }
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        DispatchQueue.main.async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.weatherImageOutlet.image = image
            }
        }
    }
}
