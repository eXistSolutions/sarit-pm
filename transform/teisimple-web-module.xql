module namespace pml='http://www.tei-c.org/tei-simple/models/teisimple.odd/web/module';

import module namespace m='http://www.tei-c.org/tei-simple/models/teisimple.odd/web' at '/db/apps/sarit-pm/transform/teisimple-web.xql';

(: Generated library module to be directly imported into code which
 : needs to transform TEI nodes using the ODD this module is based on.
 :)
declare function pml:transform($xml as node()*, $parameters as map(*)?) {

   let $options := map {
       "styles": ["../transform/teisimple.css"],
       "collection": "/db/apps/sarit-pm/transform",
       "parameters": if (exists($parameters)) then $parameters else map {}
   }
   return m:transform($options, $xml)
};