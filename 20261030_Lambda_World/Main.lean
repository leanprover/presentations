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
  IO.FS.writeFile htmlPath html
  return rc
