// Copyright 2014-2015 Ben Hale. All Rights Reserved


import CoreLocation
import Foundation

struct Distillery {

    var id: String?

    var location: CLLocation?

    var name: String?

    var region: Region?

    private let key = NSUUID()
}

// MARK: - Equatable
extension Distillery: Equatable {}
func ==(x: Distillery, y: Distillery) -> Bool {
    return x.key == y.key
}

// MARK: - Hashable
extension Distillery: Hashable {
    var hashValue: Int { return self.key.hashValue }
}

// MARK: - Printable
extension Distillery: Printable {
    var description: String { return "<Distillery: \(self.key.UUIDString); id=\(self.id), location=\(self.location), name=\(self.name), region=\(self.region)>" }
}

// MARK: - Serializable
//extension Distillery: Serializable {
//
//    init(payload: [String : AnyObject]) {
//        self.id = payload["id"] as? String
//        self.location = locationFrom(payload["latitude"] as? String, payload["longitude"] as? String)
//        self.name = payload["name"] as? String
//
//        if let rawValue = payload["region"] as? String {
//            self.region = Region(rawValue: rawValue)
//        }
//    }
//
//    func serialize() -> [String : AnyObject] {
//        var payload = [String : AnyObject]()
//
//        payload["id"] = self.id
//        payload["latitude"] = self.location?.coordinate.latitude
//        payload["latitude"] = self.location?.coordinate.longitude
//        payload["name"] = self.name
//        payload["region"] = self.region?.rawValue
//
//        return payload
//    }
//}
