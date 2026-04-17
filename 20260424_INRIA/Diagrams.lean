import VersoSlides
import Illuminate

open VersoSlides Illuminate

namespace INRIA.ModuleDiagram

def boxW : Float := 280
def boxH : Float := 50
def boxPad : Float := 12
def strokeW : Float := 0.9
def arrowStroke : Stroke := { width := strokeW }

def codeFs : FontStyle :=
  { fontFamily := "monospace", fontSize := 13, color := rgb!"#1e293b" }
def kwFs : FontStyle := { codeFs with bold := true, color := rgb!"#ff0000" }
def numFs : FontStyle := { codeFs with color := rgb!"#0550ae" }

def leftAlign (d : Diagram SVG) : Diagram SVG :=
  d.translate (- boxW / 2 + boxPad) 0

def renderLines (lines : List (List (FontStyle × String))) : Diagram SVG :=
  leftAlign $ Diagram.styledLines lines .start

def moduleLine : List (FontStyle × String) := [(kwFs, "module")]

def basicLinesOf (pub : String) (lit : String) : List (List (FontStyle × String)) :=
  [[(kwFs, pub ++ "def "), (codeFs, "f := "), (numFs, lit)]]

def defsLinesOf (pub : String) : List (List (FontStyle × String)) :=
  [[(kwFs, pub ++ "def "), (codeFs, "g := f")]]

def lemmasLinesOf (pub : String) (lit : String := "1") : List (List (FontStyle × String)) :=
  [[
    (kwFs, pub ++ "theorem "), (codeFs, "t : f = "), (numFs, lit),
    (codeFs, " := rfl")
  ]]

def mainLinesOf (pub : String) : List (List (FontStyle × String)) :=
  [[(kwFs, pub ++ "def "), (codeFs, "main ...")]]

def basicCodeOf (pub : String) (lit : String) : Diagram SVG :=
  renderLines (basicLinesOf pub lit)
def defsCodeOf (pub : String) : Diagram SVG := renderLines (defsLinesOf pub)
def lemmasCodeOf (pub : String) : Diagram SVG := renderLines (lemmasLinesOf pub)
def mainCodeOf (pub : String) : Diagram SVG := renderLines (mainLinesOf pub)

def importText (s : String) : Diagram SVG :=
  Diagram.text s { fontSize := 10, fontFamily := "mono" }

def importLabel : Diagram SVG := importText "import"

def buildDiagram (basic defs lemmas main : Diagram SVG)
    (topLabel : Diagram SVG := importLabel)
    (leftLabel : Diagram SVG := importLabel) : Diagram SVG :=
  Diagram.vsep 90 [
    .hsep 90 [basic, defs],
    .hsep 90 [lemmas, main]
  ]
  |>.connect `defs.west { point := `basic.east, arrowhead := some { type := .stealth } }
      (stroke := arrowStroke) (label := some topLabel)
  |>.connect `lemmas.north { point := `basic.south, arrowhead := some { type := .stealth } }
      (stroke := arrowStroke) (label := some leftLabel)
  |>.connect `main.north { point := `defs.south, arrowhead := some { type := .stealth } }
      (stroke := arrowStroke) (label := some importLabel)
  |>.connect `main.west { point := `lemmas.east, arrowhead := some { type := .stealth } }
      (stroke := arrowStroke) (label := some importLabel)

def plainBox (n : Lean.Name) (content : Diagram SVG) : Diagram SVG :=
  let shell := Diagram.rect boxW boxH
    (fill := rgb!"#ffffff") (stroke := { width := strokeW })
    (name := n)
  Diagram.atop content shell

def pendingColor : Color := rgb!"#f0a050"
def builtColor : Color := rgb!"#ffffff"

def animatedBox (n : Lean.Name) (content : Diagram SVG) (progress : Float) : Diagram SVG :=
  let p := Max.max 0.0 (Min.min 1.0 progress)
  let h := boxH * p
  let mkShell (clr : Color) (name : Option Lean.Name) : Diagram SVG :=
    Diagram.rect boxW boxH
      (fill := clr) (stroke := { width := strokeW })
      (name := name)
  let pendingLayer :=
    Diagram.translate 0 (- h / 2) $
    Diagram.clipRect boxW (boxH - h) $
    Diagram.translate 0 (h / 2) $
    mkShell pendingColor none
  let builtLayer := mkShell builtColor (some n)
  Diagram.refocus builtLayer $
    Diagram.atop content
      (Diagram.compose builtLayer pendingLayer)

