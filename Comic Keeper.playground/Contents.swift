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
    var filteredNumbers = [String]()
    issueNumbers.forEach { name in
        if !filteredNumbers.contains(name) {
            filteredNumbers.append(name)
        }
    }
    return filteredNumbers
}

print("Batman 1950", issuesNumbers(seriesName: "Batman 1950", publisherName: "DC Comics", from: cbc))
print("Aliens 1990", issuesNumbers(seriesName: "Aliens 1990", publisherName: "Dark Horse", from: cbc))
print("Fantastic Four 1961", issuesNumbers(seriesName: "Fantastic Four 1961", publisherName: "Marvel Comics", from: cbc))
print("Wonder Woman 1970", issuesNumbers(seriesName: "Wonder Woman 1970", publisherName: "DC Comics", from: cbc))


print("Bogus Four", issuesNumbers(seriesName: "Bogus Four", publisherName: "Marvel Comics", from: cbc))

let comicbook1 = cbc.comicbooks[0]
print(comicbook1.identifier)

let comicbook2 = cbc.comicbooks[3]
print(comicbook2.identifier)

let comparison = comicbook1 < comicbook2
print("[\(comicbook1.identifier)] is less than [\(comicbook2.identifier)]", comparison)

let variants = cbc.variantSignifiers(issueNumber: "1", seriesTitle: "Wonder Woman 1970", publisherName: "DC Comics")
print("Wonder Woman 1970 #1 variants:", variants)

print(comicbook1.identifier, "condition:", comicbook1.book.condition)
print(comicbook1.identifier, "purchase date:", comicbook1.book.purchaseDateText)
print(comicbook1.identifier, "purchase price:", comicbook1.book.purchasePriceText)
print(comicbook1.identifier, "sell date:", comicbook1.book.sellDateText)
print(comicbook1.identifier, "sell price:", comicbook1.book.sellPriceText)

for i in 0..<cbc.comicbooks.count {
    print(i,cbc.comicbooks[i].identifier)
}

// ww 1970 variants

let ww70_1a = cbc.comicBook(publisherName: "DC Comics", seriesName: "Wonder Woman", era: "1970", issueNumber: "1", variantSignifier: "a")
print("ww70_1a", ww70_1a?.identifier ?? "not found")

let ww70_1b = cbc.comicBook(publisherName: "DC Comics", seriesName: "Wonder Woman", era: "1970", issueNumber: "1", variantSignifier: "b")
print("ww70_1b", ww70_1b?.identifier ?? "not found")

let ww70_1x = cbc.comicBook(publisherName: "DC Comics", seriesName: "Wonder Woman", era: "1970", issueNumber: "1", variantSignifier: "x")
print("ww70_1x", ww70_1x?.identifier ?? "not found")

// ww 1980 variants

let ww80_1a = cbc.comicBook(publisherName: "DC Comics", seriesName: "Wonder Woman", era: "1980", issueNumber: "1", variantSignifier: "a")
print("ww80_1a", ww80_1a?.identifier ?? "not found")

let ww80_1b = cbc.comicBook(publisherName: "DC Comics", seriesName: "Wonder Woman", era: "1980", issueNumber: "1", variantSignifier: "b")
print("ww80_1b", ww80_1b?.identifier ?? "not found")

let ww80_1x = cbc.comicBook(publisherName: "DC Comics", seriesName: "Wonder Woman", era: "1980", issueNumber: "1", variantSignifier: "x")
print("ww80_1x", ww80_1x?.identifier ?? "not found")










