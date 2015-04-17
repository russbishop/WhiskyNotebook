// Copyright 2014-2015 Ben Hale. All Rights Reserved

import Nimble
import Quick
import UIKit
import WhiskyNotebook


final class DistilleriesControllerSpec: QuickSpec {
    override func spec() {
        let storyboard = UIStoryboard(name: "WhiskyNotebook", bundle: nil)

        describe("DistilleriesController") {
            var controller: DistilleriesController!
            var repository: DistilleryRepository!

            beforeEach {
                repository = InMemoryDistilleryRepository()

                controller = storyboard.instantiateViewControllerWithIdentifier("DistilleriesController") as! DistilleriesController
                controller.dataSource.repository = repository

                controller.loadView()
                controller.viewDidLoad()
            }

            describe("Interface Update") {
                it("removes add button when editing") {
                    expect(controller.navigationItem.rightBarButtonItem).toNot(beNil())
                    controller.setEditing(true, animated: false)
                    expect(controller.navigationItem.rightBarButtonItem).to(beNil())
                }
            }

            describe("Model Update") {
                it("updates the rows in the table when the model is updated") {
                    expect(controller.tableView.numberOfRowsInSection(0)).to(equal(0))
                    repository.save(Distillery())
                    expect(controller.tableView.numberOfRowsInSection(0)).toEventually(equal(1))
                }
            }
        }
    }
}