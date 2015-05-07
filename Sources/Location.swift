// Copyright 2014-2015 Ben Hale. All Rights Reserved


import CoreLocation

func locationFrom(latitude: String?, longitude: String?) -> CLLocation? {
    return locationFrom(latitude?.toDouble(), longitude?.toDouble())
}

func locationFrom(latitude: Double?, longitude: Double?) -> CLLocation? {
    if let latitude = latitude, let longitude = longitude {
        return CLLocation(latitude: latitude, longitude: longitude)
    } else {
        return nil
    }
}