%% Vorlage für Präsentationen mit LaTeX Beamer im KIT-Design
%% entsprechend den Gestaltungsrichtlinien vom 1. August 2020
%%
%% Siehe https://sdqweb.ipd.kit.edu/wiki/Dokumentvorlagen


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sdqbeamer}[2021-08-10 v3.1.2 SDQ Beamer class]

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

\newif\ifsectionnavigation
\newif\ifnavbarinfoot
\newif\ifnavbarinline
\newif\ifnavbarside
\newif\iffourtothree
\newif\ifsixteentonine
\newif\ifsixteentoten
\newif\ifgerman
\newif\ifsmallfooterfont

\def\kitslogan#1{\def\@kitslogan{#1}}
\def\kitlogo#1{\def\@kitlogo{#1}}
\def\groupname#1{\def\@groupname{#1}}

% siehe README.md
\DeclareOption{de}{
  \kitslogan{KIT -- Die Forschungsuniversität in der Helmholtz-Gemeinschaft}
  \kitlogo{kitlogo_de_rgb}
  \germantrue
  \PassOptionsToPackage{autostyle}{csquotes}
  }
\DeclareOption{en}{
  \kitslogan{KIT -- The Research University in the Helmholtz Association}
  \kitlogo{kitlogo_en_rgb}
  \germanfalse
  }
\DeclareOption{4:3}{
  \fourtothreetrue
  \sixteentoninefalse
  \sixteentotenfalse
}
\DeclareOption{16:9}{
	\fourtothreefalse
	\sixteentoninetrue
	\sixteentotenfalse
}
\DeclareOption{16:10}{
	\fourtothreefalse
	\sixteentoninefalse
	\sixteentotentrue
}
\DeclareOption{navbarside}{
  \sectionnavigationtrue
  \navbarsidetrue
  \navbarinlinefalse
  \navbarinfootfalse
}
\DeclareOption{navbarinline}{
  \sectionnavigationtrue
  \navbarsidefalse
  \navbarinlinetrue
  \navbarinfootfalse
}
\DeclareOption{navbarinfooter}{
  \sectionnavigationtrue
  \navbarsidefalse
  \navbarinlinefalse
  \navbarinfoottrue
}
\DeclareOption{navbaroff}{
  \sectionnavigationfalse
}
\DeclareOption{navbarkit}{
  \sectionnavigationfalse
  \smallfooterfonttrue
}
\DeclareOption{smallfoot}{
  \smallfooterfonttrue
}
\DeclareOption{bigfoot}{
  \smallfooterfontfalse
}

\ExecuteOptions{de,16:9,navbarinline,bigfoot}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}

\ProcessOptions\relax

\LoadClass[10pt,utf8]{beamer}

% Babel-Paket wird nur bei deutscher Sprache benötigt
\ifgerman
  \RequirePackage[ngerman]{babel}
\fi
\RequirePackage{csquotes}
\RequirePackage{hyperref}
\RequirePackage[absolute,overlay]{textpos}

%% ---------------
%% | Typographie |
%% ---------------

\RequirePackage{microtype}

\RequirePackage[scaled=.92]{helvet}
\RequirePackage[scaled=.78]{beramono}
\RequirePackage{libertineRoman}

\setbeamerfont{title}{series=\bfseries,size=\Large}
\setbeamerfont{frametitle}{series=\bfseries,size=\Large}
\setbeamerfont{framesubtitle}{series=\bfseries,size=\normalsize}

%% -----------------
%% | Folien-Layout |
%% -----------------

% Seitenverhältnis
%
% Die Folien sind auf die Standardhöhe in LaTeX Beamer (9,6 cm) normiert.
% Die Maße der KIT-Gestaltungsrichtlinien (Folienhöhe 14,3 cm) wurden durch
% den Quotienten 1,5 geteilt.

\RequirePackage{geometry}
\iffourtothree
	\geometry{papersize={12.8cm,9.6cm}}
\fi
\ifsixteentoten
	\geometry{papersize={15.36cm,9.6cm}}
\fi
\ifsixteentonine
	\geometry{papersize={17.07cm,9.6cm}}
\fi

% Ränder laut Gestaltungsrichtlinen; 3 mm -> 2 mm, 11 mm -> 7,3 mm
\newlength{\kitoutermargin}
\setlength{\kitoutermargin}{2mm}
\newlength{\kitinnermargin}
\setlength{\kitinnermargin}{7.3mm}
\newlength{\kitbottommargin}
\setlength{\kitbottommargin}{\kitinnermargin}

% Ränder außen
\setbeamersize{text margin left=\kitinnermargin,text margin right=\kitinnermargin} 

% keine Navigationssymbole
\setbeamertemplate{navigation symbols}{}
\setbeamercovered{invisible}
\useinnertheme{rounded}
\beamer@compresstrue % Miniframes (Navigations-Punkte) für Subsections immer in einer Zeile, ohne Umbrüche

% Folientitel
\setbeamertemplate{frametitle}{
  \ifbeamer@plainframe\else%
    % Unterkante Titeltext: 22,5 mm -> 15 mm von Seitenkopf
    \begin{textblock*}{\dimexpr\paperwidth-30mm}[0,1](\kitinnermargin,15mm)%
      \usebeamerfont{frametitle}\insertframetitle%
      \ifx\insertframesubtitle\@empty\else\\[.1em]\fi
      \usebeamerfont{framesubtitle}\insertframesubtitle%
    \end{textblock*}%
    \begin{textblock*}{20mm}[1,1](\dimexpr\paperwidth-\kitinnermargin\relax,15mm)%j
        \includegraphics[width=20mm]{logos/\@kitlogo}%
    \end{textblock*}%
  \fi
% Rand oben (ergibt Beginn des Textes bei 34 mm -> 22,7 mm)
  \vspace {18mm}
}

