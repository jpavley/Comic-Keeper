import UIKit
import Comic_Keeper_Framework
import PlaygroundSupport

var str = "Hello, playground"

let cbc = ComicBookCollection.createComicBookCollection()

func publisherNames(from cbc: ComicBookCollection) -> [String] {
    let publisherNames = cbc.comicbooks.map {$0.comic.publisher}
    var filteredNames = [String]()
    publisherNames.forEach { name in
        if !filteredNames.contains(name) {
            filteredNames.append(name)
        }
    }
    return filteredNames
}

print("Publishers", publisherNames(from: cbc))

func seriesNames(publisherName: String, from cbc: ComicBookCollection) -> [String] {
    let seriesNames = cbc.comicbooks.compactMap {$0.comic.publisher == publisherName ? $0.comic.series : nil}
    var filteredNames = [String]()
    seriesNames.forEach { name in
        if !filteredNames.contains(name) {
            filteredNames.append(name)
        }
    }
    return filteredNames
}

print("DC Comics", seriesNames(publisherName: "DC Comics", from: cbc))
print("Dark Horse", seriesNames(publisherName: "Dark Horse", from: cbc))
print("Marvel Comics", seriesNames(publisherName: "Marvel Comics", from: cbc))

print("Bogus Comics", seriesNames(publisherName: "Bogus Comics", from: cbc))


func issuesNumbers(seriesName: String, publisherName: String, from cbc: ComicBookCollection) -> [String] {
    let issueNumbers = cbc.comicbooks.compactMap {
        $0.comic.publisher == publisherName && $0.comic.series == seriesName ? $0.comic.issueNumber : nil
    }
    return issueNumbers
}

print("Batman", issuesNumbers(seriesName: "Batman", publisherName: "DC Comics", from: cbc))
print("Aliens", issuesNumbers(seriesName: "Aliens", publisherName: "Dark Horse", from: cbc))
print("Fantastic Four", issuesNumbers(seriesName: "Fantastic Four", publisherName: "Marvel Comics", from: cbc))

print("Bogus Four", issuesNumbers(seriesName: "Bogus Four", publisherName: "Marvel Comics", from: cbc))




