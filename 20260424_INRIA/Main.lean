import VersoSlides
import Slides

open VersoSlides

def main (args : List String) : IO UInt32 := do
  let config : Config := { center := false, margin := 0 }
  let rc ← slidesMain (config := config) (doc := %doc Slides) (args := args)
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
  let titleSlideOld := "<section>\n          <h2>\n            A deep dive into Lean's processing pipeline</h2>\n          <p>\n            Sebastian Ullrich, Lean FRO</p>\n          <p>\n            INRIA, April 24, 2026</p>\n          </section>"
  let titleSlideNew := "<section class=\"title-slide\">\n          <div class=\"top-area\"><img class=\"logo\" src=\"lean-logo-large.png\" alt=\"Lean Logo\"></div>\n          <div class=\"blue-band\"><h1>A deep dive into Lean's processing pipeline</h1>\n          <div class=\"meta\"><strong>Sebastian Ullrich</strong><br>Lean FRO</div>\n          <div class=\"date\">INRIA | April 24, 2026</div>\n          </div></section>"
  let html := html.replace titleSlideOld titleSlideNew
  let slideHeader := "<div class=\"slide-header\"><img src=\"lean-logo.png\" alt=\"Lean\"></div>"
  let html := html.replace "<section>\n" s!"<section>\n          {slideHeader}\n"
  let html := html.replace "<section data-transition=\"fade\">\n" s!"<section data-transition=\"fade\">\n          {slideHeader}\n"
  -- Strip trailing blank line inside the final `inter-text` span of every Lean code block.
  let html := html.replace "\n\n</span><span class=\"unknown token\" data-binding=\"\"></span></code>" "</span><span class=\"unknown token\" data-binding=\"\"></span></code>"
  IO.FS.writeFile htmlPath html
  return rc