%% Fußzeile
\newlength{\kitbottom}
  % Navbar in Footer: Schmale Fußzeile
\ifnavbarinfoot
  % Bei Navbar in Footer immer kleiner Font in der Fußzeile
  \setbeamerfont{footer}{size=\fontsize{6pt}{7.2pt}\selectfont}
  \setlength{\kitbottom}{4mm}
\else
  % Ansonsten kleiner Text nur, wenn "smallfoot" gewählt
  \ifsmallfooterfont
    \setbeamerfont{footer}{size=\fontsize{6pt}{7.2pt}\selectfont}
  \else
    \setbeamerfont{footer}{size=\scriptsize}
  \fi
  \setlength{\kitbottom}{\kitbottommargin}
\fi
\setbeamerfont{page number in head/foot}{series=\bfseries}

\newlength{\kitbottomdepth}
\newlength{\kitbottomheight}
\newlength{\kitfootergroupwidth}

\setbeamertemplate{footline}{%
\setlength{\kitbottomdepth}{\dimexpr.5\kitbottom-.5em\relax}%
\setlength{\kitbottomheight}{\dimexpr.5\kitbottom+.5em\relax}%
  %% die "%" am Ende sind nötig, damit keine Abstände eingefügt werden
  %
  % Falls kein Gruppenname angegeben, die ganze Breite der Fußzeile für den Titel nutzen.
  \ifdefined\@groupname%
    \ifx\@groupname\empty%
      \setlength{\kitfootergroupwidth}{0mm}%
      \else%
      \setlength{\kitfootergroupwidth}{50mm}%
    \fi%
  \else
      \setlength{\kitfootergroupwidth}{0mm}%
  \fi
  \usebeamerfont{footer}%
  \ifsectionnavigation%
    % Option "navbarinline"
    \ifnavbarinline%
      \begin{beamercolorbox}[wd=\paperwidth, leftskip=2mm, rightskip=2mm]{}
        \insertnavigation{\dimexpr\paperwidth-4mm\relax}
        \vspace{1mm}
      \end{beamercolorbox}%
    \fi%
    % Option "navbarinfooter"
    \ifnavbarinfoot%
      % Punkte für Subsections deaktivieren
      \setbeamertemplate{mini frames}{}%
      \begin{beamercolorbox}[wd=\paperwidth, leftskip=1mm, rightskip=1mm]{}%
        \insertsectionnavigationhorizontal{\dimexpr\paperwidth-\kitoutermargin\relax}{}{}
      \end{beamercolorbox}%
    \fi%
  \fi%
  \leavevmode%
  \begin{beamercolorbox}[wd=13mm, ht=\kitbottomheight, dp=\kitbottomdepth, leftskip=4mm]{}
      \usebeamerfont{page number in head/foot}%
      \strut\insertframenumber{}/\inserttotalframenumber%
  \end{beamercolorbox}%
  \begin{beamercolorbox}[wd=20mm, ht=\kitbottomheight, dp=\kitbottomdepth]{}
      \usebeamerfont{date in head/foot}%
      \strut\insertshortdate%
  \end{beamercolorbox}%
  \begin{beamercolorbox}[wd=\dimexpr\paperwidth-37mm-\kitfootergroupwidth, ht=\kitbottomheight, dp=\kitbottomdepth]{}%
      \beamer@shortauthor\ifx\beamer@shortauthor\empty\else: \fi\beamer@shorttitle%
  \end{beamercolorbox}%
  \ifdefined\@groupname%
  \begin{beamercolorbox}[wd=\kitfootergroupwidth, ht=\kitbottomheight, dp=\kitbottomdepth, rightskip=\kitinnermargin]{}
    \raggedleft\@groupname
  \end{beamercolorbox}%
  \fi% 
}

%% Option "navbarside"
\ifnavbarside
\useoutertheme[height=0cm,width=3.5cm,left]{sidebar}

\setbeamerfont{title in sidebar}{family=\sffamily,series=\mdseries,size={\fontsize{10pt}{11pt}}}
\setbeamerfont{section in sidebar}{family=\sffamily,series=\mdseries,size={\fontsize{9pt}{9.9pt}}}
\setbeamerfont{subsection in sidebar}{family=\sffamily,series=\mdseries,size={\fontsize{8pt}{8.8pt}}}

\setbeamertemplate{sidebar \beamer@sidebarside}
  {\vskip1.5cm%
   \hskip6.5mm%
   \advance\beamer@sidebarwidth by -5mm%
   \insertverticalnavigation{\beamer@sidebarwidth}%
  }%
\fi

%% Hintergrund
\usebackgroundtemplate{
  % Trennlinie nicht bei "plain"-Frames
  \ifbeamer@plainframe\else\kitseparationline\fi
}

% Trennlinie
\newcommand{\kitseparationline}{
  \begin{pgfpicture}{0mm}{0mm}{\paperwidth}{\paperheight}
    \pgfsetstrokecolor{black!15} 
    \pgfsetlinewidth{.5pt}
    \pgfpathmoveto{\pgfpoint{\kitoutermargin}{\kitinnermargin}}
    \pgfpathlineto{\pgfpoint{\paperwidth-\kitoutermargin}{\kitinnermargin}}
    \pgfusepath{stroke} 
  \end{pgfpicture}%
}


%% --------------
%% | Titelseite |
%% --------------

\def\titleimage#1{\def\@titleimage{#1}}
\def\grouplogo#1{\def\@grouplogo{#1}}

\newcommand{\KITtitleframe}{
  \begin{frame}[plain]
  \titlepage
  \end{frame}
}

