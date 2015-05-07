// Copyright 2014-2015 Ben Hale. All Rights Reserved


import ReactiveCocoa

final class InMemoryDramRepository: DramRepository {

    let drams: PropertyOf<Set<Dram>>

    private let delegate: InMemoryRepository<Dram>

    init(cache: Cache<Set<Dram>>, scheduler: SchedulerType) {
        self.delegate = InMemoryRepository(cache: cache, scheduler: scheduler, type: "Dram")
        self.drams = self.delegate.items
    }

    convenience init() {
        self.init(cache: Cache(type: "Dram"), scheduler: QueueScheduler())
    }

    func delete(dram: Dram) {
        self.delegate.delete(dram)
    }

    func save(dram: Dram) {
        self.delegate.save(dram)
    }
}