// Copyright 2014-2015 Ben Hale. All Rights Reserved


import Nimble
import Quick
import ReactiveCocoa
import UIKit

final class DistilleriesControllerSpec: QuickSpec {
    override func spec() {
        let storyboard = UIStoryboard(name: "WhiskyNotebook", bundle: NSBundle(forClass: self.dynamicType))

        describe("DistilleriesController") {
            var controller: DistilleriesController!
            var navigationController: UINavigationController!
            var repository: DistilleryRepository!
            var scheduler: TestScheduler!

            beforeEach {
                repository = InMemoryDistilleryRepository()
                scheduler = TestScheduler()

                controller = storyboard.instantiateViewControllerWithIdentifier("DistilleriesController") as! DistilleriesController

                navigationController = UINavigationController()
                navigationController.pushViewController(controller, animated: false)

                let dataSource = ArrayDistilleryDataSource(repository: repository, scheduler: scheduler)
                controller.dataSource = dataSource
                controller.scheduler = scheduler

                controller.loadView()
                controller.viewDidLoad()
                scheduler.advance()
            }

            describe("Interface Update") {
                it("removes add button when editing") {
                    expect(controller.navigationItem.rightBarButtonItem).toNot(beNil())
                    controller.setEditing(true, animated: false)
                    expect(controller.navigationItem.rightBarButtonItem).to(beNil())
                }

                it("sets the toolbar to visible when editing") {
                    expect(controller.navigationController?.toolbarHidden).to(beTruthy())
                    controller.setEditing(true, animated: false)
                    expect(controller.navigationController?.toolbarHidden).to(beFalsy())
                }
            }

            describe("Model Update") {
                it("updates the rows in the table when the model is updated") {
                    expect(controller.tableView.numberOfRowsInSection(0)).to(equal(0))
                    repository.save(Distillery())
                    scheduler.advance()
                    expect(controller.tableView.numberOfRowsInSection(0)).to(equal(1))
                }
            }
        }
    }
}