\setbeamertemplate{title page}{
  % From textpos documentation (https://ctan.org/pkg/textpos)
  %
  % \begin{textblock}{<hsize>}[<ho>,<vo>](<hpos>,<vpos>)
  %   The coordinates <ho> and <vo> are fractions of the width and height of the text
  %   box, respectively, and state that the box is to be placed so that the reference point
  %   (<ho>,<vo>) within the box is to be placed at the point (<hpos>,<vpos>) on the page.

  % KIT-Logo
  \begin{textblock*}{30mm}(\kitinnermargin,6.7mm)
  \includegraphics[width=30mm]{logos/\@kitlogo} 
  \end{textblock*}
  
  % Gruppenlogo
  \ifdefined\@grouplogo
    \ifx\@grouplogo\empty \else
      \begin{textblock*}{20mm}(\dimexpr\paperwidth-24mm\relax,6.7mm)
      \includegraphics[width=20mm,height=20mm,keepaspectratio]{logos/\@grouplogo} 
      \end{textblock*}
    \fi % falls \grouplogo{} aufgerufen wird, kein Gruppenlogo einbinden
    \else
      \begin{textblock*}{20mm}(\dimexpr\paperwidth-24mm\relax,6.7mm)
      \colorbox{kit-purple100!20}{\parbox[t][12mm][c]{19mm}{\color{kit-purple100}\scriptsize\centering 
        \ifgerman
        Bitte Logo über \texttt{\textbackslash grouplogo\{\}} festlegen.
        \else
        Please set a logo using \texttt{\textbackslash grouplogo\{\}}.
        \fi
        }}
      \end{textblock*}
  \fi 
  
  % Titel
  \begin{textblock*}{\dimexpr\paperwidth-8mm\relax}[0,.5](\kitinnermargin,28mm)
  \usebeamerfont*{title}\inserttitle
  \end{textblock*}
  
  % Untertitel
  \begin{textblock*}{\dimexpr\paperwidth-8mm\relax}(\kitinnermargin,36mm)
  \small\textbf{\insertsubtitle}
  \end{textblock*}
  
  % Autor
  \begin{textblock*}{\dimexpr\paperwidth-8mm\relax}(\kitinnermargin,41mm)
  \small\insertauthor~\textbar~\insertdate
  \end{textblock*}

  % Titelbild
  \newlength{\kittitleimageheight}
  \setlength{\kittitleimageheight}{40mm}
  \begin{textblock*}{\paperwidth}(\kitoutermargin,\dimexpr\paperheight-\kitbottommargin-\kittitleimageheight)
  \begin{pgfpicture}{0mm}{0mm}{\paperwidth}{\kittitleimageheight}
    % Clipping-Pfad um titelbild
    \pgfsetstrokecolor{black!15} 
    \pgfsetlinewidth{1pt}
    \pgfsetcornersarced{\pgfpoint{3mm}{3mm}}
    \pgfpathmoveto{\pgfpoint{\paperwidth-2\kitoutermargin}{0mm}}
    \pgfpathlineto{\pgfpoint{\paperwidth-2\kitoutermargin}{\kittitleimageheight}}
    \pgfsetcornersarced{\pgfpointorigin}
    \pgfpathlineto{\pgfpoint{0mm}{\kittitleimageheight}}
    \pgfsetcornersarced{\pgfpoint{3mm}{3mm}}
    \pgfpathlineto{\pgfpointorigin}
    \pgfsetcornersarced{\pgfpointorigin}
    \pgfpathclose
    \pgfusepath{stroke,clip} 
    
    % Titelbild
    \ifdefined\@titleimage
      \ifx\@titleimage\empty \else%
        \pgftext[at=\pgfpoint{.5\paperwidth}{0mm},center,bottom]{%
          \includegraphics[height=40mm]{logos/\@titleimage}
        }
        \fi % Bei Aufruf von \titleimage{} leeren Rahmen anzeigen.
      \else 
        \pgftext[at=\pgfpoint{.5\paperwidth}{.5\kittitleimageheight},center,base]{%
          \colorbox{kit-purple100!20}{\parbox[c][\kittitleimageheight][c]{\paperwidth}{\color{kit-purple100}\centering Bitte Titelbild über \texttt{\textbackslash titleimage\{\}} festlegen.
          }}%
        }
    \fi
    

  \end{pgfpicture}%
  \end{textblock*}

  
  % KIT slogan
  \begin{textblock*}{80mm}[0,.5](\kitoutermargin,\dimexpr\paperheight-.5\kitbottommargin)
      \fontsize{5.5pt}{5.5pt}\selectfont\@kitslogan
  \end{textblock*}
  
  \begin{textblock*}{30mm}[1,.5](\dimexpr\paperwidth-\kitoutermargin\relax,\dimexpr\paperheight-.5\kitbottommargin)
      \fontsize{11pt}{11pt}\selectfont\bfseries\raggedleft%
      {\href{https://www.kit.edu}{www.kit.edu}}
  \end{textblock*}
  
}
%% ---------------
%% | /Titelseite |
%% ---------------

%% ----------
%% | Farben |
%% ----------
%% KIT-Farbschema

% KIT color  green :
\definecolor{kit-green}{RGB}{0, 150, 130}
\definecolor{kit-green100}{RGB}{0, 150, 130}
\definecolor{kit-green90}{rgb}{0.1, 0.6294, 0.5588}
\definecolor{kit-green80}{rgb}{0.2, 0.6706, 0.6078}
\definecolor{kit-green75}{rgb}{0.25, 0.6912, 0.6324}
\definecolor{kit-green70}{rgb}{0.3, 0.7118, 0.6569}
\definecolor{kit-green60}{rgb}{0.4, 0.7529, 0.7059}
\definecolor{kit-green50}{rgb}{0.5, 0.7941, 0.7549}
\definecolor{kit-green40}{rgb}{0.6, 0.8353, 0.8039}
\definecolor{kit-green30}{rgb}{0.7, 0.8765, 0.8529}
\definecolor{kit-green25}{rgb}{0.75, 0.8971, 0.8775}
\definecolor{kit-green20}{rgb}{0.8, 0.9176, 0.902}
\definecolor{kit-green15}{rgb}{0.85, 0.9382, 0.9265}
\definecolor{kit-green10}{rgb}{0.9, 0.9588, 0.951}
\definecolor{kit-green5}{rgb}{0.95, 0.9794, 0.9755}

% KIT color blue:
\definecolor{kit-blue}{RGB}{70, 100, 170}
\definecolor{kit-blue100}{RGB}{70, 100, 170}
\definecolor{kit-blue90}{rgb}{0.3471, 0.4529, 0.7}
\definecolor{kit-blue80}{rgb}{0.4196, 0.5137, 0.7333}
\definecolor{kit-blue75}{rgb}{0.4559, 0.5441, 0.75}
\definecolor{kit-blue70}{rgb}{0.4922, 0.5745, 0.7667}
\definecolor{kit-blue60}{rgb}{0.5647, 0.6353, 0.8}
\definecolor{kit-blue50}{rgb}{0.6373, 0.6961, 0.8333}
\definecolor{kit-blue40}{rgb}{0.7098, 0.7569, 0.8667}
\definecolor{kit-blue30}{rgb}{0.7824, 0.8176, 0.9}
\definecolor{kit-blue25}{rgb}{0.8186, 0.848, 0.9167}
\definecolor{kit-blue20}{rgb}{0.8549, 0.8784, 0.9333}
\definecolor{kit-blue15}{rgb}{0.8912, 0.9088, 0.95}
\definecolor{kit-blue10}{rgb}{0.9275, 0.9392, 0.9667}
\definecolor{kit-blue5}{rgb}{0.9637, 0.9696, 0.9833}

% KIT color  red :
\definecolor{kit-red}{RGB}{162, 34, 35}
\definecolor{kit-red100}{RGB}{162, 34, 35}
\definecolor{kit-red90}{rgb}{0.6718, 0.22, 0.2235}
\definecolor{kit-red80}{rgb}{0.7082, 0.3067, 0.3098}
\definecolor{kit-red75}{rgb}{0.7265, 0.35, 0.3529}
\definecolor{kit-red70}{rgb}{0.7447, 0.3933, 0.3961}
\definecolor{kit-red60}{rgb}{0.7812, 0.48, 0.4824}
\definecolor{kit-red50}{rgb}{0.8176, 0.5667, 0.5686}
\definecolor{kit-red40}{rgb}{0.8541, 0.6533, 0.6549}
\definecolor{kit-red30}{rgb}{0.8906, 0.74, 0.7412}
\definecolor{kit-red25}{rgb}{0.9088, 0.7833, 0.7843}
\definecolor{kit-red20}{rgb}{0.9271, 0.8267, 0.8275}
\definecolor{kit-red15}{rgb}{0.9453, 0.87, 0.8706}
\definecolor{kit-red10}{rgb}{0.9635, 0.9133, 0.9137}
\definecolor{kit-red5}{rgb}{0.9818, 0.9567, 0.9569}

% KIT color  yellow :
\definecolor{kit-yellow}{RGB}{252, 229, 0}
\definecolor{kit-yellow100}{RGB}{252, 229, 0}
\definecolor{kit-yellow90}{rgb}{0.9894, 0.9082, 0.1}
\definecolor{kit-yellow80}{rgb}{0.9906, 0.9184, 0.2}
\definecolor{kit-yellow75}{rgb}{0.9912, 0.9235, 0.25}
\definecolor{kit-yellow70}{rgb}{0.9918, 0.9286, 0.3}
\definecolor{kit-yellow60}{rgb}{0.9929, 0.9388, 0.4}
\definecolor{kit-yellow50}{rgb}{0.9941, 0.949, 0.5}
\definecolor{kit-yellow40}{rgb}{0.9953, 0.9592, 0.6}
\definecolor{kit-yellow30}{rgb}{0.9965, 0.9694, 0.7}
\definecolor{kit-yellow25}{rgb}{0.9971, 0.9745, 0.75}
\definecolor{kit-yellow20}{rgb}{0.9976, 0.9796, 0.8}
\definecolor{kit-yellow15}{rgb}{0.9982, 0.9847, 0.85}
\definecolor{kit-yellow10}{rgb}{0.9988, 0.9898, 0.9}
\definecolor{kit-yellow5}{rgb}{0.9994, 0.9949, 0.95}

% KIT color  orange :
\definecolor{kit-orange}{RGB}{223, 155, 27}
\definecolor{kit-orange100}{RGB}{223, 155, 27}
\definecolor{kit-orange90}{rgb}{0.8871, 0.6471, 0.1953}
\definecolor{kit-orange80}{rgb}{0.8996, 0.6863, 0.2847}
\definecolor{kit-orange75}{rgb}{0.9059, 0.7059, 0.3294}
\definecolor{kit-orange70}{rgb}{0.9122, 0.7255, 0.3741}
\definecolor{kit-orange60}{rgb}{0.9247, 0.7647, 0.4635}
\definecolor{kit-orange50}{rgb}{0.9373, 0.8039, 0.5529}
\definecolor{kit-orange40}{rgb}{0.9498, 0.8431, 0.6424}
\definecolor{kit-orange30}{rgb}{0.9624, 0.8824, 0.7318}
\definecolor{kit-orange25}{rgb}{0.9686, 0.902, 0.7765}
\definecolor{kit-orange20}{rgb}{0.9749, 0.9216, 0.8212}
\definecolor{kit-orange15}{rgb}{0.9812, 0.9412, 0.8659}
\definecolor{kit-orange10}{rgb}{0.9875, 0.9608, 0.9106}
\definecolor{kit-orange5}{rgb}{0.9937, 0.9804, 0.9553}

% KIT color  lightgreen :
\definecolor{kit-lightgreen}{RGB}{140, 182, 60}
\definecolor{kit-lightgreen100}{RGB}{140, 182, 60}
\definecolor{kit-lightgreen90}{rgb}{0.5941, 0.7424, 0.3118}
\definecolor{kit-lightgreen80}{rgb}{0.6392, 0.771, 0.3882}
\definecolor{kit-lightgreen75}{rgb}{0.6618, 0.7853, 0.4265}
\definecolor{kit-lightgreen70}{rgb}{0.6843, 0.7996, 0.4647}
\definecolor{kit-lightgreen60}{rgb}{0.7294, 0.8282, 0.5412}
\definecolor{kit-lightgreen50}{rgb}{0.7745, 0.8569, 0.6176}
\definecolor{kit-lightgreen40}{rgb}{0.8196, 0.8855, 0.6941}
\definecolor{kit-lightgreen30}{rgb}{0.8647, 0.9141, 0.7706}
\definecolor{kit-lightgreen25}{rgb}{0.8873, 0.9284, 0.8088}
\definecolor{kit-lightgreen20}{rgb}{0.9098, 0.9427, 0.8471}
\definecolor{kit-lightgreen15}{rgb}{0.9324, 0.9571, 0.8853}
\definecolor{kit-lightgreen10}{rgb}{0.9549, 0.9714, 0.9235}
\definecolor{kit-lightgreen5}{rgb}{0.9775, 0.9857, 0.9618}


% KIT color  purple :
\definecolor{kit-purple}{RGB}{163, 16, 124}
\definecolor{kit-purple100}{RGB}{163, 16, 124}
\definecolor{kit-purple90}{rgb}{0.6753, 0.1565, 0.5376}
\definecolor{kit-purple80}{rgb}{0.7114, 0.2502, 0.589}
\definecolor{kit-purple75}{rgb}{0.7294, 0.2971, 0.6147}
\definecolor{kit-purple70}{rgb}{0.7475, 0.3439, 0.6404}
\definecolor{kit-purple60}{rgb}{0.7835, 0.4376, 0.6918}
\definecolor{kit-purple50}{rgb}{0.8196, 0.5314, 0.7431}
\definecolor{kit-purple40}{rgb}{0.8557, 0.6251, 0.7945}
\definecolor{kit-purple30}{rgb}{0.8918, 0.7188, 0.8459}
\definecolor{kit-purple25}{rgb}{0.9098, 0.7657, 0.8716}
\definecolor{kit-purple20}{rgb}{0.9278, 0.8125, 0.8973}
\definecolor{kit-purple15}{rgb}{0.9459, 0.8594, 0.9229}
\definecolor{kit-purple10}{rgb}{0.9639, 0.9063, 0.9486}
\definecolor{kit-purple5}{rgb}{0.982, 0.9531, 0.9743}

% KIT color  brown :
\definecolor{kit-brown}{RGB}{167, 130, 46}
\definecolor{kit-brown100}{RGB}{167, 130, 46}
\definecolor{kit-brown90}{rgb}{0.6894, 0.5588, 0.2624}
\definecolor{kit-brown80}{rgb}{0.7239, 0.6078, 0.3443}
\definecolor{kit-brown75}{rgb}{0.7412, 0.6324, 0.3853}
\definecolor{kit-brown70}{rgb}{0.7584, 0.6569, 0.4263}
\definecolor{kit-brown60}{rgb}{0.7929, 0.7059, 0.5082}
\definecolor{kit-brown50}{rgb}{0.8275, 0.7549, 0.5902}
\definecolor{kit-brown40}{rgb}{0.862, 0.8039, 0.6722}
\definecolor{kit-brown30}{rgb}{0.8965, 0.8529, 0.7541}
\definecolor{kit-brown25}{rgb}{0.9137, 0.8775, 0.7951}
\definecolor{kit-brown20}{rgb}{0.931, 0.902, 0.8361}
\definecolor{kit-brown15}{rgb}{0.9482, 0.9265, 0.8771}
\definecolor{kit-brown10}{rgb}{0.9655, 0.951, 0.918}
\definecolor{kit-brown5}{rgb}{0.9827, 0.9755, 0.959}

% KIT color  cyan :
\definecolor{kit-cyan}{RGB}{35, 161, 224}
\definecolor{kit-cyan100}{RGB}{35, 161, 224}
\definecolor{kit-cyan90}{rgb}{0.2235, 0.6682, 0.8906}
\definecolor{kit-cyan80}{rgb}{0.3098, 0.7051, 0.9027}
\definecolor{kit-cyan75}{rgb}{0.3529, 0.7235, 0.9088}
\definecolor{kit-cyan70}{rgb}{0.3961, 0.742, 0.9149}
\definecolor{kit-cyan60}{rgb}{0.4824, 0.7788, 0.9271}
\definecolor{kit-cyan50}{rgb}{0.5686, 0.8157, 0.9392}
\definecolor{kit-cyan40}{rgb}{0.6549, 0.8525, 0.9514}
\definecolor{kit-cyan30}{rgb}{0.7412, 0.8894, 0.9635}
\definecolor{kit-cyan25}{rgb}{0.7843, 0.9078, 0.9696}
\definecolor{kit-cyan20}{rgb}{0.8275, 0.9263, 0.9757}
\definecolor{kit-cyan15}{rgb}{0.8706, 0.9447, 0.9818}
\definecolor{kit-cyan10}{rgb}{0.9137, 0.9631, 0.9878}
\definecolor{kit-cyan5}{rgb}{0.9569, 0.9816, 0.9939}

% KIT color  gray :
\definecolor{kit-gray}{RGB}{0, 0, 0}
\definecolor{kit-gray100}{RGB}{0, 0, 0}
\definecolor{kit-gray90}{rgb}{0.1, 0.1, 0.1}
\definecolor{kit-gray80}{rgb}{0.2, 0.2, 0.2}
\definecolor{kit-gray75}{rgb}{0.25, 0.25, 0.25}
\definecolor{kit-gray70}{rgb}{0.3, 0.3, 0.3}
\definecolor{kit-gray60}{rgb}{0.4, 0.4, 0.4}
\definecolor{kit-gray50}{rgb}{0.5, 0.5, 0.5}
\definecolor{kit-gray40}{rgb}{0.6, 0.6, 0.6}
\definecolor{kit-gray30}{rgb}{0.7, 0.7, 0.7}
\definecolor{kit-gray25}{rgb}{0.75, 0.75, 0.75}
\definecolor{kit-gray20}{rgb}{0.8, 0.8, 0.8}
\definecolor{kit-gray15}{rgb}{0.85, 0.85, 0.85}
\definecolor{kit-gray10}{rgb}{0.9, 0.9, 0.9}
\definecolor{kit-gray5}{rgb}{0.95, 0.95, 0.95}



\setbeamercolor*{normal text}{fg=black}
\setbeamercolor*{alerted text}{fg=kit-red100}
\setbeamercolor*{example text}{fg=black}
\setbeamercolor*{structure}{fg=black}

\setbeamercolor*{palette primary}{fg=black,bg=black!15}
\setbeamercolor*{palette secondary}{fg=black,bg=black!15}
\setbeamercolor*{palette tertiary}{fg=black,bg=black!15}
\setbeamercolor*{palette quaternary}{fg=black,bg=black!15}

\setbeamercolor*{palette sidebar primary}{fg=black!75}
\setbeamercolor*{palette sidebar secondary}{fg=black!75}
\setbeamercolor*{palette sidebar tertiary}{fg=black!75}
\setbeamercolor*{palette sidebar quaternary}{fg=black!75}

\setbeamercolor*{item projected}{fg=white,bg=kit-green100}

\setbeamercolor*{block title}{fg=white,bg=kit-green100}
\setbeamercolor*{block title alerted}{use=alerted text,fg=white,bg=alerted text.fg!75!black}
\setbeamercolor*{block title example}{fg=white,bg=kit-blue100}

\setbeamercolor*{block body}{fg=black,bg=kit-green15}
\setbeamercolor*{block body alerted}{parent=normal text,use=block title alerted,bg=block title alerted.bg!10!bg}
\setbeamercolor*{block body example}{fg=black,bg=kit-blue15}

\setbeamercolor*{separation line}{}
\setbeamercolor*{fine separation line}{}

\setbeamercolor*{background canvas}{bg=white}

%% -----------
%% | /Farben |
%% -----------

%% -----------------------------------
%% | halbgerundete Aufzählungspunkte |
%% -----------------------------------

% KIT-Aufzählungszeichen
\newcommand{\KITmark}{%
	\begin{pgfpicture}{0mm}{0mm}{1ex}{1ex}
		{\pgfsetcornersarced{\pgfpoint{.3ex}{.3ex}} 
			\pgfpathmoveto{\pgfpoint{0cm}{1ex}} 
			\pgfpathlineto{\pgfpoint{1ex}{1ex}}
			\pgfpathlineto{\pgfpoint{1ex}{0cm}}}
		{\pgfsetcornersarced{\pgfpoint{.3ex}{.3ex}}
			\pgfpathmoveto{\pgfpoint{1ex}{0cm}}
			\pgfpathlineto{\pgfpointorigin}
			\pgfpathlineto{\pgfpoint{0cm}{1ex}}}
		\color{kit-green100}
		\pgfusepath{fill}
	\end{pgfpicture}%
}

\setbeamertemplate{itemize items}{\raisebox{.2ex}{\KITmark}}

%% ----------------------
%% | Inhaltsverzeichnis |
%% ----------------------

\setbeamertemplate{section in toc}{\normalsize\textbf{\textcolor{kit-blue}{\inserttocsectionnumber.~\inserttocsection}}\par}
\setbeamertemplate{subsection in toc}{\small\hspace{1.2em}\raisebox{.2ex}{\KITmark}\hspace{\labelsep}\inserttocsubsection\par}

%% ------------------------------
%% | halbgerundete Beamer-Boxen |
%% ------------------------------

\renewcommand\beamerboxesrounded[2][]{%
  \global\let\beamer@firstlineitemizeunskip=\relax%
  \vbox\bgroup%
  \setkeys{beamerboxes}{upper=block title,lower=block body,width=\textwidth,shadow=false}%
  \setkeys{beamerboxes}{#1}%
  {%
    \usebeamercolor{\bmb@lower}%
    \globalcolorstrue%
    \colorlet{lower.bg}{bg}%
  }%
  {%
    \usebeamercolor{\bmb@upper}%
    \globalcolorstrue%
    \colorlet{upper.bg}{bg}%
  }%
  %
  % Typeset head
  %
  \vskip4bp
  \setbox\bmb@box=\hbox{%
    \begin{minipage}[b]{\bmb@width}%
      \usebeamercolor[fg]{\bmb@upper}%
      #2%
    \end{minipage}}%
  \ifdim\wd\bmb@box=0pt%
    \setbox\bmb@box=\hbox{}%
    \ht\bmb@box=1.5pt%
    \bmb@prevheight=-4.5pt%
  \else%
    \wd\bmb@box=\bmb@width%
    \bmb@temp=\dp\bmb@box%
    \ifdim\bmb@temp<1.5pt%
      \bmb@temp=1.5pt%
    \fi%
    \setbox\bmb@box=\hbox{\raise\bmb@temp\hbox{\box\bmb@box}}%
    \dp\bmb@box=0pt%
    \bmb@prevheight=\ht\bmb@box%
  \fi%
  \bmb@temp=\bmb@width%
  \bmb@dima=\bmb@temp\advance\bmb@dima by2.2bp%
  \bmb@dimb=\bmb@temp\advance\bmb@dimb by4bp%
  \hbox{%
    \begin{pgfpicture}{0bp}{+-\ht\bmb@box}{0bp}{+-\ht\bmb@box}
      \ifdim\wd\bmb@box=0pt%
        \color{lower.bg}%
      \else%        
        \color{upper.bg}%
      \fi%  
      \pgfpathqmoveto{-4bp}{-1bp}
      % Adaption for "KIT-Design"
      \pgfpathlineto{\pgfpoint{-4bp}{3bp}}
      %\pgfpathqcurveto{-4bp}{1.2bp}{-2.2bp}{3bp}{0bp}{3bp}
      \pgfpathlineto{\pgfpoint{\bmb@temp}{3bp}}
      \pgfpathcurveto%
      {\pgfpoint{\bmb@dima}{3bp}}%
      {\pgfpoint{\bmb@dimb}{1.2bp}}%
      {\pgfpoint{\bmb@dimb}{-1bp}}%
      \bmb@dima=-\ht\bmb@box%
      \advance\bmb@dima by-2pt%
      \pgfpathlineto{\pgfpoint{\bmb@dimb}{\bmb@dima}}
      \pgfpathlineto{\pgfpoint{-4bp}{\bmb@dima}}
      \pgfusepath{fill}
    \end{pgfpicture}%
    \copy\bmb@box%
  }%
  \nointerlineskip%
  \vskip-1pt%
  \ifdim\wd\bmb@box=0pt%
  \else%
  \hbox{%
    \begin{pgfpicture}{0pt}{0pt}{\bmb@width}{6pt}
      \bmb@dima=\bmb@width%
      \advance\bmb@dima by8bp%
      \pgfpathrectangle{\pgfpoint{-4bp}{-1bp}}{\pgfpoint{\bmb@dima}{8bp}}
      \pgfusepath{clip}
      {\pgftransformshift{\pgfpoint{-4bp}{0bp}}\pgftext[left,base]{\pgfuseshading{bmb@transition}}}%
    \end{pgfpicture}%
  }%
  \nointerlineskip%
  \vskip-0.5pt%
  \fi%
  \ifbmb@shadow%
    \setbox\bmb@boxshadow=\hbox{\pgfuseshading{bmb@shadow}}%
    \setbox\bmb@boxshadowball=\hbox{\pgfuseshading{bmb@shadowball}}%
    \setbox\bmb@boxshadowballlarge=\hbox{\pgfuseshading{bmb@shadowballlarge}}%
  \fi%
  \setbox\bmb@colorbox=\hbox{{\pgfpicturetrue\pgfsetcolor{lower.bg}}}%
  \setbox\bmb@box=\hbox\bgroup\begin{minipage}[b]{\bmb@width}%
    \vskip2pt%
    \usebeamercolor[fg]{\bmb@lower}%
    \colorlet{beamerstructure}{upper.bg}%
    \colorlet{structure}{upper.bg}%
    %\color{.}%
  }

\def\endbeamerboxesrounded{%
  \end{minipage}\egroup%
  \wd\bmb@box=\bmb@width%
  \bmb@temp=\dp\bmb@box%
  \advance\bmb@temp by.5pt%
  \setbox\bmb@box=\hbox{\raise\bmb@temp\hbox{\box\bmb@box}}%
  \dp\bmb@box=0pt%
  \bmb@temp=\wd\bmb@box%
  \bmb@dima=\bmb@temp\advance\bmb@dima by2.2bp%
  \bmb@dimb=\bmb@temp\advance\bmb@dimb by4bp%
  \hbox{%
    \begin{pgfpicture}{0bp}{0bp}{0bp}{0bp}
      \ifbmb@shadow%
      {\pgftransformshift{\pgfpoint{4bp}{-3bp}}\pgftext{\copy\bmb@boxshadowball}}
      \begin{pgfscope}
        {%
        \advance\bmb@temp by-1bp%
        \pgfpathrectangle{\pgfpoint{\bmb@temp}{-7bp}}{\pgfpoint{9bp}{9bp}}%
        \pgfusepath{clip}
        }%
        {\pgftransformshift{\pgfpoint{\bmb@temp}{1bp}}\pgftext{\box\bmb@boxshadowballlarge}}
      \end{pgfscope}
      \begin{pgfscope}
        \advance\bmb@temp by-4bp%
        \pgfpathrectangle{\pgfpoint{4bp}{-7bp}}{\pgfpoint{\bmb@temp}{5bp}}
        \pgfusepath{clip}
        {\pgftransformshift{\pgfpoint{4bp}{-7bp}}\pgftext[left,base]{\copy\bmb@boxshadow}}%
      \end{pgfscope}
      \begin{pgfscope}
        \advance\bmb@temp by 4bp%
        \bmb@dima=\ht\bmb@box%
        \advance\bmb@dima by\bmb@prevheight%
        \advance\bmb@dima by 4bp%
        \pgfpathrectangle{\pgfpoint{\bmb@temp}{1bp}}{\pgfpoint{4bp}{\bmb@dima}}
        \pgfusepath{clip}
        \advance\bmb@dima by-4bp%
        {\pgftransformshift{\pgfpoint{\bmb@temp}{\bmb@dima}}\pgftext{\box\bmb@boxshadowball}}
        \advance\bmb@dima by-1bp%
        \pgfpathrectangle{\pgfpoint{\bmb@temp}{1bp}}{\pgfpoint{4bp}{\bmb@dima}}
        \pgfusepath{clip}
        \advance\bmb@temp by4bp%
        {\pgftransformshift{\pgfpoint{\bmb@temp}{-3bp}}%
          \pgftransformrotate{90}%
          \pgftext[left,base]{\box\bmb@boxshadow}}%
      \end{pgfscope}
      \fi%
      \unhbox\bmb@colorbox%
      \pgfpathqmoveto{-4bp}{1bp}
      \pgfpathqcurveto{-4bp}{-1.2bp}{-2.2bp}{-3bp}{0bp}{-3bp}
      \pgfpathlineto{\pgfpoint{\the\bmb@dimb}{-3bp}}
      {
      \bmb@dima=\ht\bmb@box%
      \pgfpathlineto{\pgfpoint{\bmb@dimb}{\bmb@dima}}
      \pgfpathlineto{\pgfpoint{-4bp}{\bmb@dima}}
      \pgfusepath{fill}
      }
      \ifbmb@shadow%
      {
        \color{black!50!bg}
        \pgfsetlinewidth{0pt}
        \pgfpathmoveto{\pgfpoint{\bmb@dimb}{-.5bp}}
        \bmb@dima=\ht\bmb@box%
        \advance\bmb@dima by\bmb@prevheight%
        \advance\bmb@dima by 1bp%
        \pgfpathlineto{\pgfpoint{\bmb@dimb}{\bmb@dima}}
        \pgfusepath{stroke}
        \bmb@temp=\bmb@dima
        \advance\bmb@dima by 1bp%
        \color{black!31!bg}
        \pgfpathmoveto{\pgfpoint{\bmb@dimb}{\bmb@temp}}
        \pgfpathlineto{\pgfpoint{\bmb@dimb}{\bmb@dima}}
        \pgfusepath{stroke}
        \advance\bmb@dima by 1bp%
        \advance\bmb@temp by 1bp%
        \color{black!19!bg}
        \pgfpathmoveto{\pgfpoint{\bmb@dimb}{\bmb@temp}}
        \pgfpathlineto{\pgfpoint{\bmb@dimb}{\bmb@dima}}
        \pgfusepath{stroke}
        \advance\bmb@dima by 1bp%
        \advance\bmb@temp by 1bp%
        \color{black!6!bg}
        \pgfpathmoveto{\pgfpoint{\bmb@dimb}{\bmb@temp}}
        \pgfpathlineto{\pgfpoint{\bmb@dimb}{\bmb@dima}}
        \pgfusepath{stroke}
        \advance\bmb@dima by 1.5bp%
        \advance\bmb@temp by 1bp%
        \color{bg}
        \pgfpathmoveto{\pgfpoint{\bmb@dimb}{\bmb@temp}}
        \pgfpathlineto{\pgfpoint{\bmb@dimb}{\bmb@dima}}
        \pgfusepath{stroke}
      }
      \fi
    \end{pgfpicture}%
    \box\bmb@box%
  }%
  \ifbmb@shadow%
    \vskip4bp minus 2bp%
  \else%
    \vskip2bp%
  \fi%
  \egroup% of \vbox\bgroup
}


%% -------------------------------
%% | /halbgerundete Beamer-Boxen |
%% -------------------------------


%% ----------------------
%% | Block-Definitionen |
%% ----------------------

% Content environment for structuring. Basically a headline followed by text
\newenvironment<>{contentblock}[1]{\begingroup%
  \setbeamertemplate{blocks}[default]
	\setbeamercolor{block body}{fg=black,bg=}%
  \setbeamercolor{block title}{fg=black,bg=}%
  \setbeamerfont*{block title}{family=\sffamily,series=\bfseries,size=\large}
	\begin{block}#2{#1}%
	}{\end{block}%
\endgroup}


\newenvironment<>{greenblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-green15}%
	\setbeamercolor{block title}{fg=white,bg=kit-green100}%
	\begin{block}#2{#1}%
	}{\end{block}
\endgroup}

\newenvironment<>{blueblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-blue15}%
	\setbeamercolor{block title}{fg=white,bg=kit-blue100}%
	\begin{block}#2{#1}%
	}{\end{block}
\endgroup}

\newenvironment<>{redblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-red15}%
	\setbeamercolor{block title}{fg=white,bg=kit-red100}%
	\begin{block}#2{#1}%
	}{\end{block}%
\endgroup}

\newenvironment<>{brownblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-brown15}%
	\setbeamercolor{block title}{fg=white,bg=kit-brown100}%
	\begin{block}#2{#1}%
	}{\end{block}%
\endgroup}

