import UIKit

protocol iOSEngineerSkilSet {
    func getLanguageExpertise()
}

protocol devOpsEngineesSkilSet {
    func getLanguageExpertise()
}

class Employee {
    let name: String

    init(name: String) {
        self.name = name
    }

    func employeeDetails() {
        print("Emp name is \(name)")
    }
}

class iOSEngineer: Employee, iOSEngineerSkilSet, devOpsEngineesSkilSet {
    func getLanguageExpertise() {
        print("Swift")
    }
}

let iosEngineer = iOSEngineer(name: "Shitesh")
iosEngineer.employeeDetails()
iosEngineer.getLanguageExpertise()


func stringifyValue(distance: Int) -> String {
    var result: String = "The distance is "
    result += String(distance)
    return result
}
print(stringifyValue(distance: 67))


protocol AppDeveloper {
    func languageUsed() // dynamic dispatch
}

extension AppDeveloper {
    func languageUsed() {
        print("default language C, java")
    }

    func experienceLevel() { // static dispatch
        print("fresher")
    }
}

struct SwiftDeveloper: AppDeveloper {
    func languageUsed() {
        print("swift language")
    }

    func experienceLevel() {
        print("senior")
    }
}

let protocolObj: AppDeveloper = SwiftDeveloper()
let derivedObj: SwiftDeveloper = SwiftDeveloper()

print("************** protocolObj **************")
protocolObj.languageUsed()
protocolObj.experienceLevel()

print("************** derivedObj **************")
derivedObj.languageUsed()
derivedObj.experienceLevel()

