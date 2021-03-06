// Copyright 2014-2015 Ben Hale. All Rights Reserved


import ReactiveCocoa

protocol DramRepository {

    var drams: PropertyOf<Set<Dram>> { get }

    func delete(dram: Dram)

    func save(dram: Dram)
}