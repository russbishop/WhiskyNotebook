// Copyright 2014-2015 Ben Hale. All Rights Reserved


import Foundation
import LoggerLogger

final class Cache<T: Serializable> {

    private let location: NSURL?

    private let logger = Logger()

    private let type: String

    init(type: String) {
        self.location = Cache.location(type)
        self.type = type
    }

    func persist(item: T?) {
        if var item = item, let location = self.location {
            self.logger.debug("Persisting \(self.type) items")
            NSData(bytes: &item, length: sizeof(T)).writeToURL(location, atomically: true)
            self.logger.debug("Persisted \(self.type) items")
        } else {
            self.logger.debug("Did not persist \(self.type) items")
        }
    }

    func retrieve() -> T? {
        if let location = self.location, let data = NSData(contentsOfURL: location) {
            self.logger.debug("Retrieving \(self.type) items")

            var item = T()
            data.getBytes(&item, length: sizeof(T))

            self.logger.debug("Retrieved \(self.type) items")
            return item
        } else {
            self.logger.debug("Did not retrieve \(self.type) items")
            return nil
        }
    }

    private static func location(name: String, withExtension: String = "plist") -> NSURL? {
        let fileManager = NSFileManager.defaultManager()

        if let cachesDirectory = fileManager.URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).first as? NSURL {
            if let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier {
                let bundleCacheDirectory = cachesDirectory.URLByAppendingPathComponent(bundleIdentifier, isDirectory: true)
                fileManager.createDirectoryAtURL(bundleCacheDirectory, withIntermediateDirectories: true, attributes: nil, error: nil)

                return bundleCacheDirectory.URLByAppendingPathComponent(name).URLByAppendingPathExtension(withExtension)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}