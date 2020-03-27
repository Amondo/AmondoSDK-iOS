import Foundation
import Photos

extension CLLocation {
    convenience init(from: AMDGeoPoint) {
        self.init(latitude: from.latitude, longitude: from.longitude)
    }
}
