import Foundation
import UIKit

class DataViewModel {
    var locDataModel: DataModel!
    
    init() {
        
    }
    
    init(latitude: Double, longitude: Double, speed: Double, lastSpeed: Double) {
        locDataModel = DataModel(latitude:latitude, longitude:longitude, speed: speed, lastSpeed:lastSpeed)
    }
    
    init(latitude: Double, longitude: Double, speed: Double, lastSpeed: Double, currentTimeInterval: Double, nextTimeInterval: Double) {
        locDataModel = DataModel(latitude:latitude, longitude:longitude, speed: speed, lastSpeed:lastSpeed, currentTimeInterval:currentTimeInterval, nextTimeInterval:nextTimeInterval)
    }
    
    //    init(speed: Double) {
    //        locDataModel = LocationDataModel(speed: speed)
    //    }
    
    var latitude: Double {
        return locDataModel.latitude!
    }
    
    var longitude: Double {
        return locDataModel.longitude!
    }
    
    var speed: Double {
        return locDataModel.speed!
    }
    
    var lastSpeed: Double {
        return locDataModel.lastSpeed!
    }
    
    var currentTimeInterval: Double {
        return locDataModel.currentTimeInterval!
    }
    
    var nextTimeInterval: Double {
        return locDataModel.nextTimeInterval!
    }
    
    //function to track location according to speed
    func getLocationUpdate(completionHandler: @escaping (_ data:DataViewModel) -> Void) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        if lastSpeed >= 80.0 && speed >= 80.0 {
            
            appdelegate.timer  = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true, block: {(timer) in
                print("time: 30")
                self.locDataModel.currentTimeInterval = 30.0
                self.locDataModel.nextTimeInterval = 30.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
                
            })
            
        }else if lastSpeed >= 60.0 && lastSpeed < 80.0 && speed >= 60.0 && speed < 80.0 {
            
            appdelegate.timer  = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true, block: {(timer) in
                print("time: 60")
                self.locDataModel.currentTimeInterval = 60.0
                self.locDataModel.nextTimeInterval = 60.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
                
            })
            
        }else if lastSpeed >= 30.0 && lastSpeed < 60.0 && speed >= 30.0 && speed < 60.0 {
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true, block: {(timer) in
                self.locDataModel.currentTimeInterval = 120.0
                self.locDataModel.nextTimeInterval = 120.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
                
            })
        }else if lastSpeed < 30.0 && speed < 30.0 {
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true, block: {(timer) in
                self.locDataModel.currentTimeInterval = 300.0
                self.locDataModel.nextTimeInterval = 300.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
                
            })
        }else if lastSpeed >= 80.0 && speed < 80.0 && speed >= 60.0 {
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 30.0
                self.locDataModel.nextTimeInterval = 60.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true, block: {(timer) in
                
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
        }else if lastSpeed >= 80.0 && speed < 60.0 && speed >= 30.0 {
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 30.0
                self.locDataModel.nextTimeInterval = 60.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 60.0
                self.locDataModel.nextTimeInterval = 120.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true, block: {(timer) in
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
        }else if lastSpeed >= 80.0 && speed < 30.0 {
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 30.0
                self.locDataModel.nextTimeInterval = 60.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 60.0
                self.locDataModel.nextTimeInterval = 120.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 120.0
                self.locDataModel.nextTimeInterval = 300.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true, block: {(timer) in
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
        }else if lastSpeed < 80.0 && lastSpeed >= 60.0 && speed < 60.0 && speed >= 30.0 {
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 60.0
                self.locDataModel.nextTimeInterval = 120.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: true, block: {(timer) in
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
        }else if lastSpeed < 80.0 && lastSpeed >= 60.0 && speed < 30.0 {
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 60.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 60.0
                self.locDataModel.nextTimeInterval = 120.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 120.0
                self.locDataModel.nextTimeInterval = 300.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true, block: {(timer) in
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
        }else if lastSpeed < 60.0 && lastSpeed >= 30.0 && speed < 30.0 {
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 120.0, repeats: false, block: {(timer) in
                self.locDataModel.currentTimeInterval = 120.0
                self.locDataModel.nextTimeInterval = 300.0
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
            
            appdelegate.timer = Timer.scheduledTimer(withTimeInterval: 300.0, repeats: true, block: {(timer) in
                completionHandler(DataViewModel(latitude: self.latitude, longitude: self.longitude, speed: self.speed, lastSpeed: self.lastSpeed, currentTimeInterval: self.currentTimeInterval, nextTimeInterval: self.nextTimeInterval))
            })
        }
    }
    
    //function to get time
    func getTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY-HH:mm:ss"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    //function to save data in database
    func saveDataInDatabase(tracking_data: String) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        appdelegate.insertDataToDatabase(trackingData: tracking_data)
    }
    
    //function to save data into file
    func saveDataToFile(tracking_data: String) {
        
        
        // Save data to file
        let fileName = "Track"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        print("FilePath: \(fileURL.path)")
        
        do {
            // Write to the file
            try tracking_data.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
        
        var readString = "" // Used to store the file contents
        do {
            // Read the file contents
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
        }
        print("File Text: \(readString)")
    }
    
}
