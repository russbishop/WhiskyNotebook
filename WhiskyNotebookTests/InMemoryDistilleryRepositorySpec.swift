// Copyright 2014-2015 Ben Hale. All Rights Reserved

import Nimble
import Quick
import ReactiveCocoa
import WhiskyNotebook


final class InMemoryDistilleryRepositorySpec: QuickSpec {

    override func spec() {
        describe("InMemoryDistilleryRepository") {
            var repository: InMemoryDistilleryRepository!
            var distilleries: Set<Distillery>!

            beforeEach {
                repository = InMemoryDistilleryRepository()
                repository.distilleries
                    |> start { distilleries = $0 }
            }

            it("deletes distillery") {
                let distillery = Distillery()
                repository.save(distillery)
                expect(distilleries.count).toEventually(equal(1))
                repository.delete(distillery)
                expect(distilleries.count).toEventually(equal(0))
            }

            it("saves distillery") {
                expect(distilleries.count).toEventually(equal(0))
                repository.save(Distillery())
                expect(distilleries.count).toEventually(equal(1))
            }

            it("replaces existing distillery") {
                let distillery = Distillery()
                expect(distilleries.count).toEventually(equal(0))
                repository.save(distillery)
                expect(distilleries.count).toEventually(equal(1))
                repository.save(distillery)
                expect(distilleries.count).toEventually(equal(1))
            }

            it("signals changes to distilleries") {
                let distillery = Distillery()
                repository.save(distillery)
                expect(distilleries).toEventually(contain(distillery))
            }
        }
    }
}