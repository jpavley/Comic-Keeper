import UIKit
import Comic_Keeper_Framework
import PlaygroundSupport

var str = "Hello, playground"

let cbc = ComicBookCollection.createComicBookCollection()

print(cbc.comicbooks[0].comic.publisher)
