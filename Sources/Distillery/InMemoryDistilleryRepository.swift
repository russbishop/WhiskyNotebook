// Copyright 2014-2015 Ben Hale. All Rights Reserved


import Foundation
import CoreLocation
import ReactiveCocoa

final class InMemoryDistilleryRepository: DistilleryRepository {

    let distilleries: PropertyOf<Set<Distillery>>

    private let delegate: InMemoryRepository<Distillery>

    init(cache: Cache<Set<Distillery>>, scheduler: SchedulerType) {
        self.delegate = InMemoryRepository(cache: cache, scheduler: scheduler, type: "Distillery")
        self.distilleries = self.delegate.items
    }

    convenience init() {
        self.init(cache: Cache(type: "Distillery"), scheduler: QueueScheduler())
    }

    func delete(distillery: Distillery) {
        self.delegate.delete(distillery)
    }

    func save(distillery: Distillery) {
        self.delegate.save(distillery)
    }
}