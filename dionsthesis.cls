%%
%% Dion's LaTeX Thesis Class
%% heavily based on UiO Thesis and somewhat on classicthesis.
%%

\ProvidesClass{dionsthesis}
\NeedsTeXFormat{LaTeX2e}

\RequirePackage{ifthen}
\RequirePackage{xkeyval}

\newboolean{@minionpro}
\def\@maincolor{}

\DeclareOptionX{minionpro}[false]{\setboolean{@minionpro}{#1}}
\DeclareOptionX{maincolor}[CD2A3D]{\def\@maincolor{#1}}

% Pass unused options to memoir class
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{memoir}}

\ExecuteOptionsX{}
\ProcessOptionsX\relax

\LoadClass{memoir}

%%
%% Fonts
%%

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{textcase}
\RequirePackage{etoolbox}
\RequirePackage{xparse}

\ifthenelse{\boolean{@minionpro}}{%
	\RequirePackage{MnSymbol}
	\RequirePackage[mathlf,footnotefigures]{MinionPro}
}{%
	\RequirePackage{libertine}
	\RequirePackage[libertine]{newtxmath}
	\useosf
}

\RequirePackage[osf]{FiraSans}

\DeclareRobustCommand{\sfcaps}[1]{{\scshape\sffamily\MakeTextLowercase{#1}}}
\DeclareRobustCommand{\spacedlowsmallcaps}[1]{\textls[40]{\sfcaps{#1}}}

\RequirePackage[scale=.85]{FiraMono}

\newfont{\chapnum}{eurb10 scaled 7000}

\RequirePackage[final,babel]{microtype}

% Creates a fourier ornament. Args: fontsize, lineheight, char
\RequirePackage{fourier-orns}
\newcommand*{\fourierOrnament}[3]{{%
		\fontencoding{U}\fontfamily{futs}\fontsize{#1}{#2}\selectfont\char#3}}


%%
%% Fixes
%%

\RequirePackage{memhfixc}
\RequirePackage{etex} % increase register size


%%
%% Variables
%%

% Internal variables
\newcommand{\@subtitle}{}
\newcommand{\@scm}{}

% Outside variables
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\scm}[1]{\renewcommand{\@scm}{#1}}


%%
%% Page layout
%%

\setlength{\parindent}{0pt}
\nonzeroparskip

\settypeblocksize{45\baselineskip}{28pc}{*}
\setlrmargins{*}{*}{2.2}
\setulmargins{*}{*}{1}
\setmarginnotes{1.75pc}{11.5pc}{\baselineskip}
\checkandfixthelayout

% No orphans
\clubpenalty = 5000
\widowpenalty = 10000


%%
%% Line breaking
%%

\RequirePackage{ragged2e}
\RequirePackage{hyphenat}


%%
%% Colors
%%

\RequirePackage[table]{xcolor}

\definecolor{largeornament}{gray}{0.85}
\definecolor{smallornament}{gray}{0.65}

\definecolor{halfgray}{gray}{0.55}
\definecolor{darkergray}{gray}{0.05}
\definecolor{highlight}{HTML}{\@maincolor}
\definecolor{greenish}{HTML}{008230}
\definecolor{blueish}{HTML}{0052A5}

\colorlet{chapnum}{halfgray}
\colorlet{parttitle}{highlight}
\colorlet{chaptitle}{highlight}
\colorlet{partnum}{black}
\colorlet{urlcolor}{black}
\colorlet{tocchapnum}{highlight}
\colorlet{citecolor}{black}
\colorlet{linkcolor}{black}
\colorlet{margincolor}{darkergray}


%%
%% Graphics
%%

\newsubfloat{figure}

\RequirePackage{graphicx}
\RequirePackage{import}

\RequirePackage{tikz}
\RequirePackage{tikz-3dplot}

%%
%% Math
%%

\RequirePackage{amsmath}
\RequirePackage{gensymb}
\RequirePackage{mathtools}
\RequirePackage{siunitx}
\sisetup{%
	mode=math,
	separate-uncertainty,
}

\RequirePackage[e]{esvect}
\let\oldvec\vec
\let\vec\vv

\renewcommand*{\memdskips}{
	\addtolength{\abovedisplayskip}{5pt}%
	\addtolength{\abovedisplayshortskip}{10pt}%
	\addtolength{\belowdisplayskip}{5pt}%
	\addtolength{\belowdisplayshortskip}{5pt}}

\def\shortunderbrace#1{\mathop{\vtop{\m@th\ialign{##\crcr
				$\hfil\displaystyle{#1}\hfil$\crcr
				\noalign{\kern3\p@\nointerlineskip}%
				\tiny\upbracefill\crcr\noalign{\kern3\p@}}}}\limits}

%%
%% Division styles
%%

\setsecnumdepth{subsection}

% Part style
\nopartblankpage
\renewcommand{\partnamefont}{\normalfont\LARGE}
\renewcommand{\partnumfont}{\LARGE\normalfont\MakeUppercase}
\renewcommand{\parttitlefont}{\color{parttitle}\huge\sffamily}
\renewcommand{\printpartname}{\begin{whole}\centering\partnamefont\partname}
\renewcommand{\printpartnum}{\partnumfont\thepart\end{whole}}
\renewcommand{\printparttitle}[1]{\begin{whole}\centering{\parttitlefont#1}\end{whole}}

% Chapter style
\newcommand{\chapfont}[1]{\color{chaptitle}\LARGE\sffamily#1}
\makechapterstyle{margin}{%
	\setlength{\beforechapskip}{0pt}
	\renewcommand{\printchaptername}{}
	\renewcommand{\chapternamenum}{}
	\renewcommand{\printchapternum}{%
		\marginpar{%
			\mpjustification\color{chapnum}\chapnum \thechapter
		}%
	}%
	\renewcommand{\afterchapternum}{}
	\renewcommand{\printchaptertitle}[1]{%
		\raggedright\chapfont{##1}
	}%
}

% Section style
\setsecheadstyle{\raggedright\large\spacedlowsmallcaps}
\setsecnumformat{\csname the#1\endcsname\quad}
\setbeforesecskip{-8ex}
\setaftersecskip{4ex}
\setsubsecheadstyle{\raggedright\normalsize\itshape\sffamily}
\setbeforesubsecskip{-8ex}
\setaftersubsecskip{3ex}
\setsubsubsecheadstyle{\raggedright\small\itshape\sffamily}
\setbeforesubsubsecskip{-6ex}
\setaftersubsubsecskip{2ex}
\setparaheadstyle{\raggedright\normalsize\sffamily}
\setafterparaskip{0pt}
\setbeforeparaskip{-5ex}

% Paragraph break
\newcommand{\parabreak}{%
	\fancybreak{%
		\vspace{\baselineskip}
		\color{smallornament}\Large\decofourleft
		\vspace{\baselineskip}
	}
}

%%
%% Tops and tails
%%

\makepagestyle{simple}
\makeevenfoot{simple}{\color{darkergray}\thepage}{}{}
\makeoddfoot{simple}{}{}{\color{darkergray}\thepage}

% Empty part and chapter page style
\aliaspagestyle{part}{empty}
\aliaspagestyle{chapter}{simple}

\makepagestyle{fancyheadings}
\nouppercaseheads
\makeevenhead{fancyheadings}{\mbox{\llap{\small\thepage\kern1em\color{halfgray}%
			\vline}%
		\color{halfgray}\hspace{0.5em}\rightmark\hfil}}{}{}
\makeoddhead{fancyheadings}{}{}{\mbox{\hfil{\color{halfgray}%
			\leftmark\hspace{0.5em}}%
		\rlap{\small{\color{halfgray}\vline}\kern1em\thepage}}}
\makeevenfoot{fancyheadings}{}{}{}
\makeoddfoot{fancyheadings}{}{}{}
\makepsmarks{fancyheadings}{%
	\def\chaptermark##1{%
		\markboth{\sffamily\textbf{##1}}%
				 {\sffamily\textbf{##1}}%
		}%
	\def\sectionmark##1{%
		\markright{\normalfont\sffamily\thesection~##1}%
		}%
	\def\subsectionmark##1{%
		\markright{\normalfont\sffamily\thesubsection~##1}%
		}%
	}

%%
%% Lists
%%

% Table of Contents
\maxtocdepth{section}

\renewcommand{\cftpartfont}{\large}
\renewcommand{\cftpartaftersnumb}{}
\renewcommand{\cftpartpresnum}{}
\renewcommand{\cftpartleader}{}
\renewcommand{\cftpartafterpnum}{\cftparfillskip}
\cftsetindents{part}{0em}{0em}
\renewcommand{\partnumberline}[1]{}
\cftpagenumbersoff{part}
\setlength{\cftbeforepartskip}{2em}
\newcommand{\tocpartskip}{\vspace{\cftbeforepartskip}}

\renewcommand{\cftchapterfont}{\normalfont\normalsize}
\renewcommand{\cftchapterpagefont}{\normalfont\normalsize}
\renewcommand{\cftchapterpresnum}{\hspace*{-1.5em}\color{tocchapnum}}
\cftsetindents{chapter}{0em}{0em}
\renewcommand{\cftchapterleader}{}
\renewcommand{\cftchapterafterpnum}{\cftparfillskip}
\setlength{\cftbeforechapterskip}{0.6em}

\renewcommand{\cftsectionfont}{\normalfont\normalsize}
\renewcommand{\cftsectionpagefont}{\normalfont\normalsize}
\cftsetindents{section}{0em}{2.0em}
\renewcommand{\cftsectionleader}{}
\renewcommand{\cftsectionafterpnum}{\cftparfillskip}
\setlength{\cftbeforesectionskip}{0.3em}

\renewcommand{\cftsubsectionfont}{\normalfont\normalsize}
\renewcommand{\cftsubsectionpagefont}{\normalfont\normalsize}
\cftsetindents{subsection}{1.5em}{2.5em}
\renewcommand{\cftsubsectionleader}{}
\renewcommand{\cftsubsectionafterpnum}{\cftparfillskip}
\setlength{\cftbeforesubsectionskip}{0.3em}

% Mini TOC

\RequirePackage{titletoc}

%% hack \chapter to automatically add mini TOCs
\newcommand{\chaptertocheading}{Contents}

\let\oldchapter=\chapter%
\renewcommand*{\chapter}{%
	\secdef{\Chap}{\ChapS}%
}%
\newcommand\ChapS[1]{\oldchapter*{#1}}%
\newcommand\Chap[2][]{%
	\cleartoevenpage[\thispagestyle{empty}]
	\vspace*{5em}
	\section*{\chaptertocheading}
	\startcontents[chapters]
	\printcontents[chapters]{}{0}{\setlength{\parskip}{0pt}\addtocontents{ptc}{\protect\setcounter{tocdepth}{2}}}
	\oldchapter[#1]{#2}
	\acresetall
}%
\newcommand{\notocchapter}[2][]{%
	\startcontents[chapters]
	\oldchapter[#1]{#2}
	\acresetall
}%


% List of Figures/Tables
\renewcommand{\cftfigureleader}{ }
\renewcommand{\cftfigureafterpnum}{\cftparfillskip}

\renewcommand{\cfttableleader}{ }
\renewcommand{\cfttableafterpnum}{\cftparfillskip}

% Enumeratable list
\newenvironment{enum}{%
  \begin{list}{\arabic{enumi})}{%
    \setlength{\topsep}{.5\onelineskip}
    \setlength{\partopsep}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\itemsep}{1ex}
    \setlength{\leftmargin}{3ex}
    \setlength{\itemindent}{0pt}
    \usecounter{enumi}
  }
}{\end{list}}

% Roman enumeratable list
\newenvironment{renum}{%
	\begin{list}{\roman{enumi})}{%
			\setlength{\topsep}{.5\onelineskip}
			\setlength{\partopsep}{0pt}
			\setlength{\parsep}{0pt}
			\setlength{\itemsep}{1ex}
			\setlength{\leftmargin}{4ex}
			\setlength{\itemindent}{0pt}
			\usecounter{enumi}
		}
	}{\end{list}}

\newcommand{\listbullet}{\small\ensuremath\blacktriangleright}

% Itemized list
\newenvironment{items}{%
  \begin{list}{\listbullet}{%
    \setlength{\topsep}{.5\onelineskip}
    \setlength{\partopsep}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\itemsep}{1ex}
    \setlength{\leftmargin}{2ex}
    \setlength{\itemindent}{0pt}
  }
}{\end{list}}

% Enumeratable list
\newenvironment{marginenum}{%
	\begin{list}{\arabic{enumi})}{%
			\setlength{\topsep}{0pt}
			\setlength{\partopsep}{0pt}
			\setlength{\parsep}{0pt}
			\setlength{\itemsep}{0ex}
			\setlength{\leftmargin}{3ex}
			\setlength{\itemindent}{0ex}
			\usecounter{enumi}
		}%
	\mpjustification%
	}{\end{list}}


% In-paragraph lists
\RequirePackage{paralist}


%%
%% Tables
%%

\RequirePackage{multirow}
\RequirePackage{bigdelim}

%%
%% Captions
%%

\captionnamefont{\normalfont\footnotesize}
\captiontitlefont{\normalfont\footnotesize}

\newfixedcaption{\figcaption}{figure}
\newfixedcaption{\tabcaption}{table}
\newfixedcaption[\legend]{\figlegend}{figure}
\newfixedcaption[\legend]{\tablegend}{table}

%%
%% Side notes/tables/figures
%%

\RequirePackage{marginnote}
\RequirePackage{mparhack}

\newcommand{\marginparfont}{\normalfont\footnotesize}
\marginparmargin{outer}

\sidecapmargin{outer}
\setsidecaps{\marginparsep}{\marginparwidth}

\newcommand{\antimpjustification}{%
	\strictpagechecktrue
	\checkoddpage
	\ifoddpage%
	\RaggedLeft%
	\else%
	\RaggedRight%
	\fi%
}
\setmpjustification{\RaggedLeft}{\RaggedRight}

\renewcommand{\sidecapstyle}{%
	\captionstyle{\mpjustification}%
	\captionnamefont{\marginparfont\color{margincolor}}%
	\captiontitlefont{\marginparfont\color{margincolor}}%
}

% The mark on the sidenote
\newcommand{\sidemark}[1]{#1.{\:}}

\newcommand{\marginelement}[2][0]{%
	\leavevmode\ignorespaces%
	\marginnote{%
		\sidecapstyle%
		\setlength{\belowdisplayskip}{0pt}%
		\setlength{\belowdisplayshortskip}{0pt}%
		\setlength{\abovedisplayskip}{0pt}%
		\setlength{\abovedisplayshortskip}{0pt}%
		\strictpagechecktrue%
		\mpjustification%
		\marginparfont\color{margincolor}#2%
	}[#1\onelineskip]%
}%

\newcommand{\sidenote}[2][0]{%
	\footnotemark%
	\ignorespaces%
	\marginelement[#1]{%
		\sidemark{\thefootnote}%
		\ignorespaces#2%
	}%
	\unskip%
}%

% Sidedef
\newcommand{\sidedef}[3]{%
	\vskip\dimexpr\abovedisplayskip-\baselineskip%
	\noindent%
	\parbox[c]{\linewidth}{%
		\setlength{\belowdisplayskip}{0pt}%
		\setlength{\belowdisplayshortskip}{0pt}%
		\setlength{\abovedisplayskip}{0pt}%
		\setlength{\abovedisplayshortskip}{0pt}%
		#3%
	}%
	\marginelement{%
		\setlength{\parskip}{0pt}%
		{\color{black}\spacedlowsmallcaps{#1}}\newline#2%
	}%
	\vspace{\belowdisplayskip}%\noindent%
}

% Sidefigure / sidetable
\newcommand{\tempcap}[2]{\relax}

\DeclareDocumentCommand{\sidefigure}{s o m o m O{0}}% star, shortcap, caption, label, figure, location
{%
	\IfBooleanTF{#1}%
		{\let\tempcap\figlegend}%
		{\let\tempcap\figcaption}%
	\marginelement[#6]{%
		\vskip-2\baselineskip%
		#5\\%
		\IfValueTF{#2}%
			{\tempcap[#2]{#3}}%
			{\tempcap{#3}}%
		\IfValueT{#4}{\label{#4}}
	}
}

\DeclareDocumentCommand{\sidetable}{s o m o m O{0}}% star, shortcap, caption, label, table, location
{%
	\IfBooleanTF{#1}%
	{\let\tempcap\tablegend}%
	{\let\tempcap\tabcaption}%
	\marginpar{%
		\setlength{\abovedisplayskip}{0pt}%
		\setlength{\belowdisplayskip}{0pt}%
		\setlength{\abovedisplayshortskip}{0pt}%
		\setlength{\belowdisplayshortskip}{0pt}%
		\vspace*{\numexpr(#6-1)\onelineskip}%
		\leavevmode%
		\mpjustification%
		\sidecapstyle%
		\marginparfont#5\\%
		\IfValueTF{#2}%
		{\color{margincolor}\tempcap[#2]{#3}}%
		{\color{margincolor}\tempcap{#3}}%
		\IfValueT{#4}{\label{#4}}
	}
}

\newcolumntype{M}[1]{>{\setlength{\parskip}{0pt}\mpjustification\arraybackslash}p{#1}}

%%
%% Environments
%%

\newlength{\wholemargin}\setlength{\wholemargin}{\marginparwidth}
\addtolength{\wholemargin}{\marginparpush}
\newlength{\wholewidth}\setlength{\wholewidth}{\textwidth}
\addtolength{\wholewidth}{\wholemargin}

% Whole environment
\newenvironment{whole}{%
  \centering
  \begin{adjustwidth*}{0em}{-\wholemargin}
  \strictpagechecktrue
  \checkoddpage
  \ifoddpage%
    \RaggedRight
  \else%
    \RaggedLeft
  \fi%
}{%
  \end{adjustwidth*}
}

\newlength{\foreminusspine}\setlength{\foreminusspine}{\foremargin}
\addtolength{\foreminusspine}{-\spinemargin}

% Centered environment
\newenvironment{centered}{%
  \begin{adjustwidth*}{0em}{-\foreminusspine}
    \centering
}{%
  \end{adjustwidth*}
}

%%
%% Floats
%%

\setFloatBlockFor{section}

%%
%% Title page
%%

\RequirePackage{wallpaper}


%%
%% Acronyms
%%

\RequirePackage{acronym}
\RequirePackage{mfirstuc}

\renewcommand*{\acsfont}[1]{\textsc{#1}}
\renewcommand*{\aclabelfont}[1]{\sfcaps{\acsfont{#1}}}

\patchcmd{\AC@@acro}{] #3}{] \capitalisewords{#3}}{}{}
\patchcmd{\AC@@acro}{] #3}{] \capitalisewords{#3}}{}{}


%%
%% Quotations and citations
%%

\PassOptionsToPackage{%
	backend=bibtex,%
	bibencoding=ascii,%
	language=auto,%
	style=authoryear-comp, % Author 1999, 2010
	bibstyle=authoryear,dashed=false, % dashed: substitute rep. author with ---
	sorting=nyt, % name, year, title
	maxbibnames=3, % default: 3, et al.
	natbib=true, % natbib compatibility mode (\citep and \citet still work)
	backref=true,
	url=false
}{biblatex}
\RequirePackage{biblatex}

\setlength\bibitemsep{.5\baselineskip}

% Citation styles
\DeclareCiteCommand{\citeauthorfull}
{\boolfalse{citetracker}%
	\boolfalse{pagetracker}%
	\DeclareNameAlias{labelname}{first-last}%
	\usebibmacro{prenote}}
{\ifciteindex
	{\indexnames{labelname}}
	{}%
	\printnames{labelname}}
{\multicitedelim}
{\usebibmacro{postnote}}

% Inline quotations
\RequirePackage{csquotes}
\newcommand{\q}[1]{\enquote{#1}}
\newcommand{\prequote}[4][]{\citet[#1]{#2} #3 \q{#4}}
\newcommand{\postquote}[3][]{\q{#3} \citep[#1]{#2}}
\newcommand{\postquoteyear}[3][]{\q{#3} \citeyearpar[#1]{#2}}

% Full quote environment
\newenvironment{fullquote}[3][]{%
  \citet[#1]{#2} #3:
  \begin{quote}
}{%
  \end{quote}
}

% Full quotation environment
\newenvironment{fullquotation}[3][]{%
  \citet[#1]{#2} #3:
  \vspace{\baselineskip}

  \slshape
}{%
  \vspace{\baselineskip}
}

% Fancy quotation environment
\newcommand*\quotefont{\fontfamily{LinuxLibertineT-LF}\color{halfgray}}
\newcommand*\quotesize{40}
\newcommand{\fancyquote}[2]{%
	\begingroup\centering%
	\mbox{\parbox[t]{.8\linewidth}{%
	 	\tikz[remember picture,overlay,xshift=-3ex,yshift=-1ex]
	 		\node (OQ) {\quotefont\fontsize{\quotesize}{\quotesize}\selectfont``};\kern0pt
		\textsl{#2}%
		\\[1ex] \hspace*{\fill}---#1%
		\tikz[remember picture,overlay,xshift=3ex,yshift=2ex]
		\node (CQ) {\quotefont\fontsize{\quotesize}{\quotesize}\selectfont''};%
	}}%
	\par%
	\endgroup%
}

%%
%% Hyperlinks
%%

\RequirePackage[hyperfootnotes=false,hypertexnames=false]{hyperref}
\hypersetup{%
	colorlinks=true,
	linkcolor=linkcolor,
	anchorcolor=black,
	citecolor=citecolor,
	urlcolor=urlcolor,
	breaklinks,
	pdfborder=0 0 0,
	plainpages=false
}

% \RequirePackage{autonum}
\RequirePackage[depth=2]{bookmark}
% break also on hyphens inside the \url command
\def\UrlBreaks{\do\.\do\@\do\\\do\/\do\!\do\_\do\|\do\;\do\>\do\]%
	\do\)\do\,\do\?\do\'\do+\do\=\do\#\do-} % \do- is new!

%\RequirePackage[pageref]{backref}

\RequirePackage{relsize}
\urlstyle{sf}
\renewcommand\UrlFont{\sffamily\smaller\relax}

%%
%% Misc
%%

\newcounter{dummy} % necessary for correct hyperlinks (to index, bib, etc.)
