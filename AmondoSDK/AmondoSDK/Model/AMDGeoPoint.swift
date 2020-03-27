import Foundation

struct AMDGeoPoint {
    let latitude: Double
    let longitude: Double

    init(points: [Double]) {
        self.latitude = points[0]
        self.longitude = points[1]
    }

    static var zero: AMDGeoPoint {
        return AMDGeoPoint(points: [0.0, 0.0])
    }
}
