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

func seriesTitle(for comic: Comic) -> String {
    return "\(comic.series) \(comic.era)"
}

print("Series Title (series + era)", seriesTitle(for: cbc.comicbooks[0].comic))
print("Series Title (series + era)", seriesTitle(for: cbc.comicbooks[3].comic))


func seriesNames(publisherName: String, from cbc: ComicBookCollection) -> [String] {
    let seriesNames = cbc.comicbooks.compactMap {$0.comic.publisher == publisherName ? seriesTitle(for: $0.comic) : nil}
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
        $0.comic.publisher == publisherName && seriesTitle(for: $0.comic) == seriesName ? $0.comic.issueNumber : nil
    }
    return issueNumbers
}

print("Batman 1950", issuesNumbers(seriesName: "Batman 1950", publisherName: "DC Comics", from: cbc))
print("Aliens 1990", issuesNumbers(seriesName: "Aliens 1990", publisherName: "Dark Horse", from: cbc))
print("Fantastic Four 1961", issuesNumbers(seriesName: "Fantastic Four 1961", publisherName: "Marvel Comics", from: cbc))

print("Bogus Four", issuesNumbers(seriesName: "Bogus Four", publisherName: "Marvel Comics", from: cbc))