\newenvironment<>{purpleblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-purple15}%
	\setbeamercolor{block title}{fg=white,bg=kit-purple100}%
	\begin{block}#2{#1}%
	}{\end{block}%
\endgroup}

\newenvironment<>{grayblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-gray15}%
	\setbeamercolor{block title}{fg=white,bg=kit-gray70}%
	\begin{block}#2{#1}%
	}{\end{block}%
\endgroup}

\newenvironment<>{yellowblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-yellow30}%
	\setbeamercolor{block title}{fg=black,bg=kit-yellow100}%
	\begin{block}#2{#1}%
	}{\end{block}%
\endgroup}

\newenvironment<>{lightgreenblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-lightgreen15}%
	\setbeamercolor{block title}{fg=white,bg=kit-lightgreen100}%
	\begin{block}#2{#1}%
	}{\end{block}%
\endgroup}

\newenvironment<>{orangeblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-orange15}%
	\setbeamercolor{block title}{fg=white,bg=kit-orange100}%
	\begin{block}#2{#1}%
	}{\end{block}%
\endgroup}

\newenvironment<>{cyanblock}[1]{\begingroup%
	\setbeamercolor{block body}{fg=black,bg=kit-cyan15}%
	\setbeamercolor{block title}{fg=white,bg=kit-cyan100}%
	\begin{block}#2{#1}%
	}{\end{block}%
\endgroup}
%% ------------------------------
%% | /Block-Definitionen |
%% ------------------------------

%% use this for setting the total page number
\newcommand{\beginbackup}{
   \newcounter{framenumbervorappendix}
   \setcounter{framenumbervorappendix}{\value{framenumber}}
}
\newcommand{\backupend}{
   \addtocounter{framenumbervorappendix}{-\value{framenumber}}
   \addtocounter{framenumber}{\value{framenumbervorappendix}} 
}
