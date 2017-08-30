import Foundation

class DataModel {
    
    var speed: Double?
    var lastSpeed: Double?
    var latitude: Double?
    var longitude: Double?
    var currentTimeInterval: Double?
    var nextTimeInterval: Double?
    
    init(latitude: Double, longitude: Double, speed: Double, lastSpeed: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.speed = speed
        self.lastSpeed = lastSpeed
    }
    
    init(latitude: Double, longitude: Double, speed: Double, lastSpeed: Double, currentTimeInterval: Double, nextTimeInterval: Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.speed = speed
        self.lastSpeed = lastSpeed
        self.currentTimeInterval = currentTimeInterval
        self.nextTimeInterval = nextTimeInterval
    }
    
}
