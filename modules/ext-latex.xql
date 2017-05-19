xquery version "3.0";

module namespace pmf="http://sarit.indology.info/teipm/latex";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

import module namespace latex="http://www.tei-c.org/tei-simple/xquery/functions/latex" at "xmldb:exist:///db/apps/tei-simple/content/latex-functions.xql";

declare function pmf:document($config as map(*), $node as element(), $class as xs:string+, $content) {
    let $odd := doc($config?odd)
    let $config := latex:load-styles($config, $odd)
    let $fontSize := ($config?font-size, "11pt")[1]
    return (
        "\RequirePackage[log]{snapshot}&#10;",
        "\documentclass[article,12pt,a4paper]{" || latex:get-property($config, "class", "book") || "}&#10;",    
        "\usepackage[normalem]{ulem}&#10;",
        "\usepackage{eulervm}&#10;",
        "\usepackage{xltxtra}&#10;",
        "\usepackage{polyglossia}&#10;",
        "\PolyglossiaSetup{sanskrit}{",
        "hyphenmins={2,3}}&#10;",
        "\setdefaultlanguage{sanskrit}&#10;",
        "\setotherlanguages{english,german,italian,french}&#10;",
        "\setotherlanguage[numerals=arabic]{tibetan}&#10;",
        "\usepackage{fontspec}&#10;",
        "\catcode`⃥=\active \def⃥{\textbackslash}&#10;",
        "\catcode`‿=\active \def‿{\textunderscore}&#10;",
        "\catcode`❴=\active \def❴{\{}&#10;",
        "\catcode`❵=\active \def❵{\}}&#10;",
        "\catcode`〔=\active \def〔{{[}}&#10;",
        "\catcode`〕=\active \def〕{{]}}&#10;",
        "\catcode` =\active \def {\,}&#10;",
        "\catcode`·=\active \def·{\textbullet}&#10;",
        "\catcode`=\active \def{\-}&#10;",
        "\catcode`ꣵ=\active \defꣵ{",
            "म्\textsuperscript{cb}",
        "}&#10;",
        "%\catcode`↤=\active \def↤{$\leftarrow$}&#10;",
        "%\catcode`↦=\active \def↦{$\rightarrow$}&#10;",
        "\tolerance=9000 &#10;",
        "\def\textJapanese{\fontspec{Kochi Mincho}}&#10;",
        "\def\textChinese{\fontspec{HAN NOM A}}&#10;",
        "\def\textKorean{\fontspec{Baekmuk Gulim} }&#10;",
        "\newfontfamily\englishfont[Mapping=tex-text]{TeX Gyre Schola}&#10;",
        "\newfontfamily\devanagarifont{TeX Gyre Pagella}}&#10;",
        "\newfontfamily\rmlatinfont[Mapping=tex-text]{TeX Gyre Pagella}&#10;",
        "\newfontfamily\tibetanfont[Script=Tibetan,Scale=1.2]{Tibetan Machine Uni}&#10;",
        "\newcommand\bo\tibetanfont&#10;",
        "\defaultfontfeatures{Scale=MatchLowercase,Mapping=tex-text}&#10;",
        "%\setmainfont{Chandas}&#10;",
        "\setmainfont{TeX Gyre Pagella}&#10;",
        "\setsansfont{TeX Gyre Bonum}&#10;",
        "\setmonofont{DejaVu Sans Mono}&#10;",
        "\setlength{\trimtop}{\stockheight}&#10;",
        "\addtolength{\trimtop}{-\paperheight}&#10;",
        "\setlength{\trimedge}{\stockwidth}&#10;",
        "\addtolength{\trimedge}{-\paperwidth}&#10;",
        "\settrims{0.5\trimtop}{0.5\trimedge}&#10;",
        "\setxlvchars&#10;",
        "\setlxvchars&#10;",
        "\settypeblocksize{230mm}{130mm}{*}&#10;",
        "\setlrmargins{*}{*}{1.5}&#10;",
        "\setulmargins{*}{*}{1.5}&#10;",
        "\setheadfoot{2\baselineskip}{2\baselineskip}&#10;",
        "\setheaderspaces{*}{*}{1.5}&#10;",
        "\setlength{\topskip}{1.6\topskip}&#10;",
        "\checkandfixthelayout&#10;",
        "\sloppybottom&#10;",
        "\maxtocdepth{section}&#10;",
        "\setpnumwidth{4em}&#10;",
        "\setrmarg{5em}&#10;",
        "\setsecnumdepth{all}&#10;",
        "\newenvironment{docImprint}{\vskip 6pt}{\ifvmode\par\fi }&#10;",
        "\newenvironment{docDate}{}{\ifvmode\par\fi }&#10;",
        "\newenvironment{docAuthor}{\ifvmode\vskip4pt\fontsize{16pt}{18pt}\selectfont\fi\itshape}{\ifvmode\par\fi }&#10;",
        "\newcommand{\docTitle}[1]{#1}&#10;",
        "\newenvironment{titlePart}{ }{ }&#10;",
        "\newenvironment{byline}{\vskip6pt\itshape\fontsize{16pt}{18pt}\selectfont}{\par }&#10;",
        "\newcommand*{\plogo}{\fbox{$\mathcal{SARIT}$}}&#10;",
        "\newcommand*{\makeCustomTitle}{\begin{english}\begingroup&#10;",
        "\thispagestyle{empty}&#10;",
        "\raggedleft&#10;",
        "\vspace*{\baselineskip}&#10;",
        "{\Large Aśoka}\\[0.167\textheight]&#10;",
        "{\Huge Avayavinirākaraṇa}\\[\baselineskip]]&#10;",
        "{\small  — A SARIT edition}\\[\baselineskip]&#10;",
        "{\Large SARIT}\\\vspace*{\baselineskip}\plogo\par&#10;",
        "\vspace*{3\baselineskip}&#10;",
        "\endgroup&#10;",
        "\end{english}}&#10;",
        
        "\newcommand{\gap}[1]{}&#10;",
  	  "\newcommand{\corr}[1]{($^{x}$#1)}&#10;",
  	  "\newcommand{\sic}[1]{($^{!}$#1)}&#10;",
  	  "\newcommand{\reg}[1]{#1}&#10;",
  	  "\newcommand{\orig}[1]{#1}&#10;",
  	  "\newcommand{\abbr}[1]{#1}&#10;",
  	  "\newcommand{\expan}[1]{#1}&#10;",
  	  "\newcommand{\unclear}[1]{($^{?}$#1)}&#10;",
  	  "\newcommand{\add}[1]{($^{+}$#1)}&#10;",
  	  "\newcommand{\deletion}[1]{($^{-}$#1)}&#10;",
      "\newcommand{\quotelemma}[1]{\textcolor{cyan}{#1}}&#10;",
  	"%\newcommand{\quotelemma}[1]{{\color{Green4}#1}}&#10;",
  	"%\newcommand{\name}[1]{\emph{#1}}&#10;",
    "\newcommand{\name}[1]{#1}&#10;",
  	"%\newcommand{\persName}[1]{\emph{#1}}&#10;",
    "\newcommand{\persName}[1]{#1}&#10;",
  	"%\newcommand{\placeName}[1]{\emph{#1}}&#10;",
    "\newcommand{\placeName}[1]{#1}&#10;",
    "\usepackage[x11names]{xcolor}&#10;",
    "\definecolor{shadecolor}{gray}{0.95}&#10;",
    "\usepackage{longtable}&#10;",
    "\usepackage{ctable}&#10;",
    "\usepackage{rotating}&#10;",
    "\usepackage{lscape}&#10;",
    "\usepackage{ragged2e}&#10;",
    "\usepackage{titling}&#10;",
    "\usepackage{marginnote}&#10;",
    "\renewcommand*{\marginfont}{\color{black}\rmlatinfont\scriptsize}&#10;",
    "\setlength\marginparwidth{.75in}&#10;",
    "\usepackage{graphicx}&#10;",
    "\usepackage{csquotes}&#10;",
    "\def\Gin@extensions{.pdf,.png,.jpg,.mps,.tif}&#10;",
    
    "\usepackage[noend,series={A,B}]{reledmac}&#10;",
    
    "\makeatletter&#10;",
    "\def\select@lemmafont#1|#2|#3|#4|#5|#6|#7|",
    "{}&#10;",
    "\makeatother&#10;",
    "\AtEveryPstart{\refstepcounter{parCount}}&#10;",
    "\setlength{\stanzaindentbase}{20pt}&#10;",
    "%\setstanzaindents{3,2,2,2,2,2,2,2,2,}&#10;",
    "\setstanzaindents{3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,}&#10;",
    "\lineation{page}&#10;",
    "\linenumberstyle{arabic}&#10;",
    "\firstlinenum{5}&#10;",
    "\linenumincrement{5}&#10;",
    "\renewcommand*{\numlabfont}{\normalfont\scriptsize\color{black}}&#10;",
    "%\Xbhookgroup{\color{black}}%For footnotegroup&#10;",
    "%\renewcommand{\Afootnoterule}{\color{black}\normalfootnoterule}&#10;",
    "\addtolength{\skip\Afootins}{1.5mm}&#10;",
    "\Xnotenumfont{\bfseries\footnotesize}&#10;",
    "\sidenotemargin{outer}&#10;",
    "\linenummargin{inner}&#10;",
    "\Xarrangement{twocol}&#10;",
    "\arrangementX{twocol}&#10;",
    "\usepackage[backend=biber,",
    "citestyle=authoryear,",
    "bibstyle=authoryear,",
    "language=english,",
    "sortlocale=en_US,",
    "]{biblatex}&#10;",
    "\addbibresource[location=remote]{https://raw.githubusercontent.com/paddymcall/Stylesheets/HEAD/profiles/sarit/latex/bib/sarit.bib}&#10;",
    "\renewcommand*{\citesetup}{",
    "\rmlatinfont",
    "\biburlsetup",
    "\frenchspacing}&#10;",
    "\renewcommand{\bibfont}{\rmlatinfont}&#10;",
    "\DeclareFieldFormat{postnote}{:#1}&#10;",
    "\renewcommand{\postnotedelim}{}&#10;",
    
    "\setcounter{errorcontextlines}{400}&#10;",
    "\usepackage{lscape}&#10;",
    "\usepackage{minted}&#10;",
    
    "\pagestyle{ruled}&#10;",
    "\makeoddhead{ruled}{{}}{}{\leftmark}&#10;",
    "\makeevanhead{ruled}{{}}{}{\rightmark}&#10;",
    "\makeoddfoot{ruled}{{\tiny\rmlatinfont \textit{Compiled: \today}}}{",
    "{\tiny\rmlatinfont \textit{Revision: \href{https://github.com/paddymcall/SARIT-pdf-conversions/commit/ad0c50b}{ad0c50b}}}",
    "}{\rmlatinfont\thepage}&#10;",
    "\makeevenfoot{ruled}{\rmlatinfont\thepage}{",
    "{\tiny\rmlatinfont \textit{Revision: \href{https://github.com/paddymcall/SARIT-pdf-conversions/commit/ad0c50b}{ad0c50b}}}",
    "}{{\tiny\rmlatinfont \textit{Compiled: \today}}}&#10;",
    
    "\usepackage{perpage}&#10;",
        "\MakePerPage{footnote}&#10;",
        
    "\usepackage[destlabel=true,",
        "pdftitle={Avayavinirākaraṇa // Aśoka},",
        "pdfauthor={SARIT: Search and Retrieval of Indic Texts. DFG/NEH Project (NEH-No.",
 	"HG5004113), 2013-2017 },",
        "unicode=true]{hyperref}&#10;",
        
        "\renewcommand\UrlFont{\rmlatinfont}&#10;",
        "\newcounter{parCount}&#10;",
        "\setcounter{parCount}{0}&#10;",
        
        "\usepackage[english]{cleveref}&#10;",
        "\crefname{parCount}{§}{§§}&#10;",
        
        if (exists($config?image-dir)) then
            "\graphicspath{" ||
            string-join(
                for $dir in $config?image-dir return "{" || $dir || "}"
            ) ||
            "}&#10;"
        else
            (),
        "%\def\tableofcontents{\section*{\contentsname}\@starttoc{toc}}&#10;",
        "%\thispagestyle{empty}&#10;",
        $config("latex-styles"),
        "\begin{document}&#10;",
        "\makeCustomTitle&#10;",    
        "\let\tabcellsep&amp;&#10;",
        "\frontmatter&#10;",
        "\tableofcontents&#10;",
        "\cleardoublepage&#10;",
        if (latex:get-property($config, "class", "book") = "book") then "\mainmatter&#10;" else (),
        "%\fancyhead[EL,OR]{\fontsize{8}{11}\selectfont\thepage}&#10;",
        "%\fancyhead[ER]{\fontsize{8}{11}\selectfont\leftmark}&#10;",
        "%\fancyhead[OL]{\fontsize{8}{11}\selectfont\leftmark}&#10;",
        "\beginnumbering&#10;",
        $config?apply-children($config, $node, $content),
        "\end{document}"
    )
};

