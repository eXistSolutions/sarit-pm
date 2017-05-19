(:~
 : Transform a given source into a standalone document using
 : the specified odd.
 : 
 : @author Wolfgang Meier
 :)
xquery version "3.0";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

import module namespace config="http://www.tei-c.org/tei-simple/config" at "config.xqm";
import module namespace pm-config="http://www.tei-c.org/tei-simple/pm-config" at "pm-config.xql";
import module namespace pmu="http://www.tei-c.org/tei-simple/xquery/util" at "/db/apps/tei-simple/content/util.xql";
import module namespace odd="http://www.tei-c.org/tei-simple/odd2odd" at "/db/apps/tei-simple/content/odd2odd.xql";
import module namespace process="http://exist-db.org/xquery/process" at "java:org.exist.xquery.modules.process.ProcessModule";
import module namespace console="http://exist-db.org/xquery/console" at "java:org.exist.console.xquery.ConsoleModule";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare option output:method "text";
declare option output:html-version "5.0";
declare option output:media-type "text/text";

declare variable $local:WORKING_DIR := system:get-exist-home() || "/webapp";
declare variable $local:TEMP := $local:WORKING_DIR || "/teisimple-temp";

declare variable $local:CACHE := true();

declare variable $local:CACHE_COLLECTION := $config:app-root || "/cache";

declare variable $local:TeX_COMMAND := function($file) {
    ( "/usr/local/texlive/2016/bin/x86_64-darwin/xelatex", "-interaction=nonstopmode", "-shell-escape", $file )
};

declare function local:prepare-cache-collection() {
    if (xmldb:collection-available($local:CACHE_COLLECTION)) then
        ()
    else
        (xmldb:create-collection($config:app-root, "cache"))[2]
};

declare function local:cache($id as xs:string, $file as xs:string) {
    local:prepare-cache-collection(),
    xmldb:store-files-from-pattern($local:CACHE_COLLECTION, $local:TEMP, $file)
};

declare function local:get-cached($id as xs:string, $doc as node()) {
    let $path := $local:CACHE_COLLECTION || "/" ||  $id || "-tex.pdf"
    return
        if ($local:CACHE and util:binary-doc-available($path)) then
            let $modDatePDF := xmldb:last-modified($local:CACHE_COLLECTION, $id || "-tex.pdf")
            let $modDateSrc := xmldb:last-modified(util:collection-name($doc), util:document-name($doc))
            return
                if ($modDatePDF >= $modDateSrc) then
                    util:binary-doc($path)
                else
                    ()
        else
            ()
};

let $id := request:get-parameter("id", ())
let $token := request:get-parameter("token", ())
let $source := request:get-parameter("source", ())
let $useCache := request:get-parameter("cache", "yes")
let $doc := doc($config:data-root || "/" || $id || ".xml")
let $name := util:document-name($doc)
return (
    let $cached := if ($useCache = ("yes", "true")) then local:get-cached($id, $doc) else ()
    return (
        response:set-cookie("simple.token", $token),
        if (not($source) and exists($cached)) then (
            console:log("Reading " || $name || " pdf from cache"),
            response:stream-binary($cached, "media-type=application/pdf", $id || ".pdf")
        ) else if ($id) then
            let $xml := $doc/tei:TEI
            let $tex := string-join($pm-config:latex-transform($xml, ()))
            let $file := 
                $id || format-dateTime(current-dateTime(), "-[Y0000][M00][D00]-[H00][m00]")
            return
                if ($source) then
                    response:stream-binary(util:string-to-binary($tex), "media-type=application/x-tex", $file || ".tex")
                else
                    let $serialized := file:serialize-binary(util:string-to-binary($tex), $local:TEMP || "/" || $file || ".tex")
                    let $options :=
                        <option>
                            <workingDir>{$local:TEMP}</workingDir>
                        </option>
                    let $output :=
                        process:execute(
                            ( $local:TeX_COMMAND($file) ), $options
                        )
                    return
                        if ($output/@exitCode < 2) then
                            let $pdf := file:read-binary($local:TEMP || "/" || $file || ".pdf")
                            let $path := local:cache($name, $id || "-tex.pdf")
                            return
                                response:stream-binary($pdf, "media-type=application/pdf", $file || ".pdf")
                        else
                            $output
        else
            <p>No document specified</p>
    )
)