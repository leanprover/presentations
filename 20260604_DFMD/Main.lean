import VersoSlides
import Slides

open VersoSlides

/-- Content after the first occurrence of `sep`; `none` if `sep` is absent. -/
def afterFirst (s sep : String) : Option String :=
  match s.splitOn sep with
  | _ :: r :: rs => some (String.intercalate sep (r :: rs))
  | _ => none

/-- Content before the first occurrence of `sep` (or all of `s` if absent). -/
def beforeFirst (s sep : String) : String :=
  (s.splitOn sep).headD s

/-- Trimmed inner text of the first `<tag>…</tag>`; `none` if there is none. -/
def tagInner (s tag : String) : Option String :=
  (afterFirst s s!"<{tag}>").map (fun r => (beforeFirst r s!"</{tag}>").trimAscii.toString)

/-- Trimmed inner text of every `<p>…</p>` in `block`. -/
def paragraphs (block : String) : List String :=
  match block.splitOn "<p>" with
  | _ :: rest => rest.map (fun c => (beforeFirst c "</p>").trimAscii.toString)
  | _ => []

/-- Rebuild one blue section's inner HTML into the logo + blue-band layout.
    The heading drives the title, the last paragraph the date line, and any
    paragraphs in between the meta block (first one bolded as the name). -/
def renderTitleSlide (inner : String) : String :=
  let heading := (tagInner inner "h2").getD ""
  let ps := paragraphs inner
  let (metaLines, dateLine) :=
    match ps.reverse with
    | last :: rest => (rest.reverse, last)
    | [] => ([], "")
  let metaHtml := match metaLines with
    | [] => ""
    | name :: tl => String.intercalate "<br>" (s!"<strong>{name}</strong>" :: tl)
  s!"<section class=\"title-slide\">\n          <div class=\"top-area\"><img class=\"logo\" src=\"lean-logo-large.png\" alt=\"Lean Logo\"></div>\n          <div class=\"blue-band\"><h1>{heading}</h1>\n          <div class=\"meta\">{metaHtml}</div>\n          <div class=\"date\">{dateLine}</div>\n          </div></section>"

/-- Transform the title (first) and closing (last) blue sections into the
    logo + blue-band layout, driven by each slide's own content. The blue
    section-break slides in between share the same markup, so they are matched
    by position and left untouched. -/
def transformTitleSlides (html : String) : String :=
  let marker := "<section data-background-color=\"#0073A3\">"
  match html.splitOn marker with
  | [] => html
  | first :: rest =>
    let n := rest.length
    let rebuilt := rest.mapIdx (fun i chunk =>
      if i == 0 || i == n - 1 then
        let inner := beforeFirst chunk "</section>"
        let after := (afterFirst chunk "</section>").getD chunk
        renderTitleSlide inner ++ after
      else
        -- Re-attach the marker consumed by `splitOn`; leave the slide as-is.
        marker ++ chunk)
    String.join (first :: rebuilt)

