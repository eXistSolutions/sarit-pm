xquery version "3.1";

import module namespace transliterate = "http://sarit.indology.info/ns/transliterate" at "transliterate.xqm";

declare default element namespace "http://www.tei-c.org/ns/1.0";

let $data-collection-path := "/apps/sarit-data/data/"
let $document-name := "mahabharata-devanagari"
let $document := doc($data-collection-path || $document-name || ".xml")

let $counter := doc('counter.xml')/*
let $current-counter := number($counter/current)
let $end-counter := number($counter/end)

let $result-document-path := $data-collection-path || "temp/" || $document-name || "-iast.xml"
(: let $store-result-document := xmldb:store($result-document-path, $document-name || "-iast.xml", $document) :)
let $result-document := doc($result-document-path)

return
    let $updated-current-counter := $current-counter + 1
    
    return
        if ($current-counter <= $end-counter)
        then (
            for $node in $result-document//body/div[number($counter/parent)]/div[position() = $current-counter]
            let $processed-node := transliterate:transliterate-node($node)
            
            return update replace $node with $processed-node
            ,
            update value $counter/current with $updated-current-counter
            ,
            "current counter: " || $current-counter || " of " || $end-counter
        )
        else "end of counter: " || $end-counter
    

 (:
18 - 6 svargArohana-18
(tei:head | tei:p)
 :)