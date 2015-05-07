// Copyright 2014-2015 Ben Hale. All Rights Reserved


import Foundation
import LoggerLogger
import ReactiveCocoa

final class InMemoryRepository<T: Hashable> {

    let items: PropertyOf<Set<T>>

    private let _items: MutableProperty<Set<T>>

    private let logger = Logger()

    private let type: String

    init(cache: Cache<Set<T>>, scheduler: SchedulerType, type: String) {
        self._items = MutableProperty(cache.retrieve() ?? Set())
        self._items.producer
            |> observeOn(scheduler)
            |> start { cache.persist($0) }

        self.items = PropertyOf(self._items)
        self.type = type
    }

    func delete(item: T) {
        self.logger.info("Deleting \(self.type) item: \(item)")
        self._items.value.remove(item)
        self.logger.debug("Deleted \(self.type) item: \(item)")
    }

    func save(item: T) {
        self.logger.info("Saving \(self.type) item: \(item)")
        self._items.value.insert(item)
        self.logger.debug("Saved \(self.type) item: \(item)")
    }
}

extension Set: Serializable {}