def phase (lo hi t : Float) : Float :=
  Max.max 0.0 (Min.min 1.0 ((t - lo) / (hi - lo)))

-- Slide 1: build animation
def buildAnim : SlideAnimation where
  steps := [{ duration := 4.0, pause := true }]
  render := fun v =>
    let t := v[0]
    let boxFor (n : Lean.Name) (content : Diagram SVG) (lo hi : Float) : Diagram SVG :=
      if t < lo then plainBox n content
      else animatedBox n content (phase lo hi t)
    buildDiagram
      (boxFor `basic (basicCodeOf "public " "1") 0.05 0.22)
      (boxFor `defs (lemmasCodeOf "public ") 0.22 0.6)
      (boxFor `lemmas (defsCodeOf "public ") 0.22 0.4)
      (boxFor `main (mainCodeOf "public ") 0.6 0.80)

-- Slide 2: module system rebuild animation
def rebuildAnim : SlideAnimation where
  steps := [{ duration := 6.0, pause := true }]
  render := fun v =>
    let totalSec : Float := 6.0
    let secT := v[0] * totalSec
    let change : Float := 0.0
    let greenEnd : Float := change + 1.56
    let green : Color := rgb!"#b9f6c5"
    let pauseDur : Float := 0.4
    let basicDur : Float := (0.22 - 0.05) * 4.0
    let defsDur : Float := (0.6 - 0.22) * 4.0
    let basicStart : Float := pauseDur
    let basicEnd : Float := basicStart + basicDur
    let defsStart : Float := basicEnd
    let defsEnd : Float := defsStart + defsDur
    let lit := if secT <= change then "1" else "2"
    let litOpacity := if secT <= change then 0.0 else 1.0 - phase change greenEnd secT
    let lineHeight : Float := codeFs.fontSize * 1.2
    let highlightedCode (pre : String) (lines : List (List (FontStyle × String))) : Diagram SVG :=
      let monoCharW : Float := codeFs.fontSize * 0.6
      let prefixW := pre.length.toFloat * monoCharW
      let litW := lit.length.toFloat * monoCharW
      let litCenterX := - boxW / 2 + boxPad + prefixW + litW / 2
      let litCenterY := - lineHeight / 2
      let highlight :=
        Diagram.rect (litW + 4) 18
          (fill := green) (stroke := { width := 0 })
        |>.cellophane litOpacity
        |>.translate litCenterX litCenterY
      Diagram.compose highlight (renderLines lines)
    let basicCode := highlightedCode "public def f := " (basicLinesOf "public " lit)
    let lemmasCode := renderLines
      [[(kwFs, "public theorem "), (codeFs, "t : f > "), (numFs, "0"), (codeFs, " := ...")]]
    let basicProgress := if secT < basicStart then 1.0 else phase basicStart basicEnd secT
    let defsProgress := if secT < defsStart then 1.0 else phase defsStart defsEnd secT
    buildDiagram
      (animatedBox `basic basicCode basicProgress)
      (animatedBox `defs lemmasCode defsProgress)
      (plainBox `lemmas (renderLines (defsLinesOf "public ")))
      (plainBox `main (renderLines (mainLinesOf "public ")))
      (topLabel := importText "import all")