def main : IO UInt32 := do
  let config : Config := { center := false, margin := 0, theme := "white", transition := "none", controls := false }
  let rc ← slidesMain (config := config) (doc := %doc Slides)
  let outputDir := config.outputDir
  let cssContents ← IO.FS.readFile "../static/custom.css"
  let overrideContents ← IO.FS.readFile "overrides.css"
  IO.FS.writeFile (outputDir / "custom.css") (cssContents ++ "\n" ++ overrideContents)
  let logoBytes ← IO.FS.readBinFile "../static/lean-logo.png"
  IO.FS.writeBinFile (outputDir / "lean-logo.png") logoBytes
  let logoLargeBytes ← IO.FS.readBinFile "../static/lean-logo-large.png"
  IO.FS.writeBinFile (outputDir / "lean-logo-large.png") logoLargeBytes
  let htmlPath := outputDir / "index.html"
  let html ← IO.FS.readFile htmlPath
  let html := html.replace "</head>" "<link rel=\"stylesheet\" href=\"custom.css\">\n    </head>"
  let html := html.replace "Reveal.initialize({" "Reveal.initialize({\n        disableLayout: true,"
  let slideHeader := "<div class=\"slide-header\"><img src=\"lean-logo.png\" alt=\"Lean\"></div>"
  let html := html.replace "<section>\n" s!"<section>\n          {slideHeader}\n"
  let html := html.replace "<section data-transition=\"fade\">\n" s!"<section data-transition=\"fade\">\n          {slideHeader}\n"
  -- Transform the title & closing slides (the blue, non-transition sections)
  -- into the logo + blue-band layout, driven by each slide's own content so
  -- changing the title/author/date in Slides.lean needs no edits here.
  let html := transformTitleSlides html
  -- Image class hooks (applied via alt-text matching).
  let html := html.replace "alt=\"Mathlib dependency graph\"" "alt=\"Mathlib dependency graph\" class=\"img-tall\""
  let html := html.replace "alt=\"Nature article on LTE\"" "alt=\"Nature article on LTE\" class=\"img-tall\""
  let html := html.replace "alt=\"Cedar QED comparison\"" "alt=\"Cedar QED comparison\" class=\"img-wide\""
  let html := html.replace "alt=\"Cedar differential testing\"" "alt=\"Cedar differential testing\" class=\"img-wide\""
  let html := html.replace "alt=\"SymCrypt verification with Aeneas\"" "alt=\"SymCrypt verification with Aeneas\" class=\"img-wide\""
  let html := html.replace "alt=\"Veil: ring leader election\"" "alt=\"Veil: ring leader election\" class=\"img-tall\""
  let html := html.replace "alt=\"CSLib: adding to CS foundations\"" "alt=\"CSLib: adding to CS foundations\" class=\"img-wide\""
  let html := html.replace "alt=\"Anneal logo\"" "alt=\"Anneal logo\" class=\"img-small\""
  let html := html.replace "alt=\"Strata logo\"" "alt=\"Strata logo\" class=\"img-small\""
  let html := html.replace "alt=\"40 lines replaced by one grind call\"" "alt=\"40 lines replaced by one grind call\" class=\"img-tall\""
  let html := html.replace "alt=\"Tao on grind\"" "alt=\"Tao on grind\" class=\"img-full\""
  let html := html.replace "alt=\"Andres' Challenge tactics time by goal size\"" "alt=\"Andres' Challenge tactics time by goal size\" class=\"img-wide\""
  let html := html.replace "alt=\"MetaM vs SymM tactic time\"" "alt=\"MetaM vs SymM tactic time\" class=\"img-wide\""
  let html := html.replace "alt=\"SymM with simplifier cache reuse\"" "alt=\"SymM with simplifier cache reuse\" class=\"img-wide\""
  let html := html.replace "alt=\"Tactic time by example size\"" "alt=\"Tactic time by example size\" class=\"img-wide\""
  let html := html.replace "alt=\"Kernel checking time by example size\"" "alt=\"Kernel checking time by example size\" class=\"img-wide\""
  let html := html.replace "alt=\"Proof size by example size\"" "alt=\"Proof size by example size\" class=\"img-wide\""
  let html := html.replace "alt=\"Tactic time\"" "alt=\"Tactic time\" class=\"img-wide\""
  let html := html.replace "alt=\"Kernel time\"" "alt=\"Kernel time\" class=\"img-wide\""
  let html := html.replace "alt=\"Dafny vs Velvet vs Velvet + Loom2 verification time\"" "alt=\"Dafny vs Velvet vs Velvet + Loom2 verification time\" class=\"img-wide\""
  let html := html.replace "alt=\"Verso: source and rendered output\"" "alt=\"Verso: source and rendered output\" class=\"img-tall\""
  -- Replace grind pipeline text with a boxed-step diagram.
  let pipelineOld := "<strong>Pipeline</strong>: Lean Goal → Preprocessing → Internalization → <strong>E-graph</strong> ⇔ cutsat ⇔ rings ⇔ linarith"
  let pipelineNew :=
    "</p><div class=\"pipeline\">" ++
    "<div class=\"step\">Lean Goal</div><span class=\"arrow\">→</span>" ++
    "<div class=\"step\">Preprocessing</div><span class=\"arrow\">→</span>" ++
    "<div class=\"step\">Internalization</div><span class=\"arrow\">→</span>" ++
    "<div class=\"step highlight\">E-graph</div><span class=\"arrow\">↔</span>" ++
    "<div class=\"step\">cutsat</div><span class=\"arrow\">↔</span>" ++
    "<div class=\"step\">rings</div><span class=\"arrow\">↔</span>" ++
    "<div class=\"step\">linarith</div><span class=\"arrow\">↔</span>" ++
    "<div class=\"step\">orders</div><span class=\"arrow\">↔</span>" ++
    "<div class=\"step\">ac</div>" ++
    "</div><p>"
  let html := html.replace pipelineOld pipelineNew
  IO.FS.writeFile htmlPath html
  return rc