declare function pmf:paragraph($config as map(*), $node as element(), $class as xs:string+, $content) {
    "\pstart \leavevmode&#10;",
    latex:get-content($config, $node, $class, $content),
    "{\color{gray}{\rmlatinfont\textsuperscript{§~\theparCount}}}&#10;",
    "\pend&#10;",
    if ($node/ancestor::tei:note) then
        ()
    else
        "&#10;&#10;"
};

declare function pmf:stanza($config as map(*), $node as element(), $class as xs:string+, $content) {
    "\stanza[\smallbreak]&#10;",
    latex:get-content($config, $node, $class, $content),
    "\&amp;[\smallbreak]&#10;&#10;"
};

declare function pmf:stanza-line($config as map(*), $node as element(), $class as xs:string+, $content) {
    latex:get-content($config, $node, $class, $content),
    if ($node/following-sibling::tei:l) then
        "&amp;"
    else
        ()
};

declare function pmf:break($config as map(*), $node as element(), $class as xs:string+, $content, $type as xs:string, $label as item()*) {
    switch($type)
        case "page" return
            if ($node/@ed) then
                "\marginpar{" || $node/@ed || ": p." || $node/@n || "}"
            else
                "\marginpar{p." || $node/@n || "}"
        default return
            ()
};

declare function pmf:note($config as map(*), $node as element(), $class as xs:string+, $content as item()*, $place as xs:string?, $label as xs:string?) {
    if ($config?skip-footnotes) then
        ()
    else
        switch($place)
            case "margin" return (
                "\marginpar{" || latex:get-content($config, $node, $class, $content) || "}"
            )
            default return (
                string-join((
                    if ($node/parent::tei:head) then
                        "\protect"
                    else
                        (),
                    "\footnote{" || latex:get-content($config, $node, $class, $content) || "}"
                ))
            )
};