-- Slide: separate compilation — .ir boxes fade in, .exe stays, .exe→main arrow fades out
def separateCompAnim : SlideAnimation where
  steps := [{ duration := 1.5, pause := true, fragmentIndex := some 0 }]
  render := fun v =>
    let opacity := Easing.easeInOut v[0]
    let withModule (lines : List (List (FontStyle × String))) :=
      moduleLine :: lines
    let irBoxW : Float := 40
    let irBoxH : Float := 28
    let gap : Float := 8
    let irDx : Float := 30
    let irDy : Float := -(boxH / 2 + gap + irBoxH / 2)
    let exeDx : Float := irBoxW + gap
    let smallBox (n : Lean.Name) (label : String) (bg : Color := rgb!"#f0f0f0") : Diagram SVG :=
      let shell := Diagram.rect irBoxW irBoxH
        (fill := bg) (stroke := { width := strokeW })
        (name := n)
      Diagram.atop (Diagram.text label { fontSize := 11, fontFamily := "monospace" }) shell
    -- Invisible named boxes with the same envelopes as their visible counterparts,
    -- used in non-drawing layers so arrows can still resolve their anchors.
    let invBox (n : Lean.Name) : Diagram SVG := (plainBox n .empty).cellophane 0
    let invSmallBox (n : Lean.Name) : Diagram SVG := (smallBox n "").cellophane 0
    -- Cell helpers: attach .ir and/or .exe to a source cell; envelope stays = src
    let cellIr (src ir : Diagram SVG) : Diagram SVG :=
      Diagram.refocus src $ Diagram.compose src (ir.translate irDx irDy)
    let cellIrExe (src ir exe : Diagram SVG) : Diagram SVG :=
      Diagram.refocus src $
        Diagram.compose src $
          Diagram.compose (ir.translate irDx irDy) (exe.translate (irDx + exeDx) irDy)
    let cellExe (src exe : Diagram SVG) : Diagram SVG :=
      Diagram.refocus src $ Diagram.compose src (exe.translate (irDx + exeDx) irDy)
    -- Layer 1 (always visible): source boxes, .exe, and source import arrows
    let srcDiag :=
      buildDiagram
        (plainBox `basic (renderLines (withModule (basicLinesOf "public " "1"))))
        (plainBox `defs (renderLines (withModule (lemmasLinesOf "public "))))
        (plainBox `lemmas (renderLines (withModule (defsLinesOf "public "))))
        (cellExe
          (plainBox `main (renderLines (withModule (mainLinesOf "public "))))
          (smallBox `exe ".exe" (bg := rgb!"#e8e8ff")))
        (topLabel := importText "import all")
        (leftLabel := importText "meta import")
      |>.padBottom (gap + irBoxH)
    -- Layer 2 (fades in): .ir boxes and all .ir-related arrows. Invisible src/exe
    -- provide anchors; real boxes remain in srcDiag so nothing is drawn twice.
    let fadeInGrid := Diagram.vsep 90 [
      .hsep 90 [
        cellIr (invBox `basic) (smallBox `basicIr ".ir"),
        cellIr (invBox `defs) (smallBox `defsIr ".ir")
      ],
      .hsep 90 [
        cellIr (invBox `lemmas) (smallBox `lemmasIr ".ir"),
        cellIrExe (invBox `main) (smallBox `mainIr ".ir") (invSmallBox `exe)
      ]
    ] |>.padBottom (gap + irBoxH)
    let fadeInLayer := fadeInGrid
      -- .ir → source arrows
      |>.connectEdge `basicIr `basic (arrowhead := some { type := .stealth }) (stroke := arrowStroke)
      |>.connectEdge `lemmas `basicIr (arrowhead := some { type := .stealth }) (stroke := arrowStroke)
      |>.connectEdge `defsIr `defs (arrowhead := some { type := .stealth }) (stroke := arrowStroke)
      |>.connectEdge `lemmasIr `lemmas (arrowhead := some { type := .stealth }) (stroke := arrowStroke)
      |>.connectEdge `mainIr `main (arrowhead := some { type := .stealth }) (stroke := arrowStroke)
      -- .ir → .ir import arrows
      |>.connect `defsIr.west { point := `basicIr.east, arrowhead := some { type := .stealth } }
          (stroke := arrowStroke)
      |>.connect `lemmasIr.north { point := `basicIr.south, arrowhead := some { type := .stealth } }
          (stroke := arrowStroke)
      |>.connect `mainIr.north { point := `defsIr.south, arrowhead := some { type := .stealth } }
          (stroke := arrowStroke)
      |>.connect `mainIr.west { point := `lemmasIr.east, arrowhead := some { type := .stealth } }
          (stroke := arrowStroke)
      -- .exe → mainIr arrow
      |>.connect `exe.west { point := `mainIr.east, arrowhead := some { type := .stealth } }
          (stroke := arrowStroke)
      |>.cellophane opacity
    -- Layer 3 (fades out): .exe → main arrow
    let fadeOutGrid := Diagram.vsep 90 [
      .hsep 90 [invBox `basic, invBox `defs],
      .hsep 90 [invBox `lemmas, cellExe (invBox `main) (invSmallBox `exe)]
    ] |>.padBottom (gap + irBoxH)
    let fadeOutLayer := fadeOutGrid
      |>.connect `exe.west { point := `main.south, arrowhead := some { type := .stealth } }
          (stroke := arrowStroke)
      |>.cellophane (1.0 - opacity)
    -- Compose: fade-in (bottom), fade-out (middle), always-visible (top)
    Diagram.refocus srcDiag $
      Diagram.compose fadeInLayer $
        Diagram.compose fadeOutLayer srcDiag

end INRIA.ModuleDiagram
